#!/usr/bin/env python
# -*- coding: utf-8 -*-

import csv
import difflib

match_num = 1
match_cutoff = 0.3
col_uniq_n = 0
col_fuzz_n = 1

fi_name = 'addr_list.csv'
fi_delimiter = ';'	# ',', ';'
fi_filter_list_u = ['，', '年级']

fo_name = 'addr_list_new.csv'
fo_delimiter = ';'	# ',', ';'


def print_row_utf8(row, prefix=None):
	if prefix:	print prefix,
	for col in row: print col.decode('utf-8') + '\t',
	print

def filter_str_u(str_u, filter_list_u):
	for i in filter_list_u:
		str_u = str_u.replace(i, '')
	return str_u


with open(fi_name, 'rb') as fi:
	with open(fo_name, 'wb') as fo:
		addrs = csv.reader(fi, delimiter=fi_delimiter, skipinitialspace=True)
		addrs_new = csv.writer(fo, delimiter=fo_delimiter)
		row_curr = next(addrs, None)
		while True:
			if not row_curr:	break
			row_next = next(addrs, None)
			is_same_entry = ((cmp(row_curr[col_uniq_n], row_next[col_uniq_n]) == 0) if row_next else False)
			if not is_same_entry:
				# write current uniq entry
				row_new = ['0'] + row_curr
				addrs_new.writerow(row_new)
				print_row_utf8(row_new)
				row_curr = row_next
				continue

			# fetch duplicate entry
			row = []
			num_dup = 0
			row.append(row_curr)
			row.append(row_next)
			num_dup += 2
			while True:
				row_next = next(addrs, None)
				is_same_entry = (cmp(row_curr[col_uniq_n], row_next[col_uniq_n]) == 0) if row_next else False
				if is_same_entry:
					row.append(row_next)
					num_dup += 1
					continue
				else:
					row_curr = row_next
					break

			# check duplicate entry
			for i in range(num_dup):
				match_context = None
				col_u = filter_str_u(row[i][col_fuzz_n], fi_filter_list_u).decode('utf-8')
				for j in range(i+1, num_dup):
					col_next_u = filter_str_u(row[j][col_fuzz_n], fi_filter_list_u).decode('utf-8')
					match_context = difflib.get_close_matches(col_u, [col_next_u], match_num, match_cutoff)
					if match_context:
						break
				if match_context:
					# write duplicate entry then try next
					row_new = ['1'] + row[i]
					addrs_new.writerow(row_new)
					print_row_utf8(row_new)
				else:
					# save uniq entry into new list
					row_new = ['0'] + row[i]
					addrs_new.writerow(row_new)
					print_row_utf8(row_new)

