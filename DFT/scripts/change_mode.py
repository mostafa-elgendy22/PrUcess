# This script switches some variables in DFT_script.tcl, constraints.tcl to switch between the different modes
# of operation which are:
# 1. Function mode: test_mode = 0, SE = 0
# 2. Test scan mode: test_mode = 1, SE = 1
# 3. Test capture mode: test_mode = 1, SE = 0

import re
import sys

test_mode_pattern = r'\s*set test_mode [01]\s*'
SE_pattern = r'\s*set SE [01]\s*'

test_mode = sys.argv[1]
SE = sys.argv[2]

def edit_script(script_name):
    script = open(script_name, 'r')
    lines = script.read()
    script.close()

    lines = re.sub(test_mode_pattern, '\nset test_mode ' + test_mode + '\n', lines)
    lines = re.sub(SE_pattern, '\nset SE ' + SE + '\n\n', lines)

    script = open(script_name, 'w')
    script.write(lines)
    script.close()

edit_script('DFT_script.tcl')
edit_script('constraints.tcl')