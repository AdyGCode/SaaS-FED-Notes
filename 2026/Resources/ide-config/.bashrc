export CLI_OUTPUT=NONE

# =====================================================================
# Output filtering via $CLI_OUTPUT (case-insensitive)
# Categories: success | warning | error | info
# Presets: ALL (default) | NONE
#
# Examples:
#   export CLI_OUTPUT=warning|success
#   export CLI_OUTPUT="ERROR, SUCCESS"
#   export CLI_OUTPUT="success error"     # space-separated
#   export CLI_OUTPUT=NONE                # only final completed message
#   export CLI_OUTPUT=ALL                 # show everything

__cli_out_raw="${CLI_OUTPUT:-}"
__cli_out_norm="$(printf '%s' "$__cli_out_raw" | tr '[:upper:]' '[:lower:]')"

# Split by | , or whitespace into an array of tokens
# Shell-safe tokenizer: translate separators to spaces, then read into array.
__cli_tokens=()
if [ -n "$__cli_out_norm" ]; then
  __cli_out_seps="$(printf '%s' "$__cli_out_norm" | tr ',|' '  ')"
  # trim extra spaces
  # shellcheck disable=SC2086
  set -- $__cli_out_seps
  for t in "$@"; do
    [ -n "$t" ] && __cli_tokens+=("$t")
  done
fi

# Resolve preset: default ALL unless explicitly NONE or ALL provided,
# but if specific categories are given, switch to CUSTOM.
__cli_preset="all"
for t in "${__cli_tokens[@]}"; do
  case "$t" in
    none) __cli_preset="none" ;;
    all)  __cli_preset="all"  ;;
  esac
done

# Build an allow-list set only when not NONE
# We use a simple "contains" function against a normalized list
__cli_allow_list=""
if [ "$__cli_preset" = "none" ]; then
  __cli_allow_list=""         # nothing allowed
else
  # If tokens include specific categories, use them; otherwise ALL
  __has_specific=0
  for t in "${__cli_tokens[@]}"; do
    case "$t" in
      success|warning|error|info)
        __has_specific=1
        # de-duplicate
        case "$__cli_allow_list" in
          *" $t "* ) ;;                     # already present
          * ) __cli_allow_list="$__cli_allow_list $t " ;;
        esac
        ;;
    esac
  done

  if [ "$__has_specific" -eq 1 ]; then
    # Specific categories provided → CUSTOM preset
    __cli_preset="custom"
  else
    # No specific categories → ALL categories allowed
    __cli_allow_list=" success warning error info "
    __cli_preset="all"
  fi
fi

# Predicate: is a category enabled?
cli_enabled() {
  # $1: category name (success|warning|error|info)
  case "$__cli_preset" in
    none)   return 1 ;;  # nothing allowed
    all)    return 0 ;;  # everything allowed
    custom)
      case "$__cli_allow_list" in
        *" $1 "* ) return 0 ;;
        * )        return 1 ;;
      esac
      ;;
    *) return 0 ;;       # safety: treat unknown as ALL
  esac
}

# Log helpers: route messages through these instead of echo
# (Keep icons; warnings/errors go to stderr.)
cli_success()  { cli_enabled success && printf '✅ %b\n' "$*"; }
cli_warning()  { cli_enabled warning && printf '⚠️ %b\n' "$*" >&2; }
cli_error()    { cli_enabled error   && printf '🛑 %b\n' "$*" >&2; }
cli_info()     { cli_enabled info    && printf 'ℹ️  %b\n' "$*"; }
cli_blank()    { printf '%b\n' "$*"; }
cli_completed(){ printf '🧐 %s\n' "BashRC executed and Aliases added"; }  # single final line

# Force-print helpers (ignore CLI_OUTPUT filter)
# Primary use: --help / -h
cli_success_f() { printf '✅ %b\n' "$*"; }
cli_warning_f() { printf '⚠️ %b\n' "$*" >&2; }
cli_error_f()   { printf '🛑 %b\n' "$*" >&2; }
cli_info_f()    { printf 'ℹ️ %b\n' "$*"; }
cli_blank_f()   { printf '%b\n' "$*"; }


# =====================================================================
# Function definitions used by shell

# ---------------------------------------------------------------------
# Function to safely append to PATH

add_to_path() {
  local force=0
  local show_help=0
  local path=""
  for arg in "$@"; do
    case "$arg" in
      --force) force=1 ;;
      --help|-h) show_help=1 ;;
      *) path="$arg" ;;
    esac
  done

  if [ "$show_help" -eq 1 ] || [ -z "$path" ]; then
    cli_info_f "Usage: add_to_path [--force] <path>"
    cli_blank_f " "
    cli_info_f "Adds <path> to the PATH environment variable."
    cli_blank_f " "
    cli_info_f "Options:"
    cli_info_f "  --force  Add the path even if it does not exist."
    cli_info_f "  --help, -h  Show this help message."
    cli_blank_f " "
    cli_info_f "Examples:"
    cli_info_f "  add_to_path ./vendor/bin"
    cli_info_f "  add_to_path --force ./vendor/bin"
    return 0
  fi

  if [ "$force" -eq 1 ] || [ -d "$path" ]; then
    PATH="$path:$PATH"
    cli_success "Added '$path' to PATH."
  else
    cli_warning "Warning: '$path' does not exist. Use --force to add it anyway."
  fi
}



# ---------------------------------------------------------------------
# Add_Alias function that adds aliases as well
# as verifying commands/folders exist before creating the alias
#
# Examples of how to use:
# 
# add_alias 'alias-edit' 'nano /c/Users/$USERNAME/.aliases'
# add_alias laragon 'cd /c/ProgramData/Laragon/'
# add_alias emqx-stop 'cd /c/Laragon/bin/mqtt/emqx/bin && emqx stop'
# add_alias makeapi 'artisan make:model -acs --api'


add_alias() {
  # Help option
  if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    cli_info_f "Usage: add_alias [--force|-f] <alias_name> <alias_command>"
    cli_blank_f " "
    cli_info_f "Options:"
    cli_info_f "  --force, -f  Force creation of alias even if command or path is invalid"
    cli_info_f "  --help, -h   Show this help message"
    cli_blank_f " "
    cli_info_f "Examples:"
    cli_info_f "  add_alias cls 'clear'"
    cli_info_f "  add_alias laragon 'cd /c/ProgramData/Laragon/'"
    cli_info_f "  add_alias --force emqx-start 'cd /c/Laragon/bin/mqtt/emqx/bin && ./emqx foreground'"
    return 0
  fi

  local force=false
  local alias_name
  local alias_command

  # Check for --force or -f flag
  if [[ "$1" == "--force" || "$1" == "-f" ]]; then
    force=true
    alias_name="$2"
    alias_command="$3"
  else
    alias_name="$1"
    alias_command="$2"
  fi

  # Check if the command starts with 'cd'
  if [[ "$alias_command" =~ ^cd[[:space:]]+([^&]+) ]]; then
    local path="${BASH_REMATCH[1]}"
    eval path="$path"
    if [ ! -d "$path" ]; then
      if [ "$force" = false ]; then
        cli_error "Directory '$path' does not exist. Alias '$alias_name' not created."
        return 1
      else
        cli_warning "Directory '$path' not found. Alias '$alias_name' forced."
      fi
    fi
  fi

  # Check for executable in the command (e.g., './emqx', './mosquitto.exe')
  if [[ "$alias_command" =~ \&\&[[:space:]]+\./([a-zA-Z0-9._-]+) ]]; then
    local exec_file="${BASH_REMATCH[1]}"
    local exec_path="${path}/${exec_file}"
    if [ ! -x "$exec_path" ]; then
      if [ "$force" = false ]; then
        cli_error "Executable '$exec_file' not found or not executable at '$exec_path'. Alias '$alias_name' not created."
        return 1
      else
        cli_warning "Executable '$exec_file' not found. Alias '$alias_name' forced."
      fi
    fi
  else
    # Extract the first command word
    local cmd="${alias_command%% *}"
    if ! command -v "$cmd" &> /dev/null; then
      if [ "$force" = false ]; then
        cli_error "Command '$cmd' not found. Alias '$alias_name' not created."
        return 1
      else
        cli_warning "Command '$cmd' not found. Alias '$alias_name' forced."
      fi
    fi
  fi

  # Create the alias
  alias "$alias_name"="$alias_command"
  cli_success "Alias '$alias_name' created for: $alias_command"
}



# =====================================================================
# Show a folder tree (default: current directory).
# Options:
#   --dir <path>       Render the given directory (absolute or relative)
#   --path             Render PATH entries as a component tree (legacy mode)
#   --show-hidden      Include dotfiles/hidden items (names beginning with '.')
#   --max-depth=N      Limit depth (directory mode only; 0/omit = unlimited)
#   --delimiter=CHAR   Separator used in --path mode (default: ':')
#   --help, -h         Show detailed help and exit
#
# Examples:
#   pathtree                               # current dir
#   pathtree --dir /c/Laragon/bin          # specific dir
#   pathtree --dir . --show-hidden         # current dir, include hidden
#   pathtree --dir /c/Projects --max-depth=2
#   pathtree --path                         # PATH as component tree (normalized)
#   pathtree --path --delimiter=';'         # if PATH uses ';' as separator
pathtree() {
  local mode="dir"               # dir | path
  local target="$PWD"
  local show_hidden=false
  local max_depth=0              # 0 = unlimited
  local delimiter=":"            # used only in --path mode
  local target_given=0

  # Parse options
  while [ $# -gt 0 ]; do
    case "$1" in
      --dir)
        shift
        target="${1:-$PWD}"
        target_given=1
        ;;
      --path)
        mode="path"
        ;;
      --show-hidden)
        show_hidden=true
        ;;
      --max-depth=*)
        max_depth="${1#*=}"
        ;;
      --delimiter=*)
        delimiter="${1#*=}"
        ;;
      --help|-h)
        # Extended help text
        cli_blank_f " "
        cli_info_f "Usage: pathtree [OPTIONS] [<path>]"
        cli_blank_f " "
        cli_info_f "Description:"
        cli_info_f "  Render a simple ASCII tree. By default, pathtree prints the tree of"
        cli_info_f "  the current working directory. You can also render a specific directory"
        cli_info_f "  or visualize your PATH as a component tree (legacy mode)."
        cli_blank_f " "
        cli_info_f "Options:"
        cli_info_f "  --dir <path>       Render the given directory (absolute or relative)."
        cli_info_f "                     If a bare path (without --dir) is supplied and is a"
        cli_info_f "                     valid directory, it is treated as --dir <path>."
        cli_info_f "  --path             Render PATH entries as a hierarchical component tree."
        cli_info_f "                     Useful to inspect how PATH is composed; drive letters"
        cli_info_f "                     like /C/... are normalized to /c/... to avoid duplicates."
        cli_info_f "  --show-hidden      Include hidden files/directories (names beginning with '.')."
        cli_info_f "                     Default behavior prunes hidden directories for readability."
        cli_info_f "  --max-depth=N      Limit the depth in directory mode to N levels."
        cli_info_f "                     Defaults to unlimited (0 or omitted)."
        cli_info_f "  --delimiter=CHAR   Character that separates PATH entries in --path mode."
        cli_info_f "                     Default is ':'. On Windows shells, you may prefer ';'."
        cli_info_f "  --help, -h         Show this help and exit."
        cli_blank_f " "
        cli_info_f "Behavior & Notes:"
        cli_info_f "  • Default mode is directory mode, using \$PWD."
        cli_info_f "  • PATH mode does not walk the filesystem; it splits PATH and displays"
        cli_info_f "    the segments as nested components for a quick visual overview."
        cli_info_f "  • Hidden entries are pruned unless --show-hidden is given."
        cli_info_f "  • On mixed-case Windows paths, drive letters are normalized (e.g., /C → /c)."
        cli_info_f "  • Output respects CLI_OUTPUT filters (success|warning|error|info|none|all)."
        cli_info_f "    Help text uses 'info' and 'blank' lines."
        cli_blank_f " "
        cli_info_f "Examples:"
        cli_info_f "  pathtree"
        cli_info_f "    Show the tree of the current directory."
        cli_info_f "  pathtree --dir /c/Laragon/bin"
        cli_info_f "    Show the tree of a specific directory."
        cli_info_f "  pathtree --dir . --show-hidden --max-depth=2"
        cli_info_f "    Show current directory, include dotfiles, limit to 2 levels."
        cli_info_f "  pathtree --path"
        cli_info_f "    Visualize PATH entries as a normalized component tree."
        cli_info_f "  pathtree --path --delimiter=';'"
        cli_info_f "    Use ';' as the PATH entry separator."
        cli_blank_f " "
        return 0
        ;;
      *)
        # If a bare path is given without --dir, treat it as target
        if [ "$target_given" -eq 0 ] && [ -d "$1" ]; then
          target="$1"
          target_given=1
        else
          cli_warning "Unknown option or non-directory: $1"
        fi
        ;;
    esac
    shift
  done

  if [ "$mode" = "path" ]; then
    # ---- PATH MODE (legacy) ---------------------------------------------------
    local tree=()
    local IFS="$delimiter"
    # shellcheck disable=SC2206
    local paths=($PATH)
    IFS=" "

    for p in "${paths[@]}"; do
      # normalize Windows drive letters: /C/... -> /c/...
      p="$(printf '%s' "$p" | sed -E 's|^/([A-Z])|/\L\1|')"
      IFS='/' read -r -a parts <<< "$p"
      local current=""
      for part in "${parts[@]}"; do
        [ -z "$part" ] && continue
        if [ "$show_hidden" = false ] && printf '%s' "$part" | grep -qE '^\.'; then
          continue
        fi
        current="$current/$part"
        tree+=("$current")
      done
      IFS=" "
    done

    if [ ${#tree[@]} -eq 0 ]; then
      cli_info "PATH appears empty."
      return 0
    fi
    # de-duplicate + sort
    printf "%s\n" "${tree[@]}" | awk '!seen[$0]++' | sort |
    awk -F'/' '
      {
        depth=NF-1; name=$NF; indent="";
        for (i=1; i<depth; i++) indent=indent "    |";
        printf("|%s +-- %s\n", indent, name);
      }
    '
    return 0
  fi

  # ---- DIRECTORY MODE (default) ----------------------------------------------
  if [ ! -d "$target" ]; then
    cli_error "Directory not found: $target"
    return 1
  fi

  local find_opts=()
  find_opts+=("$target")
  find_opts+=(-type d)
  if [ "$show_hidden" = false ]; then
    # prune hidden dirs
    find_opts+=("(" -name ".*" -prune ")" -o -type d -print)
  else
    find_opts+=(-print)
  fi
  if [ "$max_depth" -gt 0 ] 2>/dev/null; then
    find_opts+=(-maxdepth "$max_depth")
  fi

  # shellcheck disable=SC2207
  local dirs=($(find "${find_opts[@]}" 2>/dev/null | sed -E 's|^/([A-Z])|/\L\1|' | sort))

  if [ ${#dirs[@]} -eq 0 ]; then
    cli_info "(empty)"
    return 0
  fi

  local base_parts
  IFS='/' read -r -a base_parts <<< "$target"
  local base_depth=${#base_parts[@]}
  IFS=" "
  for d in "${dirs[@]}"; do
    IFS='/' read -r -a parts <<< "$d"
    local depth=$(( ${#parts[@]} - base_depth ))
    [ "$depth" -lt 0 ] && depth=0
    local name="${parts[-1]}"
    local indent=""
    for ((i=0; i<depth; i++)); do
      indent="$indent|   "
    done
    printf "%s+-- %s\n" "$indent" "$name"
    IFS=" "
  done
}


# ---------------------------------------------------------------------
# Convert MSYS/Git Bash path to Windows path for cmd.exe
_to_win_path() {
  # Prefer cygpath if available; otherwise do a simple transform
  if command -v cygpath >/dev/null 2>&1; then
    cygpath -w "$1"
  else
    # /c/Program Files/Python311/python.exe -> C:\Program Files\Python311\python.exe
    printf '%s' "$1" | sed -E 's,^/([a-zA-Z])/,\\U\1:\\,; s,/,\\,g'
  fi
}


# ---------------------------------------------------------------------
_probe_python_version() {
  local exe="$1"
  local line version

  # Try direct (works in your output)
  line=$("$exe" --version 2>&1 | tr -d '\r' | head -n 1) || line=""
  if [[ ! "$line" =~ ^Python[[:space:]] ]]; then
    # Convert path for cmd.exe and then quote it
    local win_exe=$(_to_win_path "$exe")
    line=$(cmd.exe /c "\"$win_exe\" --version" 2>&1 | tr -d '\r' | head -n 1) || line=""
  fi

  if [[ "$line" =~ ^Python[[:space:]]+([0-9][0-9.]+) ]]; then
    version="${BASH_REMATCH[1]}"
    printf '%s' "$version"
    return 0
  fi
  return 1
}

# ---------------------------------------------------------------------
# Locate latest version of Python and add to path

find_latest_python() {
    local META_FILE="$HOME/.python_version"
    local SEARCH_DIRS=("/c/Program Files" "/c/Program Files (x86)" "/c/Laragon/bin")
    local FORCE=false
    local SHOW=false
    local PERSIST=false
    local REMOVE=false

    cli_info " "
    cli_info "Searching for Python, and checking for latest version"
    cli_info " "
    cli_info "First run may take several minutes"
    # Parse flags
    for arg in "$@"; do
        case "$arg" in
            --force) FORCE=true ;;
            --show) SHOW=true ;;
            --set-persistent) PERSIST=true ;;
            --remove-persistent) REMOVE=true ;;
            --help)
                cli_info_f "Usage: find_latest_python [options]"
                cli_blank_f " "
                cli_info_f "Options:"
                cli_info_f "  --force            Force rescan even if cached this month"
                cli_info_f "  --show             Show all detected Python versions and paths"
                cli_info_f "  --set-persistent   Add or update latest Python path in ~/.bashrc"
                cli_info_f "  --remove-persistent Remove any Python PATH entry from ~/.bashrc"
                cli_info_f "  --help             Show this help message"
                return 0
                ;;
        esac
    done

    # Handle remove persistent
    if [ "$REMOVE" = true ]; then
        _remove_bashrc
        return 0
    fi

    local TODAY=$(date +%Y-%m)
    local LAST_SCAN=""
    local LAST_VERSION=""
    local LAST_PATH=""

    if [ -f "$META_FILE" ]; then
        LAST_SCAN=$(awk -F= '/last_scan/{print $2}' "$META_FILE")
        LAST_VERSION=$(awk -F= '/version/{print $2}' "$META_FILE")
        LAST_PATH=$(awk -F= '/path/{print $2}' "$META_FILE")
    fi

    # Skip scan if same month and not forced
    if [ "$FORCE" = false ] && [ "$LAST_SCAN" == "$TODAY" ] && [ -n "$LAST_VERSION" ]; then
        cli_info_f "Using cached Python version: $LAST_VERSION"
        export PATH="$(dirname "$LAST_PATH"):$PATH"
        cli_success_f "Current Python: $(python --version)"
        if ! python -m pip --version &>/dev/null; then
            cli_error "pip is not installed for this Python."
        fi
        if [ "$PERSIST" = true ]; then
            _update_bashrc "$(dirname "$LAST_PATH")"
        fi
        return 0
    fi

    # Scan for python.exe, ignoring venv folders
    local PYTHON_PATHS=()
    for dir in "${SEARCH_DIRS[@]}"; do
        if [ -d "$dir" ]; then
            while IFS= read -r path; do
                PYTHON_PATHS+=("$path")
            done < <(find "$dir" -type f -iname "python.exe" \
                     -not -path "*/venv/*" -not -path "*/.venv/*" 2>/dev/null)
        fi
    done

    if [ ${#PYTHON_PATHS[@]} -eq 0 ]; then
        cli_error_f "No Python installation found."
        return 1
    fi

    # Map versions to paths
    declare -A VERSION_MAP

    for path in "${PYTHON_PATHS[@]}"; do
      # Try to get a version string robustly
      version=$(_probe_python_version "$path") || version=""
      if [[ -n "$version" ]]; then
        VERSION_MAP["$version"]="$path"
        if [ "$SHOW" = true ]; then
          cli_info_f "  ✔ $version -> $path"
        fi
      else
        if [ "$SHOW" = true ]; then
          cli_warning_f "  ✖ unable to read version -> $path"
        fi
        continue
      fi
    done

    if [[ ${#VERSION_MAP[@]} -eq 0 ]]; then
      cli_error_f "Found python.exe candidates, but could not read any version strings."
      return 1
    fi

    # Show all versions if requested
    if [ "$SHOW" = true ]; then
        cli_info_f "Detected Python installations:"
        for v in $(printf "%s\n" "${!VERSION_MAP[@]}" | sort -V); do
            cli_info_f "  $v -> ${VERSION_MAP[$v]}"
        done
    fi

    # Sort versions and pick latest
    local LATEST_VERSION=$(printf "%s\n" "${!VERSION_MAP[@]}" | sort -V | tail -n 1)
    local LATEST_PATH="${VERSION_MAP[$LATEST_VERSION]}"
    local PYTHON_DIR=$(dirname "$LATEST_PATH")

    # Update PATH
    export PATH="$PYTHON_DIR:$PATH"
    cli_success "Added Python $LATEST_VERSION from $PYTHON_DIR to PATH."
    cli_info "Current Python: $(python --version)"

    # Check pip
    if ! python -m pip --version &>/dev/null; then
        cli_error "pip is not installed for this Python."
    else
        cli_info "pip is available."
    fi

    # Save metadata
    cat > "$META_FILE" <<EOF
last_scan=$TODAY
version=$LATEST_VERSION
path=$LATEST_PATH
EOF

    # Persist if requested
    if [ "$PERSIST" = true ]; then
        _update_bashrc "$PYTHON_DIR"
    fi
}

# Helper: Update ~/.bashrc with latest Python path
_update_bashrc() {
    cli_info " "
    local PYTHON_DIR="$1"
    local BASHRC="$HOME/.bashrc"
    if grep -q "export PATH=.*python" "$BASHRC"; then
        sed -i "s|export PATH=.*python.*|export PATH=\"$PYTHON_DIR:\$PATH\"|" "$BASHRC"
        cli_info "Updated Python path in $BASHRC"
    else
        cli_info "export PATH=\"$PYTHON_DIR:\$PATH\"" >> "$BASHRC"
        cli_info "Added Python path to $BASHRC"
    fi
}

# Helper: Remove Python PATH from ~/.bashrc
_remove_bashrc() {
    cli_info " "
    local BASHRC="$HOME/.bashrc"
    if grep -q "export PATH=.*python" "$BASHRC"; then
        sed -i "/export PATH=.*python.*/d" "$BASHRC"
        cli_info "Removed Python path from $BASHRC"
    else
        cli_error "No Python path entry found in $BASHRC"
    fi
}


# =====================================================================
# Add JRE location as environment variable
export EXE4J_JAVA_HOME="/c/laragon/bin/Java/jdk-25.0.1+8-jre/bin"


# =====================================================================
# Required basic aliases. Others added tot he .aliases file
add_alias la 'ls -ah'
add_alias ll 'ls -lah'
add_alias ls 'ls -F --color=auto --show-control-chars'



# =====================================================================
# Add tools and environments to PATH

# ---------------------------------------------------------------------
# All Computers
add_to_path --force "./vendor/bin"
add_to_path --force "./.venv/Scripts"
add_to_path --force "./.venv/bin"
add_to_path "$HOME/appdata/roaming/python/python311/site-packages"

# ---------------------------------------------------------------------
# TAFE Computers
add_to_path "/c/ProgramData/Laragon/bin/mailpit"
add_to_path "/c/ProgramData/Laragon/bin/gh/bin"
add_to_path "/c/ProgramData/Laragon/bin/pie"
add_to_path "/c/ProgramData/Laragon/bin/mongodb/mongodb-8.0.8/bin"
add_to_path "/c/ProgramData/Laragon/bin/mongodb/mongodb-shell"
add_to_path "/c/ProgramData/Laragon/usr/bin/"
add_to_path "/c/ProgramData/Laragon/bin/mqtt/emqx/bin"
add_to_path "/c/ProgramData/Laragon/bin/utils"
add_to_path "/c/ProgramData/Laragon/bin/mqtt/mosquitto"
add_to_path "/c/ProgramData/Laragon/bin/marp"
add_to_path "/c/ProgramData/Laragon/bin/mqtt/nanomq/bin"


# ---------------------------------------------------------------------
# TDM and Home Computers
add_to_path /c/Laragon/bin/mailpit
add_to_path /c/Laragon/bin/gh/bin
add_to_path /c/Laragon/bin/pie
add_to_path /c/Laragon/bin/mongodb/mongodb-8.0.8/bin
add_to_path /c/Laragon/bin/mongodb/mongodb-shell
add_to_path /c/Laragon/usr/bin
add_to_path /c/Laragon/bin/utils
add_to_path /c/Laragon/bin/marp
add_to_path /c/Laragon/bin/mqtt/emqx/bin
add_to_path /c/Laragon/bin/mqtt/mosquitto
add_to_path /c/Laragon/bin/mqtt/nanomq/bin
add_to_path "/c/Program\ Files/Erlang\ OTP/bin/"
add_to_path "/C/laragon/bin/DbVisualizer"
add_to_path "/C/laragon/bin/Java/jdk-25.0.1+8-jre/bin"


#
# Any Windows PC
add_to_path "/c/Program Files/7-Zip"

# =====================================================================
# Source aliases if available
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"



# =====================================================================
cli_blank_f " "
find_latest_python
cli_blank_f " "



# =====================================================================
# End-of-initialization message (single line) and cleanup
cli_blank " "
cli_completed


# =====================================================================
# Greetings

# ---------------------------------------------------------------------
# Time-based greeting
cli_blank " "
HOUR=$(date "+%H")
case $HOUR in
  [0-9]|1[0-1]) cli_info "Good morning" ;;
  1[2-7])       cli_info "Good afternoon" ;;
  *)            cli_info "Good evening" ;;
esac


# ---------------------------------------------------------------------
# Welcome message
cli_blank "Welcome ${USER:-$USERNAME}, to Bash on $HOSTNAME."
cli_blank "Today's date is: $(date +"%A, %d-%m-%Y")"
cli_blank " "

unset CLI_OUTPUT
unset __cli_out_raw __cli_out_norm __cli_tokens __cli_preset __cli_allow_list
