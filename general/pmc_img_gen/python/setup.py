import os
import sys
from setuptools import setup, find_packages
import pmc_utils

if sys.version_info[:2] in ((2, 6), (3, 1)):
	# argparse has been added in Python 3.2 / 2.7
	requirements.append('argparse>=1.2.1')

setup(
		name = 'pmc_utils',
		version = pmc_utils.__version__,
		description = 'Generat PMC image file from raw file or csv file',
		author = pmc_utils.__author__,
		author_email = 'qing_hou AT pmc_sierra D0T com',
		license = pmc_utils.__license__,
		packages = find_packages(),
		py_modules = ['pmc_utils'],
		url = 'http://code.google.com/p/pmc-utils/'
		include_package_data = True,
		zip_safe = False,
		)
