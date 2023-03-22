###################################################################

# Created by write_sdc on Wed Mar 22 21:12:39 2023

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -max_library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -min scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c -min_library scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c
set_max_area 0
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports serial_data_in]
set_load -pin_load 0.5 [get_ports serial_data_out]
set_load -pin_load 0.5 [get_ports parity_error]
set_load -pin_load 0.5 [get_ports frame_error]
create_clock [get_ports reference_clk]  -name REFERENCE_CLK  -period 25  -waveform {12 25}
set_clock_latency 0  [get_clocks REFERENCE_CLK]
set_clock_uncertainty -setup 0.2  [get_clocks REFERENCE_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks REFERENCE_CLK]
set_clock_transition -max -rise 0.1 [get_clocks REFERENCE_CLK]
set_clock_transition -min -rise 0.1 [get_clocks REFERENCE_CLK]
set_clock_transition -max -fall 0.1 [get_clocks REFERENCE_CLK]
set_clock_transition -min -fall 0.1 [get_clocks REFERENCE_CLK]
create_generated_clock [get_pins U_clock_gating_cell/gated_clock]  -name ALU_CLK  -source [get_ports reference_clk]  -master_clock REFERENCE_CLK  -divide_by 1  -add
set_clock_latency 0  [get_clocks ALU_CLK]
set_clock_uncertainty -setup 0.2  [get_clocks ALU_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks ALU_CLK]
set_clock_transition -max -rise 0.1 [get_clocks ALU_CLK]
set_clock_transition -min -rise 0.1 [get_clocks ALU_CLK]
set_clock_transition -max -fall 0.1 [get_clocks ALU_CLK]
set_clock_transition -min -fall 0.1 [get_clocks ALU_CLK]
create_clock [get_ports UART_clk]  -name UART_CLK  -period 271  -waveform {0 135}
set_clock_latency 0  [get_clocks UART_CLK]
set_clock_uncertainty -setup 0.2  [get_clocks UART_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks UART_CLK]
set_clock_transition -max -rise 0.1 [get_clocks UART_CLK]
set_clock_transition -min -rise 0.1 [get_clocks UART_CLK]
set_clock_transition -max -fall 0.1 [get_clocks UART_CLK]
set_clock_transition -min -fall 0.1 [get_clocks UART_CLK]
create_generated_clock [get_pins U_clock_divider/output_clk]  -name UART_TRANSMITTER_CLK  -source [get_ports UART_clk]  -master_clock UART_CLK  -divide_by 32  -add
set_clock_latency 0  [get_clocks UART_TRANSMITTER_CLK]
set_clock_uncertainty -setup 0.2  [get_clocks UART_TRANSMITTER_CLK]
set_clock_uncertainty -hold 0.1  [get_clocks UART_TRANSMITTER_CLK]
set_clock_transition -max -rise 0.1 [get_clocks UART_TRANSMITTER_CLK]
set_clock_transition -min -rise 0.1 [get_clocks UART_TRANSMITTER_CLK]
set_clock_transition -max -fall 0.1 [get_clocks UART_TRANSMITTER_CLK]
set_clock_transition -min -fall 0.1 [get_clocks UART_TRANSMITTER_CLK]
set_input_delay -clock UART_CLK  54.2  [get_ports serial_data_in]
set_output_delay -clock UART_TRANSMITTER_CLK  1734.4  [get_ports serial_data_out]
set_output_delay -clock UART_CLK  54.2  [get_ports parity_error]
set_output_delay -clock UART_CLK  54.2  [get_ports frame_error]
set_clock_groups -asynchronous -name REFERENCE_CLK_1 -group [list [get_clocks REFERENCE_CLK] [get_clocks ALU_CLK]] -group [list [get_clocks UART_CLK] [get_clocks UART_TRANSMITTER_CLK]]
