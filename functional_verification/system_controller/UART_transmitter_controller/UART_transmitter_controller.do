vsim -gui work.UART_transmitter_controller

add wave -position insertpoint  \
sim:/UART_transmitter_controller/clk \
sim:/UART_transmitter_controller/reset \
sim:/UART_transmitter_controller/ALU_result_valid \
sim:/UART_transmitter_controller/ALU_result \
sim:/UART_transmitter_controller/read_data_valid \
sim:/UART_transmitter_controller/read_data \
sim:/UART_transmitter_controller/transmitter_busy_synchronized \
sim:/UART_transmitter_controller/transmitter_parallel_data_valid \
sim:/UART_transmitter_controller/transmitter_parallel_data \
sim:/UART_transmitter_controller/current_state \
sim:/UART_transmitter_controller/transmission_next_state \
sim:/UART_transmitter_controller/transmission_current_state


force -freeze sim:/UART_transmitter_controller/clk 0 0, 1 {10 ps} -r 20 ps
force -freeze sim:/UART_transmitter_controller/reset 0 0
run {20 ps}

force -freeze sim:/UART_transmitter_controller/reset 1 0
force -freeze sim:/UART_transmitter_controller/ALU_result_valid 1 0
force -freeze sim:/UART_transmitter_controller/ALU_result 1110_0111_1010_0110 0
force -freeze sim:/UART_transmitter_controller/transmitter_busy_synchronized 0 0
run {1000 ps}


force -freeze sim:/UART_transmitter_controller/transmitter_busy_synchronized 1 0
run {1000 ps}

force -freeze sim:/UART_transmitter_controller/transmitter_busy_synchronized 0 0
run {1000 ps}

force -freeze sim:/UART_transmitter_controller/transmitter_busy_synchronized 1 0
run {1000 ps}