#!/bin/bash

header_data=""
header_data_len=28
tail_data=""
tail_data_len=22

part_id_list="255 1 5 3 2 6"
part_id_last="6"
flash_off_hex_b[255]="0x00000000"
flash_off_hex_e[255]="0x00017fff"
flash_off_hex_b[1]="0x00020000"
flash_off_hex_e[1]="0x0002ffff"
flash_off_hex_b[5]="0x00040000"
flash_off_hex_e[5]="0x001dffff"
flash_off_hex_b[3]="0x00200000"
flash_off_hex_e[3]="0x0020ffff"
flash_off_hex_b[2]="0x00220000"
flash_off_hex_e[2]="0x0022ffff"
flash_off_hex_b[6]="0x00240000"
flash_off_hex_e[6]="0x003dffff"
flash_off_hex_b[0]=${flash_off_hex_b[255]}
flash_off_hex_e[0]=${flash_off_hex_e[255]}


export PATH="`dirname $0`/pmc-crc32:`dirname $0`/pmc-csv2mem:$PATH:."

PMC_CRC32_BIN=pmc-crc32		# pmc-crc32.sh
PMC_CSV2MEM_BIN=pmc-csv2mem.sh
EXAMPLE_VER=0x0403000b

BIN_USED="bash which basename grep dirname xxd cat wc mv cut rm ls sed"

function usage()
{
	echo "Usage: `basename $0` if_type=<raw|csv> if=IN_FILE of=OUT_FILE \\"
	echo "  [fw_rev=0xNNNNNNNN] [part=0xNN] [vendor=CCCCCCCC] [prod_id=0xNN] [hw_rev=0xNN] \\"
	echo "  [of_bonus=OUT_FILE_FOR_RAW_PARTITION__USED_IN_ECC_BLOCK_GENERATE]"
	echo ""
	echo "Generate PMC image file from raw binary or csv file"
	echo ""
	echo "Examples:"
	echo "  pmc-img-gen.sh  if_type=csv  if=istr_flash.csv of=istr_flash.bin \\"
	echo "    fw_rev=$EXAMPLE_VER part=0x02 prod_id=0x1 hw_rev=0xa vendor=PMC_ISTR \\"
	echo "    of_bonus=istr_flash.part"
	echo "  pmc-img-gen.sh  if_type=csv  if=boot_cfg.csv of=boot_cfg.bin \\"
	echo "    fw_rev=$EXAMPLE_VER part=0x03 prod_id=0x1 hw_rev=0xa vendor=PMC \\"
	echo "    of_bonus=boot_cfg.part"
	echo "  pmc-img-gen.sh  if_type=raw  if=sxp_evbd_rom.mem of=sxp_evbd_rom.bin \\"
	echo "    fw_rev=$EXAMPLE_VER part=0x05 prod_id=0x1 hw_rev=0xa vendor=PMC \\"
	echo "    of_bonus=sxp_evbd_rom.part"
	echo "  pmc-img-gen.sh  if_type=raw  if=boot_mips_sxp.mem of=boot_mips.bin \\"
	echo "    fw_rev=$EXAMPLE_VER part=0xff prod_id=0x1 hw_rev=0xa vendor=PMC_BOOT \\"
	echo "    of_bonus=boot_mips.part"
	echo ""
	echo "Debug options: Overrides auto generated valid value"
	echo "  _crc=0xNNNNNNNN _len=0xNN _addr=0xNNNNNNNN _rsrv=0xNN"
	echo ""
	echo '    (Ver: $Id: pmc-img-gen.sh 8 2013-01-03 18:22:38Z joymarquis@gmail.com $)'
}

if ! which "$PMC_CRC32_BIN" > /dev/null; then
	echo ""
	echo "Error: $PMC_CRC32_BIN not installed or not found in default PATH"; exit 1
fi

if ! which "$PMC_CSV2MEM_BIN" > /dev/null; then
	echo ""
	echo "Error: $PMC_CSV2MEM_BIN not installed or not found in default PATH"; exit 1
fi

[ "$*" == "" ] && { usage; exit 1; }

for i; do
	case "$i" in
		if_type=*|if=*|of=*|vendor=*|of_bonus=*)
			;;
		prod_id=*|hw_rev=*|part=*|_rsrv=*|fw_rev=*|_len=*|_crc=*|_addr=*)
			if ! echo "$i" | grep -q "= *0x"; then
				echo "Error: incorrect format [$i], require 0x for number"; exit 1
			fi
			;;
		*)
			echo "Error: Invalid parameter [$i]"; usage; exit 1
			;;
	esac
	eval ${i%%=*}=\"${i#*=}\"
done

_if="$if"

[ -f "$_if" ] || { echo "Error: IN_FILE not found [$_if]"; exit 1; }
[ "$of" == "" ] && { echo "Error: of=OUT_FILE not provided"; exit 1; }

case "_$if_type" in
	_raw)
		;;
	_csv)
		if_csv="$_if"
		_if="$_if.raw"
		$PMC_CSV2MEM_BIN $if_csv $_if
		;;
	*)
		echo "Error: if_type not provided or invalid (raw, csv)"; usage; exit 1
		;;
esac


vendor_d=`echo -ne "$vendor\0\0\0\0\0\0\0\0" | xxd -ps`
if [ "${#vendor_d}" -gt "32" ]; then
	echo "Error: vendor too long [$vendor]"; exit 1
fi
vendor_d="${vendor_d::16}"
if [ "${#vendor_d}" != "16" ]; then
	echo "Error: Failed for vendor [$vendor_d]"; exit 1
fi
header_data="$header_data$vendor_d"

prod_id_d=`printf %02x $prod_id` || { echo "Error: bad prod_id [$prod_id]"; exit 1; }
#echo $prod_id_d
if [ "${#prod_id_d}" != "2" ]; then
	echo "Error: prod_id too long [$prod_id]"; exit 1
fi
header_data="$header_data$prod_id_d"

hw_rev_d=`printf %02x $hw_rev` || { echo "Error: bad hw_rev [$hw_rev]"; exit 1; }
#echo $hw_rev_d
if [ "${#hw_rev_d}" != "2" ]; then
	echo "Error: hw_rev too long [$hw_rev]"; exit 1
fi
header_data="$header_data$hw_rev_d"

part_d=`printf %02x $part` || { echo "Error: bad part [$part]"; exit 1; }
#echo $part_d
if [ "${#part_d}" != "2" ]; then
	echo "Error: part too long [$part]"; exit 1
fi
header_data="$header_data$part_d"

_rsrv_d=`printf %02x $_rsrv` || { echo "Error: bad _rsrv [$_rsrv]"; exit 1; }
#echo $_rsrv_d
if [ "${#_rsrv_d}" != "2" ]; then
	echo "Error: _rsrv too long [$_rsrv]"; exit 1
fi
header_data="$header_data$_rsrv_d"

fw_rev_d=`printf %08x $fw_rev` || { echo "Error: bad fw_rev [$fw_rev]"; exit 1; }
#echo $fw_rev_d
if [ "${#fw_rev_d}" != "8" ]; then
	echo "Error: fw_rev too long [$fw_rev]"; exit 1
fi
header_data="$header_data$fw_rev_d"

if [ "$_len" == "" ]; then
	_len=`cat "$_if" | wc -c`
fi
_len_d=`printf %08x $_len` || { echo "Error: bad _len [$_len]"; exit 1; }
#echo $_len_d
if [ "${#_len_d}" != "8" ]; then
	echo "Error: _len too long [$_len]"; exit 1
fi
header_data="$header_data$_len_d"

if [ "$_crc" == "" ]; then
	_crc="0x`pmc-crc32 "$_if"`"
fi
_crc_d=`printf %08x $_crc` || { echo "Error: bad _crc [$_crc]"; exit 1; }
#echo $_crc_d
if [ "${#_crc_d}" != "8" ]; then
	echo "Error: _crc too long [$_crc]"; exit 1
fi
header_data="$header_data$_crc_d"

if [ "$_addr" == "" ]; then
	_addr="0xbf000000"
fi
_addr_d=`printf %08x $_addr` || { echo "Error: bad _addr [$_addr]"; exit 1; }
#echo $_addr_d
if [ "${#_addr_d}" != "8" ]; then
	echo "Error: _addr too long [$_addr]"; exit 1
fi
header_data="$header_data$_addr_d"


[ -f "$of" ] && mv $of $of.bak
echo $header_data | xxd -r -ps > $of

of_len=`cat "$of" | wc -c`
#echo $of_len
if [ "$of_len" != "$header_data_len" ]; then
	echo "Error: expect header len [$header_data_len], but generated len [$of_len]"; exit 1
fi

cat "$_if" >> "$of"
((of_len_expected=of_len+_len))

of_len=`cat "$of" | wc -c`
if [ "$of_len" -ne "$of_len_expected" ]; then
	echo "Error: incorrect generated image len [$of_len], expect [$of_len_expected]"; exit 1
fi


if [ "$of_bonus" != "" ]; then
	cat "$_if" > "$of_bonus"
	part_n=`printf %d $part`
	if [ "${flash_off_hex_b[part_n]}" == "" ]; then
		echo "Error: no bonus because part is unrecognized"; exit 1
	fi
	part_len_n=$((${flash_off_hex_e[part_n]}-${flash_off_hex_b[part_n]}+1))
	((fill_len_n=part_len_n-tail_data_len-_len))
	fill_d=`xxd -ps -l $fill_len_n /dev/zero`
	fill_d=`echo "$fill_d" | sed "s/00/ff/g"`
	_crc_d_rev=`echo $_crc_d | sed "s/\(..\)\(..\)\(..\)\(..\)/\4\3\2\1/g"`
	_len_d_rev=`echo $_len_d | sed "s/\(..\)\(..\)\(..\)\(..\)/\4\3\2\1/g"`
	tail_d="$vendor_d$prod_id_d$hw_rev_d$fw_rev_d$_len_d_rev$_crc_d_rev"
	bonus_d="$fill_d$tail_d"
	echo $bonus_d | xxd -r -ps >> $of_bonus
	part_len_gen_n="`cat $of_bonus | wc -c`"
	if [ "$part_len_gen_n" != "$part_len_n" ]; then
		echo "Error: expect length $part_len_n, but generated $part_len_gen_n"; exit 1
	fi
fi

