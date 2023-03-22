###################################################################

# Created by write_sdc on Fri Mar 10 02:32:44 2023

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -max_library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -min scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c -min_library scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c
set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports parity_type]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports parity_enable]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {prescale[5]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {prescale[4]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {prescale[3]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {prescale[2]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {prescale[1]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports {prescale[0]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -pin Y [get_ports serial_data]
set_load -pin_load 2 [get_ports {parallel_data[7]}]
set_load -pin_load 2 [get_ports {parallel_data[6]}]
set_load -pin_load 2 [get_ports {parallel_data[5]}]
set_load -pin_load 2 [get_ports {parallel_data[4]}]
set_load -pin_load 2 [get_ports {parallel_data[3]}]
set_load -pin_load 2 [get_ports {parallel_data[2]}]
set_load -pin_load 2 [get_ports {parallel_data[1]}]
set_load -pin_load 2 [get_ports {parallel_data[0]}]
set_load -pin_load 2 [get_ports data_valid]
set_load -pin_load 2 [get_ports parity_error]
set_load -pin_load 2 [get_ports frame_error]
create_clock [get_ports clk]  -name CLK  -period 100  -waveform {0 50}
set_clock_uncertainty -setup 0.25  [get_clocks CLK]
set_clock_uncertainty -hold 0.05  [get_clocks CLK]
set_clock_transition -min -fall 0.1 [get_clocks CLK]
set_clock_transition -max -fall 0.1 [get_clocks CLK]
set_clock_transition -min -rise 0.1 [get_clocks CLK]
set_clock_transition -max -rise 0.1 [get_clocks CLK]
set_input_delay -clock CLK  20  [get_ports parity_type]
set_input_delay -clock CLK  20  [get_ports parity_enable]
set_input_delay -clock CLK  20  [get_ports {prescale[5]}]
set_input_delay -clock CLK  20  [get_ports {prescale[4]}]
set_input_delay -clock CLK  20  [get_ports {prescale[3]}]
set_input_delay -clock CLK  20  [get_ports {prescale[2]}]
set_input_delay -clock CLK  20  [get_ports {prescale[1]}]
set_input_delay -clock CLK  20  [get_ports {prescale[0]}]
set_input_delay -clock CLK  20  [get_ports serial_data]
set_output_delay -clock CLK  20  [get_ports {parallel_data[7]}]
set_output_delay -clock CLK  20  [get_ports {parallel_data[6]}]
set_output_delay -clock CLK  20  [get_ports {parallel_data[5]}]
set_output_delay -clock CLK  20  [get_ports {parallel_data[4]}]
set_output_delay -clock CLK  20  [get_ports {parallel_data[3]}]
set_output_delay -clock CLK  20  [get_ports {parallel_data[2]}]
set_output_delay -clock CLK  20  [get_ports {parallel_data[1]}]
set_output_delay -clock CLK  20  [get_ports {parallel_data[0]}]
set_output_delay -clock CLK  20  [get_ports data_valid]
set_output_delay -clock CLK  20  [get_ports parity_error]
set_output_delay -clock CLK  20  [get_ports frame_error]
