#!/bin/bash

ME="`basename $0`"
# boot_mips, istr_flash, sxp_evbd_rom, boot_cfg_mod, istr_flash, sxp_evbd_rom

part_id_list="255 1 5 3 2 6"
part_id_last=6
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


export PATH="`dirname $0`/pmc-ecc:$PATH:."
PMC_ECC_BIN=pmc-ecc

function usage_exit()
{
	if [ "$2" != "" ]; then
		echo "$2"
	else
		echo "Usage: $ME of=FILE part255=FILE part1=FILE part5=FILE part3=FILE part2=FILE part6=FILE"
		echo ""
		echo "Generate whole PMC ecc flash block from raw binary"
		echo ""
		echo "Examples:"
		echo "  $ME of=ecc_flash_block.dat \\"
		echo "        part255=boot_mips.part part1=istr_flash.part part5=sxp_evbd_rom.part \\"
		echo "        part3=boot_cfg.part part2=istr_flash.part part6=sxp_evbd_rom.part"
		echo ""
		echo '        (Ver: $Id: pmc-ecc-flash-block-gen.sh 8 2013-01-03 18:22:38Z joymarquis@gmail.com $)'
	fi
	if [ "${1//[0-9]/}" == "" ]; then
		exit $1
	elif [ "$1" != "0" ]; then
		exit 1
	fi
	exit 0
}

if ! which "$PMC_ECC_BIN" > /dev/null; then
	echo ""
	usage_exit 1 "Error: $PMC_ECC_BIN not installed or not found in default PATH"
fi

[ "$*" == "" ] && usage_exit 1

for i; do
	case "$i" in
		of=*|part255=*|part1=*|part5=*|part3=*|part2=*|part6=*)
			if [ "${i##*=}" == "" ]; then
				usage_exit 1 "Error: incorrect parameter [$i]"
			fi
			;;
		*)
			usage_exit 1 "Error: invalid parameter [$i]"
			;;
	esac
	eval ${i%%=*}=\"${i#*=}\"
done

[ "$of" == "" ] && usage_exit 1 "Error: parameter 'of' not provided"

[ "$part255" != "" ] && { [ -f "$part255" ] || usage_exit 1 "Error: file not exist [$part255]"; }
[ "$part1" != "" ] && { [ -f "$part1" ] || usage_exit 1 "Error: file not exist [$part1]"; }
[ "$part5" != "" ] && { [ -f "$part5" ] || usage_exit 1 "Error: file not exist [$part5]"; }
[ "$part3" != "" ] && { [ -f "$part3" ] || usage_exit 1 "Error: file not exist [$part3]"; }
[ "$part2" != "" ] && { [ -f "$part2" ] || usage_exit 1 "Error: file not exist [$part2]"; }
[ "$part6" != "" ] && { [ -f "$part6" ] || usage_exit 1 "Error: file not exist [$part6]"; }

img_size=`printf %d ${flash_off_hex_e[part_id_last]}`
((img_size+=1))
img_size=`printf 0x%08x $img_size`

pmc-ecc create $of $img_size
if [ "$part255" != "" ]; then
	pmc-ecc fill $of $part255 ${flash_off_hex_b[255]} ${flash_off_hex_e[255]}
fi
if [ "$part1" != "" ]; then
	pmc-ecc fill $of $part1 ${flash_off_hex_b[1]} ${flash_off_hex_e[1]}
fi
if [ "$part5" != "" ]; then
	pmc-ecc fill $of $part5 ${flash_off_hex_b[5]} ${flash_off_hex_e[5]}
fi
if [ "$part3" != "" ]; then
	pmc-ecc fill $of $part3 ${flash_off_hex_b[3]} ${flash_off_hex_e[3]}
fi
if [ "$part2" != "" ]; then
	pmc-ecc fill $of $part2 ${flash_off_hex_b[2]} ${flash_off_hex_e[2]}
fi
if [ "$part6" != "" ]; then
	pmc-ecc fill $of $part6 ${flash_off_hex_b[6]} ${flash_off_hex_e[6]}
fi

