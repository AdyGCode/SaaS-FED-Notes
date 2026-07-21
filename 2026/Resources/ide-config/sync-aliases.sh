#!/bin/sh

# === CONFIG ===
REPO_DIR=$(pwd)
CHECKSUM_FILE="$REPO_DIR/checksums.txt"
HOME_DIR="$HOME"
WIN_DIR="/c/users/$USERNAME"
LOG_FILE="$REPO_DIR/sync.log"
AUTO_MODE=false
DRY_RUN=false
FILES=".aliases .bashrc"
CHANGED=""
SKIPPED=""
COPIED=""

# === COLORS ===
RED=$(printf '\033[0;31m')
GREEN=$(printf '\033[0;32m')
YELLOW=$(printf '\033[1;33m')
BLUE=$(printf '\033[0;34m')
NC=$(printf '\033[0m')

# === FUNCTIONS ===
log() { printf "%s\n" "$1" >> "$LOG_FILE"; }
print_info() { printf "%s[INFO]%s %s\n" "$BLUE" "$NC" "$1"; log "[INFO] $1"; }
print_warn() { printf "%s[WARN]%s %s\n" "$YELLOW" "$NC" "$1"; log "[WARN] $1"; }
print_error() { printf "%s[ERROR]%s %s\n" "$RED" "$NC" "$1"; log "[ERROR] $1"; }
print_success() { printf "%s[OK]%s %s\n" "$GREEN" "$NC" "$1"; log "[OK] $1"; }

show_help() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  --auto     Run in full automation mode (no prompts).
  --dry-run  Show actions without making changes.
  --help     Display this help message.

Description:
  Sync .aliases and .bashrc from the repository to user directories:
  - Creates/updates checksum file in repo.
  - Compares files in ~/ and Windows equivalent (/c/users/USERNAME).
  - Copies files if different, with backups.
  - Logs actions to sync.log.
  - Supports dry-run and automation modes.

EOF
  exit 0
}

# Detect checksum command
if command -v sha256sum >/dev/null 2>&1; then
  SUM_CMD="sha256sum"
elif command -v shasum >/dev/null 2>&1; then
  SUM_CMD="shasum -a 256"
else
  print_error "No checksum tool found (sha256sum or shasum)."
  exit 1
fi

update_checksums() {
  print_info "Updating checksum file in repo..."
  : > "$CHECKSUM_FILE"
  for file in $FILES; do
    $SUM_CMD "$REPO_DIR/$file" >> "$CHECKSUM_FILE"
  done
}

verify_checksums() {
  print_info "Verifying checksum file..."
  TMP=$(mktemp)
  for file in $FILES; do
    $SUM_CMD "$REPO_DIR/$file" >> "$TMP"
  done
  if ! diff "$CHECKSUM_FILE" "$TMP" >/dev/null; then
    print_warn "Checksum file is outdated. Updating..."
    update_checksums
  else
    print_success "Checksum file is up-to-date."
  fi
  rm "$TMP"
}

backup_file() {
  DEST="$1"
  if [ -f "$DEST" ]; then
    if $DRY_RUN; then
      print_info "[DRY-RUN] Would create backup: $DEST.bak"
    else
      cp "$DEST" "$DEST.bak"
      print_info "Backup created: $DEST.bak"
    fi
  fi
}

compare_and_sync() {
  for file in $FILES; do
    SRC="$REPO_DIR/$file"
    if [ ! -f "$SRC" ]; then
      print_error "$file not found in repo. Skipping."
      SKIPPED="$SKIPPED\n$file (missing in repo)"
      continue
    fi

    for TARGET_DIR in "$HOME_DIR" "$WIN_DIR"; do
      [ ! -d "$TARGET_DIR" ] && continue
      DEST="$TARGET_DIR/$file"

      if [ -f "$DEST" ]; then
        SRC_SUM=$($SUM_CMD "$SRC" | awk '{print $1}')
        DEST_SUM=$($SUM_CMD "$DEST" | awk '{print $1}')
        if [ "$SRC_SUM" != "$DEST_SUM" ]; then
          print_warn "$file differs in $TARGET_DIR"
          if $AUTO_MODE; then
            backup_file "$DEST"
            if $DRY_RUN; then
              print_info "[DRY-RUN] Would overwrite $DEST"
            else
              cp "$SRC" "$DEST"
              print_success "Overwritten $DEST"
              CHANGED="$CHANGED $DEST"
            fi
          else
            printf "Overwrite $DEST with repo version? (y/n): "
            read choice
            if [ "$choice" = "y" ]; then
              backup_file "$DEST"
              if $DRY_RUN; then
                print_info "[DRY-RUN] Would overwrite $DEST"
              else
                cp "$SRC" "$DEST"
                print_success "Updated $DEST"
                CHANGED="$CHANGED $DEST"
              fi
            else
              print_info "Skipped $DEST"
              SKIPPED="$SKIPPED $DEST"
            fi
          fi
        else
          print_success "$file is identical in $TARGET_DIR"
        fi
      else
        print_warn "$file missing in $TARGET_DIR"
        if $AUTO_MODE; then
          if $DRY_RUN; then
            print_info "[DRY-RUN] Would copy $file to $TARGET_DIR"
          else
            cp "$SRC" "$DEST"
            print_success "Copied $file to $TARGET_DIR"
            COPIED="$COPIED $DEST"
          fi
        else
          printf "Copy $file to $TARGET_DIR? (y/n): "
          read choice
          if [ "$choice" = "y" ]; then
            if $DRY_RUN; then
              print_info "[DRY-RUN] Would copy $file"
            else
              cp "$SRC" "$DEST"
              print_success "Copied $file"
              COPIED="$COPIED $DEST"
            fi
          else
            print_info "Skipped $file"
            SKIPPED="$SKIPPED $DEST"
          fi
        fi
      fi

      # Save checksum file in target directory
      if $DRY_RUN; then
        print_info "[DRY-RUN] Would update checksum in $TARGET_DIR"
      else
        $SUM_CMD "$DEST" >> "$TARGET_DIR/checksums.txt"
      fi
    done
  done
}

# === MAIN ===
for arg in "$@"; do
  case "$arg" in
    --auto) AUTO_MODE=true ;;
    --dry-run) DRY_RUN=true ;;
    --help) show_help ;;
  esac
done

print_info "Logging to $LOG_FILE"
: > "$LOG_FILE"

if $DRY_RUN; then
  print_info "Running in DRY-RUN mode (no changes will be made)."
fi

if $AUTO_MODE; then
  print_info "Running in FULL AUTOMATION mode."
fi

# Step 1: Create checksum file if missing
if [ ! -f "$CHECKSUM_FILE" ]; then
  print_warn "Checksum file missing. Creating..."
  update_checksums
fi

# Step 2: Verify checksum file
verify_checksums

# Step 3: Compare and sync files
compare_and_sync

# === SUMMARY ===
printf "\n${BLUE}Summary:${NC}\n"
printf "${GREEN}Changed:${NC} $CHANGED\n"
printf "${GREEN}Copied:${NC} $COPIED\n"
printf "${YELLOW}Skipped:${NC} $SKIPPED\n"
print_success "Operation completed."
