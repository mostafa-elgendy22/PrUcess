# Formal verification setup file
set_svf "../logic_synthesis_output/UART_receiver.svf"

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

# Reading the sub-modules' files are commented because they are included in the top design
# read_file -format $file_format "data_sampler.v"
# read_file -format $file_format "deserializer.v"
# read_file -format $file_format "edge_counter.v"
# read_file -format $file_format "UART_receiver_FSM.v"
# read_file -format $file_format "start_bit_checker.v"
# read_file -format $file_format "parity_bit_checker.v"
# read_file -format $file_format "stop_bit_checker.v"
read_file -format $file_format "UART_receiver.v"

# Set top module
current_design UART_receiver

# Link the top module with its submodules
link 

# Constraints
source -echo ./constraints.tcl

# Don't touch network (to prevent the tool from buffering the signals)
set_dont_touch_network {clk reset}

# Operating conditons
set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"

# Wire load model
set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c

# Mapping & optimization
compile

# Check the design consistency
check_design

# Generate synthesis reports
report_power -hierarchy > "../logic_synthesis_output/reports/power.rpt"
report_area -hierarchy > "../logic_synthesis_output/reports/area.rpt"
report_timing -max_paths 10 -delay_type max > "../logic_synthesis_output/reports/setup.rpt"
report_timing -max_paths 10 -delay_type min > "../logic_synthesis_output/reports/hold.rpt"
report_clock -attributes > "../logic_synthesis_output/reports/clocks.rpt"
report_constraint -all_violators > "../logic_synthesis_output/reports/constraints.rpt"
report_port > "../logic_synthesis_output/reports/ports.rpt"

# Generate Verilog gate level netlist
write_file -format verilog -hierarchy -output "../logic_synthesis_output/netlist/UART_receiver_netlist.v"

# Generate DDC gate level netlist
write_file -format ddc -hierarchy -output "../logic_synthesis_output/netlist/UART_receiver_netlist.ddc"

# Generate SDC (Synopsys Design Constraints) file
write_sdc -nosplit "../logic_synthesis_output/UART_receiver.sdc"

# Generate SDF (Standard Delay Format) file
write_sdf "../logic_synthesis_output/UART_receiver.sdf"

# Close the design compiler tool
exit