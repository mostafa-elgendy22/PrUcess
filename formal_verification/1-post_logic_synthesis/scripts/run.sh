# This script runs the formal verification flow
#!/bin/bash
fm_shell -f formal_verification_script.tcl | tee "../formal_verification_output/formal_verification.log"
mv formality.log ../formal_verification_output


# Clean the directory from temporary files
rm -f fm_shell_command.lck
rm -f fm_shell_command.log
rm -f formality*.lck
rm -r -f formality_svf*
rm -f *~
rm -r -f FM_WORK*