#!/usr/bin/env python

from __future__ import print_function

import argparse
import time
import sys
sys.path.append('../../../lib/python/pyserial-3.0.1/')
sys.path.append('../../../lib/python/xmodem-0.4.4/')
sys.path.append('../../../lib/python/pexpect-4.0.1/')
sys.path.append('../../../lib/python/ptyprocess-0.5.1/')

import serial
from serial.tools.list_ports import comports
import xmodem
import pexpect
from pexpect import fdpexpect


r_prompt_s = '0x[0-9a-zA-Z]{8}:[0-9a-zA-Z]{4}>'
r_prompt_xmodem_s = 'Please select .*xmodem .*to cancel.*$'


def serial_port_list():
	serial_ports = ''
	for n, (port, desc, hwid) in enumerate(sorted(comports()), 1):
		if serial_ports:
			serial_ports = ''.join([serial_ports, ', ', port])
		else:
			serial_ports = ''.join([port])
	return serial_ports


def cmd_init(_a):
	_a.send(chr(3))
	cmd_cleanup(_a)

def cmd_cleanup(_a):
	time.sleep(0.2)
	tmp_s = ''
	while True:
		try:
			#ret = _a.read(1)
			ret = _a.read_nonblocking(1, timeout=1)
			tmp_s = ''.join([tmp_s, ret])
		except Exception as e:
			print(tmp_s)
			if e.errno == 11:
				break
			else:
				print('e]', cmd_cleanup.__name__, 'flush')
				raise e

def cmd_run(_a, _cmd_s, _o_exp=r_prompt_s, wait_s=0.5):
	cmd_cleanup(_a)
	_a.sendline(_cmd_s)
	time.sleep(wait_s)
	try:
		ret = _a.expect([_o_exp, pexpect.EOF, pexpect.TIMEOUT], timeout=5)
		print('\t====', ret, '====\t', end='')
		print(''.join([_a.before, _a.after]))
	except Exception as e:
		print('e]', cmd_run.__name__)
		raise e


try:
	#parser = argparse.ArgumentParser(usage="%(prog)s [options]", epilog="(note)")
	parser = argparse.ArgumentParser(epilog=''.join(['port(s) available:\n', serial_port_list()]))

	parser.add_argument(
		"-b", "--baudrate",
		dest="baudrate",
		type=int,
		help="set baud rate (%(default)s)",
		default=230400)

	parser.add_argument(
		"serial_port",
		help="serial port device",
		default='/dev/ttyS0')

	parser.add_argument(
		"file",
		nargs='+',
		help="file",
		default=['switchtec_boot.pmc'])

	args = parser.parse_args()


	s = serial.Serial(port=args.serial_port, baudrate=args.baudrate, timeout=5)
	a = fdpexpect.fdspawn(s)

	def x_getc(size, timeout=5):
		#time.sleep(0.001)
		ret = s.read(size)
		#time.sleep(0.001)
		return ret or None

	def x_putc(data, timeout=5):
		time.sleep(0.001)
		ret = s.write(data)
		time.sleep(0.001)
		return ret or None

	cmd_init(a)
	cmd_run(a, 'version')
	cmd_run(a, 'fw_part', wait_s=0.5)

	x = xmodem.XMODEM(x_getc, x_putc, mode='xmodem1k')
	for fn in args.file:
		f = file(fn, 'rb')
		cmd_run(a, 'fw_update', r_prompt_xmodem_s)
		ret = x.send(f, retry=32, quiet=False, timeout=300)
		cmd_run(a, 'fw_part', wait_s=1)
		f.close()

	s.close()

except Exception as e:
	print('e] global')
	print(str(e))
	if e.errno == 6:
		print('\nports available:', serial_port_list())

	exit(e.errno)

