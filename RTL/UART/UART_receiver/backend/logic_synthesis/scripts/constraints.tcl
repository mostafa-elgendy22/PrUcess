# Clock constraints
set CLK_NAME CLK
set CLK_PERIOD 100
set CLK_SETUP_SKEW 0.25
set CLK_HOLD_SKEW 0.05
set CLK_RISE 0.1
set CLK_FALL 0.1

create_clock -name $CLK_NAME -period $CLK_PERIOD -waveform "0 [expr $CLK_PERIOD/2]" [get_ports clk]

set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks $CLK_NAME]
set_clock_uncertainty -hold $CLK_HOLD_SKEW [get_clocks $CLK_NAME]

set_clock_transition -rise $CLK_RISE [get_clocks $CLK_NAME]
set_clock_transition -fall $CLK_FALL [get_clocks $CLK_NAME]


# Input ports' constraints
set input_delay [expr 0.2 * $CLK_PERIOD]

set_input_delay $input_delay -clock $CLK_NAME [get_port parity_type]
set_input_delay $input_delay -clock $CLK_NAME [get_port parity_enable]
set_input_delay $input_delay -clock $CLK_NAME [get_port prescale]
set_input_delay $input_delay -clock $CLK_NAME [get_port serial_data]


# Output ports' constraints
set output_delay [expr 0.2 * $CLK_PERIOD]

set_output_delay $output_delay -clock $CLK_NAME [get_port parallel_data]
set_output_delay $output_delay -clock $CLK_NAME [get_port data_valid]
set_output_delay $output_delay -clock $CLK_NAME [get_port parity_error]
set_output_delay $output_delay -clock $CLK_NAME [get_port frame_error]


# Input ports driving cells
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port parity_type]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port parity_enable]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port prescale]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port serial_data]


# Output load
set_load 2 [get_port parallel_data]
set_load 2 [get_port data_valid]
set_load 2 [get_port parity_error]
set_load 2 [get_port frame_error]