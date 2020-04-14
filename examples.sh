#!/usr/bin/env bash

source shuz.sh

success 'The full path to this script directory will be in script_dir after sourcing'
success 'shuz.sh. Put somewhere in your PATH and the script becomes completely'
success 'location independent.'
ec script_dir=${script_dir}
br

ec "${bold}ec${noc} is a convenient echo replacement"
ecn "While ${bold}ecn${noc} is echo without the new line"
br
ec "Use ${bold}br${noc} to add just the new line"
ec "It is easy to ${magenta}control ${blue}colors${noc}"

WARN_COLOR=${cyan}
warn 'It is possible to reconfigure predefined message colors'
WARN_COLOR=${yellow}

multiline text <<EOF
${green}
Easily create
multiline
strings${noc}
EOF

ec "${text}"
ec "And even indent them"
ec "$(indent <<< "${text}")"
ec "And indent even more"
ec "$(<<< "${text}" indent | indent | indent)"

are_you_sure 'Give user option to abort. Continue?'
br

ec "Complex colors have the form ${yellow_on_black}<foreground>_on_<background>${noc}"
ec "${bold_on_blue}These are ${black_on_green} the supported ${white_on_magenta} combinations:${noc}"
color_map

fail 'Just kidding haha'
