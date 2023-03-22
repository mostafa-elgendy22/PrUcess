# Formal verification setup file
set_svf "../DFT_output/UART_receiver.svf"

# Add the path of the std cells and the RTL files to the search path variable
lappend search_path "../../../../../../lib/std_cells"
lappend search_path "../../../"

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

read_file -format $file_format "UART_receiver_DFT.v"

# Set top module
current_design UART_receiver

# Link the top module with its submodules
link 

# Constraints
source -echo ./constraints.tcl

# Check the design consistency
check_design

# Specify the scan chain design
set_scan_configuration -clock_mixing no_mix  -style multiplexed_flip_flop -replace true -max_length 100  

# Mapping, optimization, STA, and replacement of FFs with scan FFS
compile -scan

# Preclock Measure Protocol (default protocol)
set test_default_period 100
set test_default_delay 0
set test_default_bidir_delay 0
set test_default_strobe 20
set test_default_strobe_width 0

# Define DFT ports
set_dft_signal -port [get_ports scan_clk]   -type ScanClock   -view existing_dft  -timing {30 60}
set_dft_signal -port [get_ports scan_reset] -type Reset       -view existing_dft  -active_state 0
set_dft_signal -port [get_ports test_mode]  -type Constant    -view existing_dft  -active_state 1 
set_dft_signal -port [get_ports test_mode]  -type TestMode    -view spec          -active_state 1 
set_dft_signal -port [get_ports SE]         -type ScanEnable  -view spec          -active_state 1   -usage scan
set_dft_signal -port [get_ports SI]         -type ScanDataIn  -view spec
set_dft_signal -port [get_ports SO]         -type ScanDataOut -view spec


# Create the test protocol based on specifications using set_dft_signal to check whether
# user specified values are consistent with each other
create_test_protocol

# Report the violations (i.e flops that can't be included in the scan chain)
dft_drc -verbose

# Report the scan chain architecture to be built instead of building it
preview_dft -show scan_summary

# Build the scan chains
insert_dft

# Make a second optimization phase after building the scan chains
compile -scan -incremental

# Show the test coverage statistics of the design after DFT insertion
dft_drc -verbose -coverage_estimate

# Generate synthesis reports
report_power -hierarchy > "../DFT_output/reports/power.rpt"
report_area -hierarchy > "../DFT_output/reports/area.rpt"
report_timing -max_paths 10 -delay_type max > "../DFT_output/reports/setup.rpt"
report_timing -max_paths 10 -delay_type min > "../DFT_output/reports/hold.rpt"
report_clock -attributes > "../DFT_output/reports/clocks.rpt"
report_constraint -all_violators > "../DFT_output/reports/constraints.rpt"
report_port > "../DFT_output/reports/ports.rpt"

# Generate Verilog gate level netlist
write_file -format verilog -hierarchy -output "../DFT_output/netlist/UART_receiver_netlist.v"

# Generate DDC gate level netlist
write_file -format ddc -hierarchy -output "../DFT_output/netlist/UART_receiver_netlist.ddc"

# Generate SDC (Synopsys Design Constraints) file
write_sdc -nosplit "../DFT_output/UART_receiver.sdc"

# Generate SDF (Standard Delay Format) file
write_sdf "../DFT_output/UART_receiver.sdf"

# set flops_per_chain 100.0

# set num_flops [sizeof_collection [all_registers -edge_triggered]]

# set num_chains [expr int(ceil($num_flops / $flops_per_chain))]

# Close the design compiler tool
exit