vsim -gui work.UART_transmitter

add wave -position insertpoint  \
sim:/UART_transmitter/clk \
sim:/UART_transmitter/reset \
sim:/UART_transmitter/parity_type \
sim:/UART_transmitter/parity_enable \
sim:/UART_transmitter/data_valid \
sim:/UART_transmitter/parallel_data \
sim:/UART_transmitter/U_UART_transmitter_FSM/current_state \
sim:/UART_transmitter/serial_enable \
sim:/UART_transmitter/serial_data_index \
sim:/UART_transmitter/bit_select \
sim:/UART_transmitter/TX_out \
sim:/UART_transmitter/busy


force -freeze sim:/UART_transmitter/clk 0 0, 1 {100 ps} -r 200
force -freeze sim:/UART_transmitter/reset 0 0
force -freeze sim:/UART_transmitter/parity_type 0 0
force -freeze sim:/UART_transmitter/parity_enable 0 0
force -freeze sim:/UART_transmitter/data_valid 0 0
force -freeze sim:/UART_transmitter/parallel_data 00000000 0
run {200 ps}

force -freeze sim:/UART_transmitter/reset 1 0
force -freeze sim:/UART_transmitter/parity_type 0 0
force -freeze sim:/UART_transmitter/parity_enable 1 0
force -freeze sim:/UART_transmitter/data_valid 1 0
force -freeze sim:/UART_transmitter/parallel_data 01010101 0
run {200 ps}

force -freeze sim:/UART_transmitter/data_valid 0 0
run {3000 ps}