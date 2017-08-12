#!/bin/bash

ymih() {
	if [ $# = 0 ] ; then
		printf '%s\n' "$YMIHERE" | sed -e "
1 {
	s/^/ /
	s/\$/ /
	:pad
	/.\{$COLUMNS\}/ ! {
		s/^/>/
		s/\$/</
		/^>\{10\}/ s/>\{5\}/<<<<</
		/<\{10\}\$/ s/<\{5\}\$/>>>>>/
		b pad
	}
	/.\{$COLUMNS\}./ s/.//
}
2,$ {
	s/^[	]*/+ /
	:indent
	/^ \{$(($COLUMNS / 3))\}/ ! {
		/.\{$COLUMNS\}/ ! {
			s/^/ /
			b indent
		}
	}
}"
		printf '\n'
	else
		case "$1" in
			--|-)
				if [ "$#" -gt 1 ] ; then
					shift
					export YMIHERE="$*"
				else
					unset YMIHERE
					while ! [ -n "$YMIHERE" ] ; do
						IFS='		' read -r YMIHERE
					done
					export YMIHERE
				fi
				;;
			+)
				if [ "$#" -gt 1 ] ; then
					shift
					export YMIHERE="$YMIHERE
  $*"
				else
					unset INPUT
					while ! [ -n "$INPUT" ] ; do
						IFS='		' read -r INPUT
					done
					export YMIHERE="$YMIHERE
  $INPUT"
				fi
				;;
			-h*|--help)
cat <<HELP
ymih (whY aM I Here?)

Usage:
    ymih
        Prints the previously set text.

    ymih --
    ymih -
        Reads text from the terminal.

    ymih [--|-] <TEXT>
        Sets text from operand.

    ymih + [<TEXT>]
        Adds a text as an indented line to the text.
        If + is used without an argument, text is read
				from stdin.

    ymih -h|--help
        Print this help text and exit.

Author: Frank Bruder <mail@frabru.de>
HELP
				;;
			-*)
				echo "Unsupported option: $1">&2
				return 2
				;;
			*)
				export YMIHERE="$*"
				;;
		esac
	fi
}

yruh() {
	echo 'Why are you here?'
	ymih --
	printf 'Okay. Type "____\010\010\010\010ymih" (wh_\010y a_\010m _\010I _\010here) if you need a reminder of\nwhy you have opened this terminal.\n' | $(which ul || printf cat)
}

case "$-" in
	*i*)
		if [ -t 1 ] ; then
			yruh
		fi
		;;
esac
