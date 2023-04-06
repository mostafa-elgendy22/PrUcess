import re

def write_prescale(prescale):
    tb_file = open('system_top_tb.v', 'r')
    code = tb_file.read()
    tb_file.close()
    prescale_pattern = r'^\s*localparam\s+PRESCALE\s*=\s*\d+\s*;\s*$'
    code = re.sub(prescale_pattern, '\n\tlocalparam PRESCALE = ' + str(prescale) + ';\n', code, flags=re.MULTILINE)
    
    tb_file = open('system_top_tb.v', 'w')
    tb_file.write(code)
    tb_file.close()

    if prescale == 8:
        prescale = '00_001000'
    elif prescale == 16:
        prescale = '00_010000'
    elif prescale == 32:
        prescale = '00_100000'

    prescale_configuration_pattern = r'^\s*memory\[i\]\s*<=\s*\'b00_[01]{6}\s*;\s*$'
    register_file = open('../../RTL/register_file/register_file.v', 'r')
    code = register_file.read()
    register_file.close()
    code = re.sub(prescale_configuration_pattern, '\t\t\t\t\tmemory[i] <= \'b' + prescale + ';', code, flags=re.MULTILINE)

    register_file = open('../../RTL/register_file/register_file.v', 'w')
    register_file.write(code)

    register_file.close()

if __name__ == '__main__':
    write_prescale(8)