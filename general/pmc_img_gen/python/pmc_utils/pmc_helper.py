#!/usr/bin/python

# PMC helper functions
#
# 	$Id: pmc_helper.py 3 2012-06-10 14:57:21Z joymarquis@gmail.com $

import sys


class PmcHelper(object):
	def __init__(self):
		self.message_level = 0
		self.msg_prefix = '] '
		pass
	
	def hexdump(self, buf, cols, group, info=None):
		index = 0
		tmp = ''
		for c in buf:
			tmp += '{0:02x}'.format(ord(c))
			index += 1
			if index != 0:
				if index % group == 0:
					tmp += ' '
				if index % cols == 0:
					tmp += '\n'
		if info:
			tmp = 'hexdump: ' + info + '\n' + tmp
		print tmp

	def set_message_level(self, level):
		if isinstance(level, int):
			self.message_level = level

	def is_message_allow(self, level):
		return True if level <= self.message_level else False

	def dprint(self, level, msg):
		if self.is_message_allow(level):
			print self.msg_prefix + msg

