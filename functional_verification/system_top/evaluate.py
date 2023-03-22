import re
import sys

def parse_verilog_memory_file():
    memory_file = open('register_file_verilog.mem', 'r')
    pattern = r'^@[0-9a-fA-F]+\s[01]+$'
    memory = re.findall(pattern, memory_file.read(), re.MULTILINE)
    register_file_data = []
    for data in memory:
        data = data.split(' ')[-1]
        register_file_data.append(data)
        
    memory_file.close()
    return register_file_data


verilog_memory_file = parse_verilog_memory_file()


memory_file = open('register_file_python.mem', 'r')
python_memory_file = memory_file.read().splitlines()
memory_file.close()

memory_failed_test_cases = 0
for i in range(len(python_memory_file)):
    if python_memory_file[i] != verilog_memory_file[i]:
        print(f'Memory files mismatch at address: {i}\n')
        memory_failed_test_cases += 1

if memory_failed_test_cases == 0:
    print('Memory files match.\n')


system_outputs_python = open('system_outputs_python.txt', 'r')
system_outputs_python = system_outputs_python.read().splitlines()

system_outputs_verilog = open('system_outputs_verilog.txt', 'r')
system_outputs_verilog = system_outputs_verilog.read().splitlines()

results_failed_test_cases = 0
for i in range(len(system_outputs_python)):
    if system_outputs_python[i] != system_outputs_verilog[i]:
        print(f'System outputs mismatch at line: {i + 1}\n')
        results_failed_test_cases += 1

if results_failed_test_cases == 0:
    print('System outputs match.\n')
    print('All the test cases passed successfully.')
    total_test_cases = sys.argv[1]
    print(f'Total: {total_test_cases}/{total_test_cases}.')
else:    
    print('Some test cases failed.\n')
