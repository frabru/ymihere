#!/bin/sh

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
						YMIHERE="${YMIHERE#[[:cntrl:]]}"
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
	if [ $# -gt 0 ] ; then
		case "$1" in
			-h*|--help)
cat <<HELP
yruh (whY aRe yoU Here?)

Asks for a text to set for ymih.

This calls

    ymih --

but prints a question before and a guide text afterwards.

Usage:
    yruh
        Ask for why you are here and read text from stdin.

    yruh -h|--help
        Print this help text and exit.

Author: Frank Bruder <mail@frabru.de>
HELP
				return 0
				;;
			-*)
				printf 'Unsupported option "%s"\n' "$1">&2
				return 2
				;;
			*)
				printf 'Unsupported operand "%s"\n' "$1">&2
				return 2
				;;
		esac
	else
		echo 'Why are you here?'
		ymih --
	fi
	printf 'Okay. Type "____\010\010\010\010ymih" (wh_\010y a_\010m _\010I _\010here) if you need a reminder of\nwhy you have opened this terminal.\n' | "$(command -v ul || printf cat)"
}

case "$-" in
	*i*)
		if [ -t 1 ] ; then
			yruh
		fi
		;;
esac
