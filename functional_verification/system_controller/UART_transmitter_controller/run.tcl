exec cmd.exe /c "vlib work"
exec cmd.exe /c "vlog UART_transmitter_controller_tb.v"
exec {*}[auto_execok start] vmap -c

if {$argc == 0} {
    # Run the testbench
    exec {*}[auto_execok start] vsim -c work.UART_transmitter_controller_tb -do "run -all; quit -f"

    # Read the output file to report the test cases
    set output_file_handle [open "output.txt" r]
    set file_contents [read $output_file_handle]
    close $output_file_handle
    puts $file_contents

} elseif {$argc == 1 && [lindex $argv 0] == "-w"} {
    # Open the waveform
    exec {*}[auto_execok start] vsim work.UART_transmitter_controller -do "do UART_transmitter_controller.do"

} else {
    puts "Invalid program arguments..."
}



exec cmd.exe /c "del output.txt > nul 2>&1"
exec cmd.exe /c "del transcript > nul 2>&1"
exec cmd.exe /c "del modelsim.ini > nul 2>&1"
exec cmd.exe /c "del vsim.wlf > nul 2>&1"
exec cmd.exe /c "del vsim_stacktrace.vstf > nul 2>&1"
exec cmd.exe /c "del wlft3ghn8c > nul 2>&1"
exec cmd.exe /c "del *.vstf > nul 2>&1"
exec cmd.exe /c "rmdir /s /q work > nul 2>&1"