import sys
import re

input_length_pattern = r'^\s*parameter\s+BUS_WIDTH\s*=\s*\d+\s*;\s*$'
tb_file = open('data_synchronizer_tb.v', 'r')
code = tb_file.read()
input_length = int(re.search(input_length_pattern, code, re.MULTILINE).group(0).split('=')[-1].strip().replace(';', ''))

# generate binary strings of random value
import random
inputs = []
for i in range(input_length):
    input = []
    for j in range(2 ** input_length):
        input.append(bin(j)[2:].zfill(input_length))
    random.shuffle(input)
    inputs.append(input)

inputs_file = open('inputs.txt', 'w')

for i in range(len(inputs[input_length - 1])):
    inputs_file.write(inputs[input_length - 1][i])
    if i != len(inputs[input_length - 1]) - 1:
        inputs_file.write('\n')