vsim -gui work.UART_receiver

add wave -position insertpoint  \
sim:/UART_receiver/clk \
sim:/UART_receiver/reset \
sim:/UART_receiver/parity_type \
sim:/UART_receiver/parity_enable \
sim:/UART_receiver/prescale \
sim:/UART_receiver/serial_data \
sim:/UART_receiver/U_UART_receiver_FSM/current_state \
sim:/UART_receiver/U_UART_receiver_FSM/data_transmission_state \
sim:/UART_receiver/U_UART_receiver_FSM/edge_count_done \
sim:/UART_receiver/U_UART_receiver_FSM/deserializer_enable \
sim:/UART_receiver/U_UART_receiver_FSM/edge_counter_and_data_sampler_enable \
sim:/UART_receiver/U_data_sampler/samples \
sim:/UART_receiver/U_data_sampler/sampled_bit \
sim:/UART_receiver/parallel_data \
sim:/UART_receiver/data_valid


force -freeze sim:/UART_receiver/clk 0 0, 1 {100 ps} -r 200
force -freeze sim:/UART_receiver/reset 0 0
force -freeze sim:/UART_receiver/parity_type 0 0
force -freeze sim:/UART_receiver/parity_enable 0 0
force -freeze sim:/UART_receiver/prescale 00_1000 0
force -freeze sim:/UART_receiver/serial_data 0 0
run {200 ps}



force -freeze sim:/UART_receiver/reset 1 0
force -freeze sim:/UART_receiver/parity_type 1 0
force -freeze sim:/UART_receiver/parity_enable 1 0
force -freeze sim:/UART_receiver/serial_data 1 0
run {200 ps}



force -freeze sim:/UART_receiver/serial_data 0 0
run {1600 ps}

# 0101 0101

force -freeze sim:/UART_receiver/serial_data 1 0
run {1600 ps}

force -freeze sim:/UART_receiver/serial_data 0 0
run {1600 ps}

force -freeze sim:/UART_receiver/serial_data 1 0
run {1600 ps}

force -freeze sim:/UART_receiver/serial_data 0 0
run {1600 ps}

force -freeze sim:/UART_receiver/serial_data 1 0
run {1600 ps}

force -freeze sim:/UART_receiver/serial_data 0 0
run {1600 ps}

force -freeze sim:/UART_receiver/serial_data 1 0
run {1600 ps}

force -freeze sim:/UART_receiver/serial_data 0 0
run {1600 ps}

force -freeze sim:/UART_receiver/serial_data 1 0
run {1600 ps}

force -freeze sim:/UART_receiver/serial_data 1 0
run {6000 ps}