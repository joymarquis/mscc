
export PATH="`dirname $0`/pmc-crc32:`dirname $0`/pmc-csv2mem:$PATH:."
PMC_CRC32_BIN=pmc-crc32		# pmc-crc32.sh
PMC_CSV2MEM_BIN=pmc-csv2mem.sh
ME="`basename $0`"

BIN_USED="bash which basename grep dirname xxd wc mv rm ls cp stat dd printf"


PMC_IMG_HEADER_LEN=28
PMC_IMG_HEADER_CRC_OFF=20


function usage_exit()
{
	echo "\
Usage:
  $ME get PMC_IMG_FILE <data_off_HEX> <data_len_DEC>
  $ME set PMC_IMG_FILE <data_off_HEX> <data_HEX>
  $ME bit_set PMC_IMG_FILE <data_off_HEX> <bit_off_DEC> <bit_val_0_or_1>

Modify PMC image file directly without genearte process

Examples:
  $ME get istr_flash.bin 0x3b 8
  $ME set istr_flash.bin 0x3b 0x500e004aaaaabb00
  $ME set istr_flash.bin 0x41 0x0b
  $ME bit_set istr_flash.bin 0x41 4 1
  $ME bit_set istr_flash.bin 0x41 5 0

Attention:
  The '0' in <data_HEX> can not be omitted, for examples:
   * 0x05 can not be 0x5
   * 0x0f33445566 can not be 0xf33445566
"

	echo '    (Ver: $Id: pmc-img-mod.sh 8 2013-01-03 18:22:38Z joymarquis@gmail.com $)'

	exit $1
}

function err_exit()
{
	local errno="$1"

	shift; echo "Error: $*"
	exit $errno
}

if ! which "$PMC_CRC32_BIN" > /dev/null; then
	err_exit 1 "$PMC_CRC32_BIN not installed or not found in default PATH"
fi
if ! which "$PMC_CSV2MEM_BIN" > /dev/null; then
	err_exit 1 "$PMC_CSV2MEM_BIN not installed or not found in default PATH"
fi

[ "$*" == "" ] && usage_exit 1
if [ "$#" != "4" ] && [ "$#" != "5" ]; then
	usage_exit 1
fi

op="$1"
file="$2"
data_off_h="$3"

if [ "${data_off_h/#0x*/}" != "" ] || [ "${data_off_h//[[:xdigit:]]/}" != "x" ]; then
	err_exit 1 "incorrect data_off_HEX '$data_off_h' (format: 0xNN..)"
fi
((img_off=data_off_h+PMC_IMG_HEADER_LEN))

[ -f "$file" ] || err_exit 1 "image file not found [$file]"
file_size=`stat -c "%s" $file`
[ "$file_size" -le "$PMC_IMG_HEADER_LEN" ] && err_exit 1 "image file too short '$file_size'"
[ "$img_off" -ge "$file_size" ] && err_exit 1 "data offset out of range '$data_off_h' (rule: data_off<=file_size-img_header_len-1)"

case "$op" in
	get)
		[ "$#" != "4" ] && usage_exit 1
		data_len="$4"
		[ "${data_len//[[:digit:]]/}" != "" ] && err_exit 1 "incorrect data_len_DEC '$data_len' (format: <decimal number>)"
		[ "$((img_off+data_len))" -gt "$file_size" ] && err_exit 1 "requested data out of range '$data_off_h+$data_len' (rule: offset+data_len<=file_size-img_header_len-1)"
		xxd -ps -c 4 -s $img_off -l $data_len $file
		;;
	set)
		[ "$#" != "4" ] && usage_exit 1
		data_h="$4"
		if [ "${data_h/#0x*/}" != "" ] || [ "${data_h//[[:xdigit:]][[:xdigit:]]/}" != "0x" ]; then
			err_exit 1 "incorrect data_HEX '$data_h' (format: 0xNN, 0xNNNN, 0xNN..), where the amount of N shall be even"
		fi
		data_len=`echo $data_h | xxd -r -ps | wc -c`
		[ "$((img_off+data_len))" -gt "$file_size" ] && err_exit 1 "requested data out of range '$data_off_h+$data_len' (rule: offset+data_len<=file_size-img_header_len-1)"

		file_bak="$file.bak"
		cp -a "$file" "$file_bak"
		;;
	bit_set)
		[ "$#" != "5" ] && usage_exit 1
		bit_off="$4"
		bit_val="$5"
		[ "${bit_off#[0-7]}" != "" ] && err_exit 1 "incorrect bit_off_DEC '$bit_off' (format: 0-7)"
		[ "${bit_val#[01]}" != "" ] && err_exit 1 "incorrect bit value '$bit_val' (format: 0, 1)"
		data_h=`$0 get $file $data_off_h 1`
		if [ "$bit_val" == "0" ]; then
			((data_h=(0x$data_h&~(1<<bit_off))))
		else
			((data_h=(0x$data_h|(1<<bit_off))))
		fi
		data_h=`printf "%02x" $data_h`
		data_len=`echo $data_h | xxd -r -ps | wc -c`
		[ "$data_len" != "1" ] && err_exit 1 "bug, failed set bit"

		file_bak="$file.bak"
		cp -a "$file" "$file_bak"
		;;
	*)
		usage_exit 1
		;;
esac

if [ "$file_bak" != "" ]; then
	echo $data_h | xxd -r -ps | dd of="$file" conv=notrunc bs=1 seek=$img_off > /dev/null 2>&1 || err_exit 1 "failed updating data with dd"

	file_tmp="$file.tmp"
	dd if="$file" of="$file_tmp" bs=1 skip=$PMC_IMG_HEADER_LEN > /dev/null 2>&1 || err_exit 1 "failed generating raw file with dd"
	$PMC_CRC32_BIN "$file_tmp" | xxd -r -ps | dd of="$file" conv=notrunc bs=1 seek=$PMC_IMG_HEADER_CRC_OFF > /dev/null 2>&1 || err_exit 1 "failed updating crc with dd"
	rm -f $file_tmp
fi

