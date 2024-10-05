#!/usr/bin/env zsh

script_dir="${0:A:h}"
source ${script_dir}/shuz.sh

shuz::success The full path to this script directory will be in script_dir after
shuz::success sourcing shuz.sh. Put somewhere in your PATH and the script becomes
shuz::success completely location independent.
shuz::ec script_dir=${script_dir}
shuz::br

shuz::ec "${bold}ec${noc} is a convenient echo replacement"
shuz::ecn "While ${bold}ecn${noc} is echo without the new line"
shuz::br
shuz::ec "Use ${bold}br${noc} to add just the new line"
shuz::br
shuz::ec In simple cases you can skip quotes
shuz::ec But beware of the expansion rules:
shuz::ec "    With quotes: *"
shuz::ec "    Without quotes:" *
shuz::br

shuz::ec It is easy to ${magenta}control ${blue}color${noc}
WARN_COLOR=${cyan}
shuz::warn It is even possible to reconfigure the predefined message colors
WARN_COLOR=${yellow}

shuz::multiline text <<-EOF
	${green}
	Easily create
	multiline
	strings${noc}
EOF

shuz::ec "${text}"
shuz::ec "And even indent them"
shuz::ec "$(shuz::indent <<< "${text}")"
shuz::ec "And indent even more"
shuz::ec "$(<<< "${text}" shuz::indent | shuz::indent | shuz::indent)"

shuz::are_you_sure 'Give user option to abort. Continue?'
shuz::br

shuz::ec "Complex colors have the form ${yellow_on_black}<foreground>_on_<background>${noc}"
shuz::ec "${bold_on_blue}These are ${black_on_green} the supported ${white_on_magenta} combinations:${noc}"
color_map

shuz::assert_success "This message would have been printed if the previous command had failed"
shuz::br

shuz::ec "use ${bold}expect_command${noc} or ${bold}assert_command${noc} to check command existence:"
shuz::expect_command bash && \
  shuz::ec "> ${cyan}expect_command bash${noc}" && \
  shuz::success "Found!"
shuz::br

shuz::fail 'This is a command that prints this text and stops the script with an error code'
