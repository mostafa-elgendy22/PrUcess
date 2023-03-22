vsim -gui work.UART_receiver_controller

add wave -position insertpoint  \
sim:/UART_receiver_controller/clk \
sim:/UART_receiver_controller/reset \
sim:/UART_receiver_controller/counter \
sim:/UART_receiver_controller/enable_write_address_register \
sim:/UART_receiver_controller/Q_write_address_register \
sim:/UART_receiver_controller/parallel_data_valid_synchronized \
sim:/UART_receiver_controller/parallel_data_synchronized \
sim:/UART_receiver_controller/ALU_function \
sim:/UART_receiver_controller/ALU_enable \
sim:/UART_receiver_controller/ALU_clk_enable \
sim:/UART_receiver_controller/address \
sim:/UART_receiver_controller/write_enable \
sim:/UART_receiver_controller/write_data \
sim:/UART_receiver_controller/read_enable \
sim:/UART_receiver_controller/current_state


force -freeze sim:/UART_receiver_controller/clk 0 0, 1 {10 ps} -r 20 ps
force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
force -freeze sim:/UART_receiver_controller/reset 0 0
run {40 ps}

force -freeze sim:/UART_receiver_controller/reset 1 0
run {1010 ps}


force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 1 0
force -freeze sim:/UART_receiver_controller/parallel_data_synchronized 1010_1010 0
run {20 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
run {1000 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 1 0
force -freeze sim:/UART_receiver_controller/parallel_data_synchronized 0000_0110 0
run {20 ps}


force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
run {1000 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 1 0
force -freeze sim:/UART_receiver_controller/parallel_data_synchronized 1100_1111 0
run {20 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
run {100 ps}

################################################################################

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 1 0
force -freeze sim:/UART_receiver_controller/parallel_data_synchronized 1011_1011 0
run {20 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
run {1000 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 1 0
force -freeze sim:/UART_receiver_controller/parallel_data_synchronized 0000_0111 0
run {20 ps}


force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
run {1000 ps}

################################################################################

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 1 0
force -freeze sim:/UART_receiver_controller/parallel_data_synchronized 1100_1100 0
run {20 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
run {1000 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 1 0
force -freeze sim:/UART_receiver_controller/parallel_data_synchronized 0000_0111 0
run {20 ps}


force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
run {1000 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 1 0
force -freeze sim:/UART_receiver_controller/parallel_data_synchronized 0000_1001 0
run {20 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
run {1000 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 1 0
force -freeze sim:/UART_receiver_controller/parallel_data_synchronized 0000_0001 0
run {20 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
run {1000 ps}

################################################################################

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 1 0
force -freeze sim:/UART_receiver_controller/parallel_data_synchronized 1100_1100 0
run {20 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
run {1000 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 1 0
force -freeze sim:/UART_receiver_controller/parallel_data_synchronized 0000_0111 0
run {20 ps}


force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
run {1000 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 1 0
force -freeze sim:/UART_receiver_controller/parallel_data_synchronized 0000_1001 0
run {20 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
run {1000 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 1 0
force -freeze sim:/UART_receiver_controller/parallel_data_synchronized 0000_0101 0
run {20 ps}

force -freeze sim:/UART_receiver_controller/parallel_data_valid_synchronized 0 0
run {1000 ps}