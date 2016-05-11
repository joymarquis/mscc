#!/usr/bin/env python

_my_id = '$Id: pmc_img_gen.py 8 2013-01-03 18:22:38Z joymarquis@gmail.com $'

import sys

import pmc_utils
from pmc_utils.pmc_helper import PmcHelper
from pmc_utils.pmc_img import PmcImg, PmcImgHeader

try:
	import argparse
except ImportError:
	sys.path.append(sys.path[0] + "/pmc_utils/lib/argparse-1.2.1")
	import argparse


examples = '''
Examples:
  pmc_img_gen.py --if_type=csv --if=istr_flash.csv --of=istr_flash.bin \\
      --fw_rev=0x0403000b --part=0x02 --prod_id=0x1 --hw_rev=0xa --vendor=PMC_ISTR
  pmc_img_gen.py --if_type=csv --if=boot_cfg.csv --of=boot_cfg.bin \\
      --fw_rev=0x0403000b --part=0x03 --prod_id=0x1 --hw_rev=0xa --vendor=PMC
  pmc_img_gen.py --if_type=raw --if=sxp_evbd_rom.mem --of=sxp_evbd_rom.bin \\
      --fw_rev=0x0403000b --part=0x05 --prod_id=0x1 --hw_rev=0xa --vendor=PMC
  pmc_img_gen.py --if_type=raw --if=boot_mips_sxp.mem --of=boot_mips.bin \\
      --fw_rev=0x0403000b --part=0xff --prod_id=0x1 --hw_rev=0xa --vendor=PMC_BOOT
'''


def main():
	H=PmcHelper()

	p = argparse.ArgumentParser(add_help=False)
	p.add_argument('-h', action='count', default=0, dest='p_d')
	(opts, args) = p.parse_known_args()

	epilog_str = '\n\n\t' + _my_id
	epilog_str = examples + epilog_str if opts.p_d > 1 else epilog_str
	is_test = True if opts.p_d > 2 else False
	is_hack = True if opts.p_d > 3 else False

	p = argparse.ArgumentParser(description='The "0x" prefix can be omitted for hex format',
			epilog=epilog_str, formatter_class=argparse.RawDescriptionHelpFormatter)
	p.add_argument('--version', action='version', version='%(prog)s '+pmc_utils.__version__)
	p.add_argument('-v', action='count', default=0,
			dest='p_v', help='verbose, twice to be more verbose')

	p.add_argument('--if_type', metavar='<raw|csv>', choices=('raw', 'csv'), required=True,
			dest='p_if_type', help='type of input file')
	p.add_argument('--if', metavar='IN_FILE', required=True,
			dest='p_if', help='input file')
	p.add_argument('--of', metavar='OUT_FILE', required=True,
			dest='p_of', help='output file')

	g = p.add_argument_group('pmc image headers')
	g.add_argument('--fw_rev', metavar='0xNNNNNNNN',
			dest='p_fw_rev', help='firmware revision')
	g.add_argument('--part', metavar='0xNN',
			dest='p_part', help='partition number')
	g.add_argument('--prod_id', metavar='0xNN',
			dest='p_prod_id', help='product id')
	g.add_argument('--hw_rev', metavar='0xNN',
			dest='p_hw_rev', help='hardware revision')
	g.add_argument('--vendor', metavar='CCCCCCCC',
			dest='p_vendor', help='vendor charactors')

	g.add_argument('--_crc', metavar='0xNNNNNNNN',
			dest='p__crc',
			help='custom crc, skip calcuate' if is_test else argparse.SUPPRESS)
	g.add_argument('--_len', metavar='0xNNNNNNNN',
			dest='p__len',
			help='custom len, skip calculate' if is_test else argparse.SUPPRESS)
	g.add_argument('--_addr', metavar='0xNNNNNNNN',
			dest='p__addr',
			help='custom addr, drop preset 0xbf000000' if is_test else argparse.SUPPRESS)
	g.add_argument('--_rsrv', metavar='0xNNNNNNNN',
			dest='p__rsrv',
			help='custom rsrv, drop preset 0x00' if is_test else argparse.SUPPRESS)

	g.add_argument('--_align', metavar='0xNN',
			dest='p__align',
			help='align bytes for raw image, default no align' if is_hack else argparse.SUPPRESS)
	g.add_argument('--_padding', metavar='0xNN',
			dest='p__padding', help='padding data for align, default 0x00' if is_hack else argparse.SUPPRESS)

	opts = p.parse_args()

	H.message_level = opts.p_v

	with open(opts.p_if, 'rb') as in_f:
		in_d = in_f.read()

	img = PmcImg()
	hdr = img.header

	H.dprint(1, 'build img header from parameter')
	hdr.set_fw_rev(int(opts.p_fw_rev, 16)) if opts.p_fw_rev else True
	hdr.set_part(int(opts.p_part, 16)) if opts.p_part else True
	hdr.set_prod_id(int(opts.p_prod_id, 16)) if opts.p_prod_id else True
	hdr.set_hw_rev(int(opts.p_hw_rev, 16)) if opts.p_hw_rev else True
	hdr.set_vendor(opts.p_vendor) if opts.p_vendor else True
	hdr.set__crc(int(opts.p__crc, 16)) if opts.p__crc else True
	hdr.set__len(int(opts.p__len, 16)) if opts.p__len else True
	hdr.set__addr(int(opts.p__addr, 16)) if opts.p__addr else True
	hdr.set__rsrv(int(opts.p__rsrv, 16)) if opts.p__rsrv else True
	H.hexdump(hdr.get_header(), 32, 4, 'header data') if H.is_message_allow(2) else None

	img.set__align(int(opts.p__align, 16)) if opts.p__align else True
	img.set__padding(int(opts.p__padding, 16)) if opts.p__padding else True
	if opts.p_if_type == 'raw':
		raw_d = in_d
	elif opts.p_if_type == 'csv':
		H.dprint(1, 'generate raw data from csv')
		csv_d = in_d
		raw_d = img.csv2raw(csv_d)
		H.hexdump(raw_d, 32, 4, 'crc raw data') if H.is_message_allow(3) else None

	H.dprint(1, 'generate img data from raw')
	img_d = img.raw2img(raw_d)
	H.hexdump(img_d, 32, 4, 'image data') if H.is_message_allow(2) else None

	H.dprint(1, 'write result to out file')
	with open(opts.p_of, 'ab+') as out_f:
		out_f.truncate(0)
		out_f.write(img_d)


if __name__ == "__main__":
	main()

