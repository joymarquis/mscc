#!/bin/bash

usage_exit()
{
        echo "Usage: `basename $0` <file> <column> [ghn-]"
        exit 0
}


[ -f "$1" ] || usage_exit
[ "$2" == "" ] && usage_exit
SORT_OPT="-g"
case "$3" in
	""|g)	true	;;
	h|n)	SORT_OPT="-$3"	;;
	-)	SORT_OPT=""	;;
	*)	usage_exit	;;
esac

{
        grep "samples  %" "$1" | sed -e "s/\([^ ]\) \([^ ]\)/\1_\2/g"
	sed "s/  */ /g" "$1" | sort $SORT_OPT -s -r -k $2,$2
} | column -t

