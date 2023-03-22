# This script runs the synthesis flow
#!/bin/bash
dc_shell -f DFT_script.tcl | tee "../DFT_output/DFT.log"

# Clean the directory from temporary files
rm -f command.log
rm -f filenames.log
rm -f default.svf
rm -f *~