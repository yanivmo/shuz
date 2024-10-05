#      https://github.com/yanivmo/shuz
#
#      ██████  ██░ ██  █    ██ ▒███████▒
#    ▒██    ▒ ▓██░ ██▒ ██  ▓██▒▒ ▒ ▒ ▄▀░
#    ░ ▓██▄   ▒██▀▀██░▓██  ▒██░░ ▒ ▄▀▒░ 
#      ▒   ██▒░▓█ ░██ ▓▓█  ░██░  ▄▀▒   ░
#    ▒██████▒▒░▓█▒░██▓▒▒█████▓ ▒███████▒
#    ▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒░▒▓▒ ▒ ▒ ░▒▒ ▓░▒░▒
#    ░ ░▒  ░ ░ ▒ ░▒░ ░░░▒░ ░ ░ ░░▒ ▒ ░ ▒
#    ░  ░  ░   ░  ░░ ░ ░░░ ░ ░ ░ ░ ░ ░ ░
#          ░   ░  ░  ░   ░       ░ ░    
#                              ░
# ----------------[ v2.0.0 ]----------------
# Shell utilz for ergonomic shell scripting. 
#

# Environment
# ------------------------------------------

# THIS_OS is "macos" on Mac and "linux" everywhere else
# naive but works for my simple needs :)
[ "$(uname)" = "Darwin" ] && THIS_OS=macos || THIS_OS=linux

# THIS_SHELL is "zsh" on Zsh and "bash" everywhere else
# even more naive, sorry -\_(ツ)_/-
[ -n "$ZSH_VERSION" ] && THIS_SHELL=zsh || THIS_SHELL=bash


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
  shuz::ecn "▼FG   BG►│"
  for ((bg=0; bg < ${#bg_names[*]}; bg++)); do
    printf ' %8s ' "${bg_names[bg]}"
  done
  shuz::br
  shuz::ec "─────────┼──────────────────────────────────────────────────────────────────────────────────────────"

  for ((fg=0; fg < ${#fg_names[*]}; fg++)); do
    printf '%-8s │' "${fg_names[fg]}"
    for ((bg=0; bg < ${#bg_names[*]}; bg++)); do
      eval color="\$${fg_names[fg]}_on_${bg_names[bg]}"
      shuz::ecn " ${color} ******* ${noc}"
    done
    shuz::br
  done
}


# Configuration
# ------------------------------------------

# Changing these value to affect the logging functions
SUCCESS_COLOR=${green}
WARN_COLOR=${yellow}
ERROR_COLOR=${red}

# Change this value to define the indentation size
INDENTATION='  '

# Echos
# ------------------------------------------

##
# More consistent echo.
#
shuz::ec() {
  IFS=' ' printf "%b\n" "$*"
}

##
# More consistent echo; without the new line.
#
shuz::ecn() {
  IFS=' ' printf "%b" "$*"
}

##
# Outputs new line.
# No parameters.
#
shuz::br() {
  shuz::ec ''
}

##
# Informs that everything goes as planned.
#
shuz::success() {
  shuz::ec "${SUCCESS_COLOR}$*${noc}"
}

##
# Outputs a menasing message.
#
shuz::warn() {
  shuz::ec "${WARN_COLOR}$*${noc}"
}

##
# Outputs a scary message.
#
shuz::error() {
  >&2 shuz::ec "${ERROR_COLOR}ERROR: $*${noc}"
}

##
# Outputs a message and kills the script.
#
shuz::fail() {
  shuz::error "$@"
  exit 1
}


# Text manipulation
# ------------------------------------------

##
# Reads multiline text from stdin into the specified variable.
#
# Parameters:
#   1: target variable name
#
shuz::multiline() {
  IFS= read -r -d '' $1
}

##
# Reads multiline text from stdin and outputs it indented.
#
shuz::indent() {
  sed "s/^/${INDENTATION}/"
}


# User input
# ------------------------------------------

##
# Read one character from stdin.
#
# Parameters:
#   The prompt to show the user.
#
shuz::read_char() {
  if [ "${THIS_SHELL}" = "zsh" ]; then
    read -r -q "READ_CHAR?$@"
  else
    read -p "$@" -r -n 1 READ_CHAR
  fi
  shuz::ecn "${READ_CHAR}"
}

##
# Ask user a yes/no question.
# Aborts the script if the answer is no.
#
# Parameters:
#   Interpreted as the question text to be presented to the user.
#
shuz::are_you_sure() {
  local char

  shuz::ecn "${WARN_COLOR}$@${noc}"
  char=$(shuz::read_char " (y/n) ")
  shuz::br

  if [[ "${char}" =~ ^[Yy]$ ]]; then
    return 0
  fi

  shuz::fail ABORTED
}


# Assertions and expectations
# ------------------------------------------

##
# Kill the script with error code if the previous command did not succeed.
#
# Parameters:
#   Interpreted as the failure massage to be presented to the user.
#
shuz::assert_success() {
  if [[ "$?" != "0" ]]; then
    shuz::fail "$@"
  fi
}

##
# Returns error if the requiested command could not be found.
#
# Parameters:
#   The command to search for. Could be a shell built-in command
#   or an executable found in PATH.
#
shuz::expect_command() {
  command -v "$@" &> /dev/null
}

##
# Kill the script with error code if the requiested command could
# not be found.
#
# Parameters:
#   The command to search for. Could be a shell built-in command
#   or an executable found in PATH.
#
shuz::assert_command() {
  shuz::expect_command "$@" || fail "${noc}Failed to find command ${ERROR_COLOR}$@${noc}"
}
