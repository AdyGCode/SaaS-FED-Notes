#!/usr/bin/env bash

# ==========================================
# Set Up Script for Students
# Version 1.3
# Author: Adrian Gould & Copilot
# ==========================================

set -o pipefail

LOG_FILE="installation.log"
STATE_FILE="installation.conf"
ENV_EXAMPLE=".env.example"
ENV_FILE=".env"

MAX_RETRIES=2
RETRY_DELAY=2

# ==========================================
# Helpers
# ==========================================

timestamp() {
  date +"[%d/%b/%Y:%H:%M:%S %z]"
}

log() {
  echo "$(timestamp) $1" | tee -a "$LOG_FILE"
}

step_done() {
  grep -q "^$1: done" "$STATE_FILE" 2>/dev/null
}

mark_done() {
  sed -i "/^$1:/d" "$STATE_FILE" 2>/dev/null
  echo "$1: done" >> "$STATE_FILE"
}

mark_failed() {
  sed -i "/^$1:/d" "$STATE_FILE" 2>/dev/null
  echo "$1: failed" >> "$STATE_FILE"
}

# ==========================================
# Spinner
# ==========================================

spinner() {
  local pid=$!
  local delay=0.1
  local spinstr='|/-\'

  while ps -p $pid > /dev/null 2>&1; do
    printf " [%c]  " "$spinstr"
    spinstr=${spinstr#?}${spinstr%${spinstr#?}}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done
  printf "    \b\b\b\b"
}

# ==========================================
# Retry Logic
# ==========================================

run_with_retry() {
  local CMD="$1"
  local attempt=1

  while [ $attempt -le $MAX_RETRIES ]; do
    log "Attempt $attempt/$MAX_RETRIES: $CMD"

    bash -c "$CMD" >>"$LOG_FILE" 2>&1 &
    spinner
    wait $!
    STATUS=$?

    if [ $STATUS -eq 0 ]; then
      return 0
    fi

    log "⚠️ Failed attempt $attempt"

    if [ $attempt -lt $MAX_RETRIES ]; then
      log "Retrying in ${RETRY_DELAY}s..."
      sleep $RETRY_DELAY
    fi

    attempt=$((attempt + 1))
  done

  return 1
}

# ==========================================
# Package Manager Detection
# ==========================================

detect_node_package_manager() {
  if command -v pnpm >/dev/null 2>&1; then
    PKG_MANAGER="pnpm"
  else
    PKG_MANAGER="npm"
  fi

  log "Using package manager: $PKG_MANAGER"
}

# ==========================================
# Step Runner
# ==========================================

run_step() {
  STEP_NAME="$1"
  CMD="$2"

  if step_done "$STEP_NAME"; then
    log "⏩ Skipping $STEP_NAME (already done)"
    return 0
  fi

  log "▶ STEP: $STEP_NAME"
  log "💻 Running: $CMD"

  eval "$CMD"
  STATUS=$?

  if [ $STATUS -ne 0 ]; then
    log "❌ FAILED: $STEP_NAME"
    log "👉 Check installation.log for details"
    log "👉 Fix the error and re-run this script"
    mark_failed "$STEP_NAME"
    exit 1
  fi

  log "✅ SUCCESS: $STEP_NAME"
  mark_done "$STEP_NAME"
}

# ==========================================
# Validation
# ==========================================

validate_php() {
  if ! command -v php >/dev/null; then
    log "❌ PHP is not installed"
    exit 1
  fi

  VERSION=$(php -r "echo PHP_VERSION;")
  log "PHP version: $VERSION"
}

validate_port() {
  if lsof -i :8000 >/dev/null 2>&1; then
    log "⚠️ Port 8000 already in use"
  fi
}

# ==========================================
# START
# ==========================================

log "🚀 Starting setup..."

# ==========================================
# Ensure env.example exists
# ==========================================

if [ ! -f ".env.example" ]; then
  echo "❌ .env.example is missing."

  if command -v curl >/dev/null 2>&1; then
    echo "👉 Attempting to download a default from Laravel..."
    curl -s https://raw.githubusercontent.com/laravel/laravel/master/.env.example \
      -o .env.example
  fi

  if [ ! -f ".env.example" ]; then
    echo "❌ Could not retrieve .env.example."
    echo "👉 Please restore it from the repository or create it manually."
    exit 1
  else
    echo "✅ Default .env.example downloaded (check values match your version)."
  fi
fi

# ==========================================
# Create .env
# ==========================================

run_step "env_file" "
if [ ! -f $ENV_FILE ]; then
  cp $ENV_EXAMPLE $ENV_FILE
fi
"

# ==========================================
# Check placeholders
# ==========================================

run_step "env_check" "
if grep -q 'FILL_' $ENV_FILE; then
  echo '⚠️ .env contains FILL_ placeholders'
else
  echo '✅ .env appears configured'
fi
"

validate_php
validate_port

# ==========================================
# Cleanup Composer (if not already done)
# ==========================================

run_step "cleanup_composer" "
if ! step_done composer_install; then
  if [ -d vendor ]; then
    echo 'Removing existing vendor directory...'
    rm -rf vendor
  fi
else
  echo 'Composer already completed, no cleanup needed'
fi
"

# ==========================================
# Composer
# ==========================================

run_step "composer_install" "run_with_retry 'composer install'"

# ==========================================
# Laravel key
# ==========================================

run_step "app_key" "php artisan key:generate"

# ==========================================
# SQLite setup
# ==========================================

run_step "sqlite_file" "
mkdir -p database

if [ ! -f database/database.sqlite ]; then
  echo 'Creating SQLite database file...'
  touch database/database.sqlite
else
  echo 'SQLite database already exists'
fi
"

# ==========================================
# Migrate
# ==========================================

run_step "migrate" "php artisan migrate:fresh --seed"

# ==========================================
# Cleanup Node Modules (if not already done)
# ==========================================

run_step "cleanup_node" "
if ! step_done node_install; then
  if [ -d node_modules ]; then
    echo 'Removing existing node_modules directory...'
    rm -rf node_modules
  fi
else
  echo 'Node install already completed, no cleanup needed'
fi
"

# ==========================================
# Node install (pnpm + fallback)
# ==========================================

detect_node_package_manager

run_step "node_install" "
set CI=true
if [ \"$PKG_MANAGER\" = 'pnpm' ]; then

  echo '▶ Trying pnpm install...'

  if run_with_retry 'pnpm install --no-frozen-lockfile --shamefully-hoist'; then
    echo '✅ pnpm install succeeded'

  else
    echo '⚠️ pnpm failed, approving builds...'
    if run_with_retry 'pnpm approve-builds --all >> \"$LOG_FILE\" 2>&1'; then

        echo '🔁 Retrying pnpm install...'
        if run_with_retry 'pnpm install --no-frozen-lockfile --shamefully-hoist'; then
          echo '✅ pnpm succeeded after approval'
        fi

    else
      echo '⚠️ Falling back to npm...'

      if run_with_retry 'npm install'; then
        echo '✅ npm fallback succeeded'
      else
        echo '❌ Both pnpm and npm failed'
        exit 1
      fi
    fi
  fi

else
  run_with_retry 'npm install'
fi
"

# ==========================================
# COMPLETE
# ==========================================

log "🎉 Setup complete!"

echo ""
echo "======================================"
echo "✅ READY TO RUN"
echo "======================================"
echo ""
echo "Run the app in development mode:"
echo ""
echo "👉 composer run dev"
echo ""
