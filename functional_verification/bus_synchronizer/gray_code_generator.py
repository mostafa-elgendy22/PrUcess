import sys
import re

gray_code_length_pattern = r'^\s*parameter\s+BUS_WIDTH\s*=\s*\d+\s*;\s*$'
tb_file = open('bus_synchronizer_tb.v', 'r')
code = tb_file.read()
gray_code_length = int(re.search(gray_code_length_pattern, code, re.MULTILINE).group(0).split('=')[-1].strip().replace(';', ''))

gray_codes = [['0', '1']]

for i in range(gray_code_length - 1):
    L1 = gray_codes[i]
    L2 = L1.copy()
    L2.reverse()
    L1 = ['0' + x for x in L1]
    L2 = ['1' + x for x in L2]
    gray_codes.append(L1 + L2)

gray_codes_file = open('gray_codes.txt', 'w')

for i in range(len(gray_codes[gray_code_length - 1])):
    gray_codes_file.write(gray_codes[gray_code_length - 1][i])
    if i != len(gray_codes[gray_code_length - 1]) - 1:
        gray_codes_file.write('\n')