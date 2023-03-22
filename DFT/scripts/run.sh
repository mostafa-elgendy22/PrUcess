# This script runs the DFT flow in the different modes of operation
#!/bin/bash

# Funtion mode
python change_mode.py 0 0
dc_shell -f DFT_script.tcl | tee "../DFT_output/logs/DFT_function_mode.log"

# Test scan mode
python change_mode.py 1 1
dc_shell -f DFT_script.tcl | tee "../DFT_output/logs/DFT_test_scan_mode.log"

# Test capture mode
python change_mode.py 1 0
dc_shell -f DFT_script.tcl | tee "../DFT_output/logs/DFT_test_capture.log"

# Clean the directory from temporary files
rm -f command.log
rm -f filenames.log
rm -f default.svf
rm -f -r alib-52
rm -f filenames*
rm -f *~