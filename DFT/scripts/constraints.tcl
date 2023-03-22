# Modes of operation variable definitions
set test_mode 1
set SE 0

# ------------------------ Clock Domain '1' (REFERENCE_CLK) --------------------
set REFERENCE_CLK_NAME REFERENCE_CLK
set REFERENCE_CLK_PERIOD 25
set REFERENCE_CLK_SETUP_SKEW 0.2
set REFERENCE_CLK_HOLD_SKEW 0.1
set REFERENCE_CLK_RISE 0.1
set REFERENCE_CLK_FALL 0.1
set REFERENCE_CLK_LATENCY 0

# Reference clock constraints
create_clock -name $REFERENCE_CLK_NAME -period $REFERENCE_CLK_PERIOD \
-waveform "[expr $REFERENCE_CLK_PERIOD / 2] $REFERENCE_CLK_PERIOD" [get_ports reference_clk]

set_clock_uncertainty -setup $REFERENCE_CLK_SETUP_SKEW [get_clocks $REFERENCE_CLK_NAME]
set_clock_uncertainty -hold $REFERENCE_CLK_HOLD_SKEW [get_clocks $REFERENCE_CLK_NAME]
set_clock_transition -rise $REFERENCE_CLK_RISE [get_clocks $REFERENCE_CLK_NAME]
set_clock_transition -fall $REFERENCE_CLK_FALL [get_clocks $REFERENCE_CLK_NAME]
set_clock_latency $REFERENCE_CLK_LATENCY [get_clocks $REFERENCE_CLK_NAME]

# ALU clock constraints
if {$SE == 0} {
    set ALU_CLK_NAME ALU_CLK
    create_generated_clock -master_clock $REFERENCE_CLK_NAME -source [get_ports reference_clk] \
    -name $ALU_CLK_NAME -divide_by 1 [get_ports U_clock_gating_cell/gated_clock]

    set_clock_uncertainty -setup $REFERENCE_CLK_SETUP_SKEW [get_clocks $ALU_CLK_NAME]
    set_clock_uncertainty -hold $REFERENCE_CLK_HOLD_SKEW [get_clocks $ALU_CLK_NAME]
    set_clock_transition -rise $REFERENCE_CLK_RISE [get_clocks $ALU_CLK_NAME]
    set_clock_transition -fall $REFERENCE_CLK_FALL [get_clocks $ALU_CLK_NAME]
    set_clock_latency $REFERENCE_CLK_LATENCY [get_clocks $ALU_CLK_NAME]
}
# -------------------------------------------------------------------------------


# --------------------------- Clock Domain '2' (UART_CLK) -----------------------
set UART_TRANSMITTER_CLK_NAME UART_TRANSMITTER_CLK
set UART_CLK_PRESCALE 32

set UART_CLK_NAME UART_CLK
set UART_CLK_PERIOD 271
set UART_CLK_SETUP_SKEW 0.2
set UART_CLK_HOLD_SKEW 0.1
set UART_CLK_RISE 0.1
set UART_CLK_FALL 0.1
set UART_CLK_LATENCY 0

# UART clock constraints
create_clock -name $UART_CLK_NAME -period $UART_CLK_PERIOD \
-waveform "0 [expr $UART_CLK_PERIOD / 2]" [get_ports UART_clk]

set_clock_uncertainty -setup $UART_CLK_SETUP_SKEW [get_clocks $UART_CLK_NAME]
set_clock_uncertainty -hold $UART_CLK_HOLD_SKEW [get_clocks $UART_CLK_NAME]
set_clock_transition -rise $UART_CLK_RISE [get_clocks $UART_CLK_NAME]
set_clock_transition -fall $UART_CLK_FALL [get_clocks $UART_CLK_NAME]
set_clock_latency $UART_CLK_LATENCY [get_clocks $UART_CLK_NAME]

# UART transmitter clock constraints
create_generated_clock -master_clock $UART_CLK_NAME \
-source [get_ports UART_clk] -name $UART_TRANSMITTER_CLK_NAME \
-divide_by $UART_CLK_PRESCALE [get_ports U_clock_divider/output_clk]

set_clock_uncertainty -setup $UART_CLK_SETUP_SKEW [get_clocks $UART_TRANSMITTER_CLK_NAME]
set_clock_uncertainty -hold $UART_CLK_HOLD_SKEW [get_clocks $UART_TRANSMITTER_CLK_NAME]
set_clock_transition -rise $UART_CLK_RISE [get_clocks $UART_TRANSMITTER_CLK_NAME]
set_clock_transition -fall $UART_CLK_FALL [get_clocks $UART_TRANSMITTER_CLK_NAME]
set_clock_latency $UART_CLK_LATENCY [get_clocks $UART_TRANSMITTER_CLK_NAME]


# Input ports' constraints, Input delay is used in STA
# All the inputs are inputs to the UART receiver
set UART_clk_input_delay [expr 0.2 * $UART_CLK_PERIOD]
set_input_delay $UART_clk_input_delay -clock $UART_CLK_NAME [get_port serial_data_in]


# Output ports' constraints, output delay is used in STA
set UART_transmitter_clk_output_delay [expr 0.2 * $UART_CLK_PRESCALE * $UART_CLK_PERIOD]
set_output_delay $UART_transmitter_clk_output_delay -clock $UART_TRANSMITTER_CLK_NAME [get_port serial_data_out]

set UART_clk_output_delay [expr 0.2 * $UART_CLK_PERIOD]
set_output_delay $UART_clk_output_delay -clock $UART_CLK_NAME [get_port parity_error]
set_output_delay $UART_clk_output_delay -clock $UART_CLK_NAME [get_port frame_error]
# ------------------------------------------------------------------------------

# ------------------------ Clock Domain '3' (SCAN_CLK) --------------------
set SCAN_CLK_NAME SCAN_CLK
set SCAN_CLK_PERIOD 100
set SCAN_CLK_SETUP_SKEW 0.2
set SCAN_CLK_HOLD_SKEW 0.1
set SCAN_CLK_RISE 0.1
set SCAN_CLK_FALL 0.1
set SCAN_CLK_LATENCY 0

# Scan clock constraints
create_clock -name $SCAN_CLK_NAME -period $SCAN_CLK_PERIOD \
-waveform "[expr $SCAN_CLK_PERIOD / 2] $SCAN_CLK_PERIOD" [get_ports scan_clk]

set_clock_uncertainty -setup $SCAN_CLK_SETUP_SKEW [get_clocks $SCAN_CLK_NAME]
set_clock_uncertainty -hold $SCAN_CLK_HOLD_SKEW [get_clocks $SCAN_CLK_NAME]
set_clock_transition -rise $SCAN_CLK_RISE [get_clocks $SCAN_CLK_NAME]
set_clock_transition -fall $SCAN_CLK_FALL [get_clocks $SCAN_CLK_NAME]
set_clock_latency $SCAN_CLK_LATENCY [get_clocks $SCAN_CLK_NAME]

if {$SE == 1} {
    set ALU_CLK_NAME ALU_CLK
    create_generated_clock -master_clock $SCAN_CLK_NAME -source [get_ports scan_clk] \
    -name $ALU_CLK_NAME -divide_by 1 [get_ports U_clock_gating_cell/gated_clock]

    set_clock_uncertainty -setup $SCAN_CLK_SETUP_SKEW [get_clocks $ALU_CLK_NAME]
    set_clock_uncertainty -hold $SCAN_CLK_HOLD_SKEW [get_clocks $ALU_CLK_NAME]
    set_clock_transition -rise $SCAN_CLK_RISE [get_clocks $ALU_CLK_NAME]
    set_clock_transition -fall $SCAN_CLK_FALL [get_clocks $ALU_CLK_NAME]
    set_clock_latency $SCAN_CLK_LATENCY [get_clocks $ALU_CLK_NAME]
}

# -------------------------------------------------------------------------------

# Define asynchronous clocks
set_clock_groups -asynchronous \
-group [get_clocks "$REFERENCE_CLK_NAME $ALU_CLK_NAME"] \
-group [get_clocks "$UART_CLK_NAME $UART_TRANSMITTER_CLK_NAME"] \
-group [get_clocks "$SCAN_CLK_NAME"]


# Input ports driving cells, The set_driving_cell is used to estimate the input transition time which is used in calculating the output transition time and propagation delay of the gate connected to the input port
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port serial_data_in]

# Output load
set_load 0.5 [get_port serial_data_out]
set_load 0.5 [get_port parity_error]
set_load 0.5 [get_port frame_error]

# Don't touch network (to prevent the tool from buffering the signals)
set_dont_touch_network {reference_clk U_clock_gating_cell/gated_clock UART_clk U_clock_divider/output_clk scan_clk}

# Operating conditons
set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"

# Wire load model
# set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c

# Minimize the area as much as possible
set_max_area 0

# Prevent assign statements in the generated netlist
set_fix_multiple_port_nets -all -buffer_constants -feedthroughs
