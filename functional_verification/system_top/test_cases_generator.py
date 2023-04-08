import re
from bitarray import bitarray
from change_prescale import write_prescale

prescale = 8

def main():
    # -------------------------------- Write test cases here ------------------------------
    # register_file_write(0, 10)
    # register_file_read(3)
    # ALU_operation_with_operands(20, 18, '&')
    # register_file_read(0)
    # ALU_operation_with_operands(10, 9, '+')
    # ALU_operation_without_operands('<<')
    # ALU_operation_with_operands(128, 127, '+')
    # ALU_operation_without_operands('-')
    ALU_operation_without_operands('~&')
    # ALU_operation_without_operands('~|')
    # ALU_operation_without_operands('~^')
    # ALU_operation_without_operands('>>')
    # ALU_operation_with_operands(255, 66, '-')
    # ALU_operation_with_operands(2, 9, '-')
    # ALU_operation_without_operands('-')
    # ALU_operation_without_operands('<<')
    # ALU_operation_without_operands('&')
    # ALU_operation_without_operands('|')
    # ALU_operation_without_operands('^')
    # ALU_operation_without_operands('*')
    # register_file_write(7, 20)
    # register_file_read(7)
    # register_file_write(0, 10)
    # ALU_operation_without_operands('-')
    # ALU_operation_without_operands('^')


def read_parameters():
    parity_configuration_pattern = r'^\s*memory\[i\]\s*<=\s*\'b[01]{6}_[01]_[01]\s*;\s*$'
    register_file = open('../../RTL/register_file/register_file.v', 'r')
    code = register_file.read()
    parity_enable = int(re.search(parity_configuration_pattern, code, re.MULTILINE).group(0).split('<=')[-1].strip().replace(';', '').strip()[-1])
    parity_type = int(re.search(parity_configuration_pattern, code, re.MULTILINE).group(0).split('<=')[-1].strip().replace(';', '').strip()[-3])
    register_file.close()

    data_width_pattern = r'^\s*parameter\s+DATA_WIDTH\s*=\s*\d+\s*;\s*$'
    tb_file = open('system_top_tb.v', 'r')
    code = tb_file.read()
    data_width = int(re.search(data_width_pattern, code, re.MULTILINE).group(0).split('=')[-1].strip().replace(';', ''))

    register_file_depth_pattern = r'^\s*parameter\s+REGISTER_FILE_DEPTH\s*=\s*\d+\s*;\s*$'
    register_file_depth = int(re.search(register_file_depth_pattern, code, re.MULTILINE).group(0).split('=')[-1].strip().replace(';', ''))
    tb_file.close()

    return parity_enable, parity_type, data_width, register_file_depth


def write_test_cases_configuration():
    tb_file = open('system_top_tb.v', 'r')
    code = tb_file.read()
    test_cases_depth_pattern = r'^\s*localparam\s+TEST_CASES_DEPTH\s*=\s*\d+\s*;\s*$'
    code = re.sub(test_cases_depth_pattern, '\n\tlocalparam TEST_CASES_DEPTH = ' + str(test_cases_depth[0]) + ';\n', code, flags=re.MULTILINE)
    
    test_cases_width_pattern = r'^\s*localparam\s+TEST_CASES_WIDTH\s*=\s*\d+\s*;\s*$'
    code = re.sub(test_cases_width_pattern, '\n\tlocalparam TEST_CASES_WIDTH = ' + str(test_cases_width) + ';\n', code, flags=re.MULTILINE)
    tb_file.close()

    tb_file = open('system_top_tb.v', 'w')
    tb_file.write(code)
    tb_file.close()


def calculate_parity(parity_type, message):
    if parity_type:
        parity_bit = (message.count(1) % 2)
        parity_bit = 1 if parity_bit == 0 else 0
    else:
        parity_bit = message.count(1) % 2

    return parity_bit

def write_register_file_memory():
    register_file_memory_file = open('output_files/register_file_python.mem', 'w')
    for i in range(register_file_depth):
        register_file_memory_file.write(register_file_memory[i] + '\n')
    register_file_memory_file.close()


def to_binary(number, data_width):
    return bitarray('{0:0{1}b}'.format(number, data_width))


def register_file_write(write_address, write_data):
    total_test_cases[0] += 1
    write_address = to_binary(write_address, data_width)
    write_data = to_binary(write_data, data_width)

    test_cases_depth[0] += 3
    register_file_memory[int(write_address.to01(), 2)] = write_data.to01()
    
    command_op_code = bitarray('10101010')

    if parity_enable:
        parity_bit = calculate_parity(parity_type, command_op_code)
        command_op_code = bitarray('1' + str(parity_bit) + command_op_code.to01() + '0')
    else:
        command_op_code = bitarray('1' + command_op_code.to01() + '0')

    test_cases_file.write(command_op_code.to01() + '\n')

    if parity_enable:
        parity_bit = calculate_parity(parity_type, write_address)
        write_address = bitarray('1' + str(parity_bit) + write_address.to01() + '0')
    else:
        write_address = bitarray('1' + write_address.to01() + '0')

    test_cases_file.write(write_address.to01() + '\n')

    if parity_enable:
        parity_bit = calculate_parity(parity_type, write_data)
        write_data = bitarray('1' + str(parity_bit) + write_data.to01() + '0')
    else:
        write_data = bitarray('1' + write_data.to01() + '0')
    test_cases_file.write(write_data.to01() + '\n')


def register_file_read(read_address):
    total_test_cases[0] += 1
    read_address = to_binary(read_address, data_width)
    
    test_cases_depth[0] += 2
    results_file_depth[0] += 1
    
    test_cases_results_file.write(register_file_memory[int(read_address.to01(), 2)] + '\n')
    command_op_code = bitarray('10111011')

    if parity_enable:
        parity_bit = calculate_parity(parity_type, command_op_code)
        command_op_code = bitarray('1' + str(parity_bit) + command_op_code.to01() + '0')
    else:
        command_op_code = bitarray('1' + command_op_code.to01() + '0')

    test_cases_file.write(command_op_code.to01() + '\n')

    if parity_enable:
        parity_bit = calculate_parity(parity_type, read_address)
        read_address = bitarray('1' + str(parity_bit) + read_address.to01() + '0')
    else:
        read_address = bitarray('1' + read_address.to01() + '0')
    test_cases_file.write(read_address.to01() + '\n')
    

def ALU_operation_with_operands(operand_A, operand_B, ALU_function_symbol):
    total_test_cases[0] += 1
    test_cases_depth[0] += 4
    results_file_depth[0] += 2

    operand_A_binary = to_binary(operand_A, 2 * data_width)
    operand_B_binary = to_binary(operand_B, 2 * data_width)
    register_file_memory[0] = operand_A_binary.to01()[data_width:]
    register_file_memory[1] = operand_B_binary.to01()[data_width:]


    if ALU_function_symbol == '+':
        ALU_result = bitarray(to_binary(operand_A + operand_B, data_width * 2))
    elif ALU_function_symbol == '-':
        ALU_result = operand_A - operand_B
        if ALU_result < 0:
            temp = -ALU_result
            temp = ~bitarray(to_binary(temp, data_width * 2))
            temp = int(temp.to01(), 2) + 1
            ALU_result = bitarray(to_binary(temp, data_width * 2))
        else:
            ALU_result = bitarray(to_binary(ALU_result, data_width * 2))
    elif ALU_function_symbol == '*':
        ALU_result = bitarray(to_binary(operand_A * operand_B, data_width * 2))
    elif ALU_function_symbol == '/':
        ALU_result = bitarray(to_binary(int(operand_A / operand_B), data_width * 2))
    elif ALU_function_symbol == '&':
        ALU_result = operand_A_binary & operand_B_binary
    elif ALU_function_symbol == '|':
        ALU_result = operand_A_binary | operand_B_binary
    elif ALU_function_symbol == '~&':
        ALU_result = ~(operand_A_binary & operand_B_binary)
    elif ALU_function_symbol == '~|':
        ALU_result = ~(operand_A_binary | operand_B_binary)
    elif ALU_function_symbol == '^':
        ALU_result = operand_A_binary ^ operand_B_binary
    elif ALU_function_symbol == '~^':
        ALU_result = ~(operand_A_binary ^ operand_B_binary)
    elif ALU_function_symbol == '==':
        ALU_result = 1 if operand_A == operand_B else 0
        ALU_result = bitarray(to_binary(ALU_result, data_width * 2))
    elif ALU_function_symbol == '>':
        ALU_result = 1 if operand_A > operand_B else 0
        ALU_result = bitarray(to_binary(ALU_result, data_width * 2))
    elif ALU_function_symbol == '<':
        ALU_result = 1 if operand_A < operand_B else 0
        ALU_result = bitarray(to_binary(ALU_result, data_width * 2))
    elif ALU_function_symbol == '>>':
        ALU_result = operand_A_binary >> 1
    elif ALU_function_symbol == '<<':
        ALU_result = operand_A_binary << 1

    command_op_code = bitarray('11001100')
    if parity_enable:
        parity_bit = calculate_parity(parity_type, command_op_code)
        command_op_code = bitarray('1' + str(parity_bit) + command_op_code.to01() + '0')
    else:
        command_op_code = bitarray('1' + command_op_code.to01() + '0')

    test_cases_file.write(command_op_code.to01() + '\n')

    if parity_enable:
        parity_bit = calculate_parity(parity_type, operand_A_binary[data_width:])
        operand_A_binary = bitarray('1' + str(parity_bit) + operand_A_binary.to01()[data_width:] + '0')
    else:
        operand_A_binary = bitarray('1' + operand_A_binary.to01()[data_width:] + '0')
    test_cases_file.write(operand_A_binary.to01() + '\n')

    if parity_enable:
        parity_bit = calculate_parity(parity_type, operand_B_binary[data_width:])
        operand_B_binary = bitarray('1' + str(parity_bit) + operand_B_binary.to01()[data_width:] + '0')
    else:
        operand_B_binary = bitarray('1' + operand_B_binary.to01()[data_width:] + '0')
    test_cases_file.write(operand_B_binary.to01() + '\n')

    ALU_function_map = {'+': to_binary(0, data_width), 
                        '-': to_binary(1, data_width),
                        '*': to_binary(2, data_width),
                        '/': to_binary(3, data_width),
                        '&': to_binary(4, data_width),
                        '|': to_binary(5, data_width),
                        '~&': to_binary(6, data_width),
                        '~|': to_binary(7, data_width),
                        '^': to_binary(8, data_width),
                        '~^': to_binary(9, data_width),
                        '==': to_binary(10, data_width),
                        '>': to_binary(11, data_width),
                        '<': to_binary(12, data_width),
                        '>>': to_binary(13, data_width),
                        '<<': to_binary(14, data_width)}
    ALU_function = ALU_function_map[ALU_function_symbol]
    
    
    if parity_enable:
        parity_bit = calculate_parity(parity_type, ALU_function)
        ALU_function = bitarray('1' + str(parity_bit) + ALU_function.to01() + '0')
    else:
        ALU_function = bitarray('1' + ALU_function.to01() + '0')
    test_cases_file.write(ALU_function.to01() + '\n')
    
    # split the result into two parts
    test_cases_results_file.write(ALU_result[data_width:].to01() + '\n')
    test_cases_results_file.write(ALU_result[:data_width].to01() + '\n')


def ALU_operation_without_operands(ALU_function_symbol):
    total_test_cases[0] += 1
    test_cases_depth[0] += 2
    results_file_depth[0] += 2

    operand_A_binary = bitarray(register_file_memory[0])
    operand_A_binary = bitarray('0' * data_width) + operand_A_binary
    operand_B_binary = bitarray(register_file_memory[1])
    operand_B_binary = bitarray('0' * data_width) + operand_B_binary
    
    operand_A = int(operand_A_binary.to01(), 2)
    operand_B = int(operand_B_binary.to01(), 2)
    
    if ALU_function_symbol == '+':
        ALU_result = bitarray(to_binary(operand_A + operand_B, data_width * 2))
    elif ALU_function_symbol == '-':
        ALU_result = operand_A - operand_B
        if ALU_result < 0:
            temp = -ALU_result
            temp = ~bitarray(to_binary(temp, data_width * 2))
            temp = int(temp.to01(), 2) + 1
            ALU_result = bitarray(to_binary(temp, data_width * 2))
        else:
            ALU_result = bitarray(to_binary(ALU_result, data_width * 2))
    elif ALU_function_symbol == '*':
        ALU_result = bitarray(to_binary(operand_A * operand_B, data_width * 2))
    elif ALU_function_symbol == '/':
        ALU_result = bitarray(to_binary(int(operand_A / operand_B), data_width * 2))
    elif ALU_function_symbol == '&':
        ALU_result = operand_A_binary & operand_B_binary
    elif ALU_function_symbol == '|':
        ALU_result = operand_A_binary | operand_B_binary
    elif ALU_function_symbol == '~&':
        ALU_result = ~(operand_A_binary & operand_B_binary)
    elif ALU_function_symbol == '~|':
        ALU_result = ~(operand_A_binary | operand_B_binary)
    elif ALU_function_symbol == '^':
        ALU_result = operand_A_binary ^ operand_B_binary
    elif ALU_function_symbol == '~^':
        ALU_result = ~(operand_A_binary ^ operand_B_binary)
    elif ALU_function_symbol == '==':
        ALU_result = 1 if operand_A == operand_B else 0
        ALU_result = bitarray(to_binary(ALU_result, data_width * 2))
    elif ALU_function_symbol == '>':
        ALU_result = 1 if operand_A > operand_B else 0
        ALU_result = bitarray(to_binary(ALU_result, data_width * 2))
    elif ALU_function_symbol == '<':
        ALU_result = 1 if operand_A < operand_B else 0
        ALU_result = bitarray(to_binary(ALU_result, data_width * 2))
    elif ALU_function_symbol == '>>':
        ALU_result = operand_A_binary >> 1
    elif ALU_function_symbol == '<<':
        ALU_result = operand_A_binary << 1
    
    command_op_code = bitarray('11011101')
    if parity_enable:
        parity_bit = calculate_parity(parity_type, command_op_code)
        command_op_code = bitarray('1' + str(parity_bit) + command_op_code.to01() + '0')
    else:
        command_op_code = bitarray('1' + command_op_code.to01() + '0')

    test_cases_file.write(command_op_code.to01() + '\n')


    ALU_function_map = {'+': to_binary(0, data_width), 
                        '-': to_binary(1, data_width),
                        '*': to_binary(2, data_width),
                        '/': to_binary(3, data_width),
                        '&': to_binary(4, data_width),
                        '|': to_binary(5, data_width),
                        '~&': to_binary(6, data_width),
                        '~|': to_binary(7, data_width),
                        '^': to_binary(8, data_width),
                        '~^': to_binary(9, data_width),
                        '==': to_binary(10, data_width),
                        '>': to_binary(11, data_width),
                        '<': to_binary(12, data_width),
                        '>>': to_binary(13, data_width),
                        '<<': to_binary(14, data_width)
                        }
    ALU_function = ALU_function_map[ALU_function_symbol]
       
    if parity_enable:
        parity_bit = calculate_parity(parity_type, ALU_function)
        ALU_function = bitarray('1' + str(parity_bit) + ALU_function.to01() + '0')
    else:
        ALU_function = bitarray('1' + ALU_function.to01() + '0')
    test_cases_file.write(ALU_function.to01() + '\n')
    
    # split the result into two parts
    test_cases_results_file.write(ALU_result[data_width:].to01() + '\n')
    test_cases_results_file.write(ALU_result[:data_width].to01() + '\n')



if __name__ == '__main__':
    write_prescale(prescale)

    test_cases_file = open('test_cases.txt', 'w')
    test_cases_results_file = open('output_files/system_outputs_python.txt', 'w')
    parity_enable, parity_type, data_width, register_file_depth = read_parameters()
    register_file_memory = ['0' * data_width] * register_file_depth

    # initial register file values
    register_file_memory[2] = f'000000{parity_type}{parity_enable}'
    register_file_memory[3] = to_binary(prescale, data_width).to01()

    results_file_depth = [0]
    test_cases_depth = [0]
    test_cases_width = data_width + parity_enable + 2
    total_test_cases = [0]

    main()

    write_test_cases_configuration()
    write_register_file_memory()

    # Return the number of test cases to report them to the user
    print(total_test_cases[0])