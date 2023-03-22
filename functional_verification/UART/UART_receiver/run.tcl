exec cmd.exe /c "vlib work"
exec cmd.exe /c "vlog UART_receiver_tb.v"
exec {*}[auto_execok start] vmap -c

if {$argc == 0} {
    # Run the testbench
    exec {*}[auto_execok start] vsim -c work.UART_receiver_tb -do "run -all; quit -f"

    # Read the output file to report the testcases
    set output_file_handle [open "output.txt" r]
    set file_contents [read $output_file_handle]
    close $output_file_handle
    puts $file_contents

} elseif {$argc == 1 && [lindex $argv 0] == "-w"} {
    # Open the waveform
    # exec {*}[auto_execok start] vsim work.UART_receiver -do "do UART_receiver.do"
    exec {*}[auto_execok start] vsim work.UART_receiver_tb -do "add wave -position insertpoint  \
    sim:/UART_receiver_tb/U_UART_receiver/clk \
    sim:/UART_receiver_tb/U_UART_receiver/reset \
    sim:/UART_receiver_tb/U_UART_receiver/parity_type \
    sim:/UART_receiver_tb/U_UART_receiver/parity_enable \
    sim:/UART_receiver_tb/U_UART_receiver/prescale \
    sim:/UART_receiver_tb/U_UART_receiver/serial_data \
    sim:/UART_receiver_tb/U_UART_receiver/U_UART_receiver_FSM/current_state \
    sim:/UART_receiver_tb/U_UART_receiver/U_UART_receiver_FSM/edge_count_done \
    sim:/UART_receiver_tb/U_UART_receiver/U_UART_receiver_FSM/deserializer_enable \
    sim:/UART_receiver_tb/U_UART_receiver/U_UART_receiver_FSM/edge_counter_and_data_sampler_enable \
    sim:/UART_receiver_tb/U_UART_receiver/U_data_sampler/samples \
    sim:/UART_receiver_tb/U_UART_receiver/U_data_sampler/sampled_bit \
    sim:/UART_receiver_tb/U_UART_receiver/data_valid \
    sim:/UART_receiver_tb/U_UART_receiver/parallel_data \
    sim:/UART_receiver_tb/U_UART_receiver/parity_error \
    sim:/UART_receiver_tb/U_UART_receiver/frame_error; run -all;"

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