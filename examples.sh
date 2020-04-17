#!/usr/bin/env bash

source shuz.sh

success The full path to this script directory will be in script_dir after
success sourcing shuz.sh. Put somewhere in your PATH and the script becomes
success completely location independent.
ec script_dir=${script_dir}
br

ec "${bold}ec${noc} is a convenient echo replacement"
ecn "While ${bold}ecn${noc} is echo without the new line"
br
ec "Use ${bold}br${noc} to add just the new line"
br
ec In simple cases you can skip quotes
ec But beware of the expansion rules:
ec "    With quotes: *"
ec "    Without quotes:" *
br

ec It is easy to ${magenta}control ${blue}color${noc}
WARN_COLOR=${cyan}
warn It is even possible to reconfigure the predefined message colors
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
