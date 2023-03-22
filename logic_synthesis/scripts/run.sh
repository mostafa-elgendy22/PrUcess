# This script runs the synthesis flow
#!/bin/bash
dc_shell -f logic_synthesis_script.tcl | tee "../logic_synthesis_output/logic_synthesis.log"

# Clean the directory from temporary files
rm -f command.log
rm -f filenames.log
rm -f default.svf
rm -f -r alib-52
rm -f filenames*
rm -f *~