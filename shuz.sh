
# Environment
# ------------------------------------------

# Stores sourcing script location in script_dir variable
script_dir=$(cd "$(dirname "${BASH_SOURCE[1]}")" && pwd)


# Terminal colors
# ------------------------------------------

# Clears styling
noc='\033[0m'

# Foreground colors
bold='\033[0;1m'
black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'
white='\033[0;37m'

# Complex colors declaration magic
fg_names=("bold" "black" "red" "green" "yellow" "blue" "magenta" "cyan" "white")
fg_vals=(1 30 31 32 33 34 35 36 37)
bg_names=("none" "black" "red" "green" "yellow" "blue" "magenta" "cyan" "white")
bg_vals=(0 40 41 42 43 44 45 46 47)

for ((fg=0; fg < ${#fg_names[*]}; fg++)); do
  for ((bg=0; bg < ${#bg_names[*]}; bg++)); do
    declare "${fg_names[fg]}_on_${bg_names[bg]}"="\\033[${bg_vals[bg]};${fg_vals[fg]}m"
  done
done

# Draws a table of the available coloring options
color_map () {
  # Draw the column titles
  ecn "▼FG   BG►│"
  for ((bg=0; bg < ${#bg_names[*]}; bg++)); do
    printf ' %8s ' "${bg_names[bg]}"
  done
  br
  ec "─────────┼──────────────────────────────────────────────────────────────────────────────────────────"

  for ((fg=0; fg < ${#fg_names[*]}; fg++)); do
    printf '%-8s │' "${fg_names[fg]}"
    for ((bg=0; bg < ${#bg_names[*]}; bg++)); do
      eval color="\$${fg_names[fg]}_on_${bg_names[bg]}"
      ecn " ${color} ******* ${noc}"
    done
    br
  done
}


# Configuration
# ------------------------------------------

SUCCESS_COLOR=${green}
WARN_COLOR=${yellow}
ERROR_COLOR=${red}


# Echos
# ------------------------------------------
ec() {
  IFS=' ' printf "%b\n" "$*"
}

ecn() {
  IFS=' ' printf "%b" "$*"
}

br() {
  ec ''
}

success() {
  ec "${SUCCESS_COLOR}$1${noc}"
}

warn() {
  ec "${WARN_COLOR}$1${noc}"
}

error() {
  >&2 ec "${ERROR_COLOR}ERROR: $1${noc}"
}

fail() {
  error "$@"
  exit 1
}


# Text manipulation
# ------------------------------------------
multiline () {
  IFS= read -r -d '' $1
}

indent() {
  sed 's/^/  /'
}


# User input
# ------------------------------------------
are_you_sure() {
  printf "${WARN_COLOR}$@${noc}"
  read -p " (y/n) " -n 1
  printf "\n"

  if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    return 0
  fi

  fail ABORTED
}
