set total_test_cases [exec python test_cases_generator.py]

exec cmd.exe /c "vlib work"
exec cmd.exe /c "vlog system_top_tb.v > system_top_tb.log"
exec {*}[auto_execok start] vmap -c
exec {*}[auto_execok start] vsim -c work.system_top_tb -do "run -all; mem save -o register_file_verilog.mem -f binary -wordsperline 1 /system_top_tb/U_system_top/U_register_file/memory; quit -f"


set output [exec python evaluate.py $total_test_cases]
puts $output

exec python clean.py

# exec {*}[auto_execok start] vsim  work.system_top_tb -do "add wave -position insertpoint  \
#     sim:/system_top_tb/reference_clk_tb \
#     sim:/system_top_tb/UART_clk_tb \
#     sim:/system_top_tb/U_system_top/UART_transmitter_clk \
#     sim:/system_top_tb/serial_data_in_tb \
#     sim:/system_top_tb/U_system_top/U_register_file/write_enable \
#     sim:/system_top_tb/U_system_top/U_register_file/read_data_valid \
#     sim:/system_top_tb/U_system_top/U_ALU/enable \
#     sim:/system_top_tb/U_system_top/U_system_controller/U_UART_receiver_controller/ALU_clk_enable \
#     sim:/system_top_tb/U_system_top/U_UART/U_UART_receiver/data_valid \
#     sim:/system_top_tb/U_system_top/U_system_controller/U_UART_receiver_controller/current_state \
#     sim:/system_top_tb/U_system_top/U_UART/U_UART_receiver/U_UART_receiver_FSM/current_state \
#     sim:/system_top_tb/U_system_top/U_UART/U_UART_receiver/parallel_data \
#     sim:/system_top_tb/U_system_top/U_system_controller/receiver_parallel_data_valid_synchronized \
#     sim:/system_top_tb/U_system_top/U_system_controller/receiver_parallel_data_synchronized \
#     sim:/system_top_tb/U_system_top/U_system_controller/U_UART_transmitter_controller/transmitter_parallel_data_valid \
#     sim:/system_top_tb/U_system_top/U_system_controller/U_UART_transmitter_controller/transmitter_parallel_data \
#     sim:/system_top_tb/U_system_top/U_system_controller/U_UART_transmitter_controller/transmitter_Q_pulse_generator \
#     sim:/system_top_tb/U_system_top/U_system_controller/U_UART_transmitter_controller/current_state \
#     sim:/system_top_tb/U_system_top/U_UART/U_UART_transmitter/U_UART_transmitter_FSM/current_state \
#     sim:/system_top_tb/U_system_top/U_UART/U_UART_transmitter/data_valid \
#     sim:/system_top_tb/U_system_top/U_system_controller/U_UART_receiver_controller/enable \
#     sim:/system_top_tb/U_system_top/U_UART/U_UART_transmitter/parallel_data \
#     sim:/system_top_tb/UART_transmitter_busy_tb \
#     sim:/system_top_tb/serial_data_out_tb; run -all; mem save -o functional_verification/register_file_verilog.mem -f binary -wordsperline 1 /system_top_tb/U_system_top/U_register_file/memory"