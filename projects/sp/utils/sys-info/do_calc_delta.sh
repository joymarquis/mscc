#!/bin/bash

do_calc()
{
	val_list=""
	while read l; do
		val_list="$val_list $l"
	done

	old=-1
	for i in $val_list; do
		[ "$old" == "-1" ] && { old=$i; continue; }
		echo $((i-old))
		old=$i
	done
}

do_calc
