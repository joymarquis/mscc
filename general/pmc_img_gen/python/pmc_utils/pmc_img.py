#!/usr/bin/python

# PMC image utility
#
# 	$Id: pmc_img.py 8 2013-01-03 18:22:38Z joymarquis@gmail.com $

import sys
import re
from struct import *
from binascii import hexlify, unhexlify

from pmc_crc import PmcCrc32


class PmcImgHeader(object):
	vendor = pack('>Q', 0x0000000000000000)
	prod_id = pack('>B', 0x00)
	hw_rev = pack('>B', 0x00)
	part = pack('>B', 0x00)
	_rsrv = pack('>B', 0x00)
	fw_rev = pack('>L', 0x00000000)
	_len = pack('>L', 0x00000000)
	_crc = pack('>L', 0x00000000)
	_addr = pack('>L', 0x00000000)

	is_correct_len = True
	is_correct_crc = True

	def __init__(self):
		self.set__addr(0xbf000000)

	def get_header(self):
		return self.vendor + self.prod_id + self.hw_rev + self.part \
				+ self._rsrv + self.fw_rev + self._len \
				+ self._crc + self._addr
	
	def get_header_len(self):
		return 28

	def _check_num_range(self, val, min, max, info):
		if not min <= val <= max:
			info += ' [' + hex(val) + '] out of range, ' \
					+ 'expect [' + hex(min) + '-' + hex(max) + ']'
			raise Exception(info)

	def set_vendor(self, string):
		if isinstance(string, str):
			if len(string) > 8:
				raise Exception('vendor [' + string + '] too long')
			self.vendor = pack('>8s', string)

	def set_prod_id(self, val):
		if val != None:
			self._check_num_range(val, 0x00, 0xff, 'prod_id')
			self.prod_id = pack('>B', val)

	def set_hw_rev(self, val):
		if val != None:
			self._check_num_range(val, 0x00, 0xff, 'hw_rev')
			self.hw_rev = pack('>B', val)

	def set_part(self, val):
		if val != None:
			self._check_num_range(val, 0x00, 0xff, 'part')
			self.part = pack('>B', val)

	def set__rsrv(self, val):
		if val != None:
			self._check_num_range(val, 0x00, 0xff, '_rsrv')
			self._rsrv = pack('>B', val)

	def set_fw_rev(self, val):
		if val != None:
			self._check_num_range(val, 0x00, 0xffffffff, 'fw_rev')
			self.fw_rev = pack('>L', val)

	def set__len(self, val):
		if val != None:
			self._check_num_range(val, 0x00, 0xffffffff, '_len')
			self._len = pack('>L', val)
			self.is_correct_len = False
		else:
			self.is_correct_len = True

	def set__crc(self, val):
		if val != None:
			self._check_num_range(val, 0x00, 0xffffffff, '_crc')
			self._crc = pack('>L', val)
			self.is_correct_crc = False
		else:
			self.is_correct_crc = True

	def set__addr(self, val):
		if val != None:
			self._check_num_range(val, 0x00, 0xffffffff, '_addr')
			self._addr = pack('>L', val)


class PmcImg(object):
	header = PmcImgHeader()

	_align = 0
	_padding = pack('>B', 0x00)

	def __init__(self):
		pass
	
	def set__align(self, val):
		if val != None:
			self.header._check_num_range(val, 0x00, 0xff, '_align')
			self._align = val

	def set__padding(self, val):
		if val != None:
			self.header._check_num_range(val, 0x00, 0xff, '_padding')
			self._padding = pack('>B', val)

	def csv2raw(self, csv_d):
		csv_d_list = re.findall("[ ]*0x[0-9a-fA-F]{4}[ ]*,.*", csv_d)

		hex_d = ''
		for elem in csv_d_list:
			h = elem.split(',')
			hex_d += h[9].replace('0x', '').replace('0X', '').replace(' ', '')
		raw_d = unhexlify(hex_d)
		return raw_d

	def raw2img(self, raw_d):
		if self.header.is_correct_crc:
			self.header.set__crc(PmcCrc32().calc(raw_d))
		len_n = len(raw_d)
		pad_n = 0
		if self._align != 0 and self._align != 1:
			remain_n = len_n % self._align
			pad_n = self._align - remain_n if remain_n != 0 else 0
		raw_d = raw_d + self._padding * pad_n
		len_n += pad_n
		if self.header.is_correct_len:
			self.header.set__len(len_n)
		img_d = self.header.get_header() + raw_d
		return img_d

	def csv2img(self, csv_d):
		raw_d = self.csv2raw(csv_d)
		img_d = self.raw2img(raw_d)
		return img_d

	def get_byte(self, img_d, off_n, len_n):
		begin_n = self.header.get_header_len() + off_n
		end_n = self.header.get_header_len() + off_n + len_n
		if end_n > len(img_d):
			raise Exception('out of range for requested bytes')
		bytes_d = img_d[begin_n:end_n]
		return bytes_d

	def set_byte(self, img_d, off_n, bytes_d):
		len_n = len(bytes_d)
		if len_n == 0:
			return img_d
		begin_n = self.header.get_header_len() + off_n
		end_n = self.header.get_header_len() + off_n + len(bytes_d)
		if end_n > len(img_d):
			raise Exception('out of range for the set bytes')
		img_mod_d = img_d[0:begin_n] + bytes_d + img_d[end_n:]
		crc_d = pack('>L', PmcCrc32().calc(img_mod_d[self.header.get_header_len():]))
		img_mod_d = img_mod_d[0:20] + crc_d + img_mod_d[24:]
		return img_mod_d

	def set_bit(self, img_d, off_n, bit_off, bit_val):
		self.header._check_num_range(bit_off, 0x00, 0x7, 'bit offset')
		byte_d = self.get_byte(img_d, off_n, 1)
		byte_n = ord(byte_d)
		bit_msk = 1 << bit_off
		if bit_val == 0:
			byte_n = (byte_n & (~bit_msk)) & 0xff
		else:
			byte_n = (byte_n | bit_msk) & 0xff
		img_mod_d = self.set_byte(img_d, off_n, chr(byte_n))
		crc_d = pack('>L', PmcCrc32().calc(img_mod_d[self.header.get_header_len():]))
		img_mod_d = img_mod_d[0:20] + crc_d + img_mod_d[24:]
		return img_mod_d

