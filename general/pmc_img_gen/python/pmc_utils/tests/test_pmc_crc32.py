#!/usr/bin/env python

import unittest
import sys; sys.path.append(sys.path[0] + "/../../pmc_utils")
from pmc_crc import PmcCrc32

class PmcCrc32Test(unittest.TestCase):
	def setUp(self):
		self.crc32 = PmcCrc32()

	def test_calc(self):
		self.assertEqual(self.crc32.calc(self.crc32.self_test_data_str), self.crc32.self_test_data_crc32)

	def test_calc_empty_str(self):
		self.assertEqual(self.crc32.calc(''), 0)

	def test_calc_none_arg(self):
		self.assertEqual(self.crc32.calc(None), 0)

	def test_table_item_num(self):
		self.assertEqual(len(self.crc32.crc32_tbl), self.crc32.crc32_tbl_item_num)

	def test_table_item000(self):
		self.assertEqual(self.crc32.crc32_tbl[0], 0x00000000)

	def test_table_item001(self):
		self.assertEqual(self.crc32.crc32_tbl[1], 0x04c11db7)

	def test_table_item100(self):
		self.assertEqual(self.crc32.crc32_tbl[100], 0xbfa1b04b)

	def test_table_item255(self):
		self.assertEqual(self.crc32.crc32_tbl[255], 0xb1f740b4)

	def tearDown(self):
		pass



if __name__ == "__main__":
	suite_pmc_crc32 = unittest.TestLoader().loadTestsFromTestCase(PmcCrc32Test)
	unittest.TextTestRunner(verbosity=2).run(suite_pmc_crc32)

