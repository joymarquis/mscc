#!/bin/bash

function usage()
{
	echo "Usage: `basename $0` <pmc_csv_file_name> <raw_file_name>"
	echo ""
	echo "Convert from PMC csv file to raw mem file"
	echo ""
	echo '    (Ver: $Id: pmc-csv2mem.sh 3 2012-06-10 14:57:21Z joymarquis@gmail.com $)'
}

if [ "$*" == "" ] || [ "$2" == "" ]; then
	usage; exit 0
fi

if ! [ -f "$1" ]; then
	echo "Error: file not found [$1]"; exit 1
fi

content=`grep -E "^[[:space:]]*0x[[:xdigit:]]{4}[[:space:]]*," "$1" | cut -d , -f 10`
if [ "$content" == "" ]; then
	echo "Error: incorrect csv file, please check csv file manually"; exit 1
fi

bytes_expect=`echo "$content" | wc -l`

rm -f "$2"
echo "$content" | xxd -r -ps > "$2"

bytes_generate=`cat "$2" | wc -c`

if [ "$bytes_generate" != "$bytes_expect" ]; then
	echo "Error: expect binary size $bytes_expect but get $bytes_generate"
	echo "Error: binary size incorrect, please check csv file manually"; exit 1
fi

