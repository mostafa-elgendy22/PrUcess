# Modes of operation variable definitions
set test_mode 1
set SE 0

# Create the setup file in function mode only because that is the mode that is verified in formal verification
if {$test_mode == 0 && $SE == 0} {
    # Formal verification setup file
    set_svf "../DFT_output/system_top.svf"
}

# Place the ICG cell
cd "../../RTL/clock_gating_cell"
exec tclsh place_ICG_cell.tcl -p
cd "../../DFT/scripts"

# Add the path of the std cells and the RTL files to the search path variable
lappend search_path "../../lib/std_cells"
lappend search_path "../../RTL/system_top_DFT" "../../RTL/UART/UART_transmitter" \
                    "../../RTL/UART/UART_receiver" "../../RTL/UART/UART" \
                    "../../RTL/ALU" "../../RTL/bus_synchronizer" \
                    "../../RTL/clock_divider" "../../RTL/clock_gating_cell" \
                    "../../RTL/data_synchronizer" "../../RTL/register_file" \
                    "../../RTL/reset_synchronizer" "../../RTL/system_controller"

# Standard cells' libraries
set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

# Target library is the list of technology libraries of components to be used when compiling a design 
set target_library [list $SSLIB]

# Link library is the list of design files and libraries used during linking
set link_library [list * $SSLIB $FFLIB]  


# Read RTL design files
set file_format verilog

read_file -format $file_format "system_top_DFT.v"

# Set top module
current_design system_top

# Link the top module with its submodules
link 

# Constraints
source -echo ./constraints.tcl

# Choose the mode of the operation of the system
set_case_analysis $test_mode [get_port test_mode]
set_case_analysis $SE [get_port SE]

# Check the design consistency
check_design

# Specify the scan chain design
set_scan_configuration -clock_mixing no_mix -style multiplexed_flip_flop -replace true -max_length 100  

set_app_var compile_seqmap_identify_shift_registers_with_synchronous_logic true
set_app_var compile_seqmap_identify_shift_registers_with_synchronous_logic_ascii true
set_app_var compile_seqmap_identify_shift_registers true
set_scan_state test_ready


# Mapping, optimization, STA, and replacement of FFs with scan FFs
compile_ultra -no_autoungroup -scan

# Preclock Measure Protocol (default protocol)
set test_default_period 100
set test_default_delay 0
set test_default_bidir_delay 0
set test_default_strobe 20
set test_default_strobe_width 0


# Define DFT ports
set_dft_signal -port [get_ports scan_clk]   -type ScanClock   -view existing_dft  -timing {50 100}
set_dft_signal -port [get_ports scan_reset] -type Reset       -view existing_dft  -active_state 0
set_dft_signal -port [get_ports test_mode]  -type Constant    -view existing_dft  -active_state 1 
set_dft_signal -port [get_ports test_mode]  -type TestMode    -view spec          -active_state 1 
set_dft_signal -port [get_ports SE]         -type ScanEnable  -view spec          -active_state 1   -usage scan
set_dft_signal -port [get_ports SI]         -type ScanDataIn  -view spec
set_dft_signal -port [get_ports SO]         -type ScanDataOut -view spec


# Enable enahnced dft_drc reporting
set test_disable_enhanced_dft_drc_reporting false

# Create the test protocol based on specifications using set_dft_signal to check whether
# user specified values are consistent with each other
create_test_protocol


# Report the violations (i.e flops that can't be included in the scan chain)
dft_drc -verbose

# Report the scan chain architecture to be built instead of building it
preview_dft -show all

# Build the scan chains
insert_dft

# Make a second optimization phase after building the scan chains
compile_ultra -no_autoungroup -scan -incremental

# Show the test coverage statistics of the design after DFT insertion
dft_drc -coverage_estimate


if {$test_mode == 0 && $SE == 0} {
    # Generate synthesis reports
    report_power -hierarchy > "../DFT_output/reports/power.rpt"
    report_area -hierarchy > "../DFT_output/reports/area.rpt"
    report_constraint -all_violators > "../DFT_output/reports/constraints.rpt"
    report_port > "../DFT_output/reports/ports.rpt"
    
    # Generate Verilog gate level netlist
    write_file -format verilog -hierarchy -output "../DFT_output/netlist/system_top_netlist.v"
    # Generate DDC gate level netlist
    write_file -format ddc -hierarchy -output "../DFT_output/netlist/system_top_netlist.ddc"
    
    # Generate SDF (Standard Delay Format) file
    write_sdf "../DFT_output/system_top.sdf"
    
    # Generate timing reports for function mode of operation
    report_timing -max_paths 50 -delay_type max > "../DFT_output/reports/timing_reports/function_mode/setup.rpt"
    report_timing -max_paths 50 -delay_type min > "../DFT_output/reports/timing_reports/function_mode/hold.rpt"
    # Generate SDC (Synopsys Design Constraints) file
    write_sdc -nosplit "../DFT_output/reports/timing_reports/function_mode/system_top.sdc"
    # Generate clocks report
    report_clock -attributes > "../DFT_output/reports/timing_reports/function_mode/clocks.rpt"

} elseif {$test_mode == 1 && $SE == 1} {
    # Generate timing reports for test scan mode of operation
    report_timing -max_paths 50 -delay_type max > "../DFT_output/reports/timing_reports/test_scan_mode/setup.rpt"
    report_timing -max_paths 50 -delay_type min > "../DFT_output/reports/timing_reports/test_scan_mode/hold.rpt"
    # Generate SDC (Synopsys Design Constraints) file
    write_sdc -nosplit "../DFT_output/reports/timing_reports/test_scan_mode/system_top.sdc"
    # Generate clocks report
    report_clock -attributes > "../DFT_output/reports/timing_reports/test_scan_mode/clocks.rpt"

} elseif {$test_mode == 1 && $SE == 0} {
    # Generate timing reports for test capture mode of operation
    report_timing -max_paths 50 -delay_type max > "../DFT_output/reports/timing_reports/test_capture_mode/setup.rpt"
    report_timing -max_paths 50 -delay_type min > "../DFT_output/reports/timing_reports/test_capture_mode/hold.rpt"
    # Generate SDC (Synopsys Design Constraints) file
    write_sdc -nosplit "../DFT_output/reports/timing_reports/test_capture_mode/system_top.sdc"
    # Generate clocks report
    report_clock -attributes > "../DFT_output/reports/timing_reports/test_capture_mode/clocks.rpt"
}


# Remove the ICG cell
cd "../../RTL/clock_gating_cell"
exec tclsh place_ICG_cell.tcl -r
cd "../../DFT/scripts"

# Close the design compiler tool
exit