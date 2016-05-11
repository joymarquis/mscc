#!/usr/bin/env python

import sys

import pmc_utils
from pmc_utils.pmc_crc import PmcCrc32


try:
	import argparse
except ImportError:
	sys.path.append(sys.path[0] + "/pmc_utils/lib/argparse-1.2.1")
	import argparse


def main():

	p = argparse.ArgumentParser(epilog='\n\tVer: $Id: pmc_crc32.py 3 2012-06-10 14:57:21Z joymarquis@gmail.com $',
			formatter_class=argparse.RawDescriptionHelpFormatter)
	p.add_argument('--version', action='version', version='%(prog)s '+pmc_utils.__version__)
	p.add_argument('p_raw_file', metavar='RAW_FILE',
			help='raw file to be calculated')
	opts = p.parse_args()


	with open(opts.p_raw_file, 'rb') as raw_f:
		raw_d = raw_f.read()

	print '%08x' % PmcCrc32().calc(raw_d)


if __name__ == "__main__":
	main()
