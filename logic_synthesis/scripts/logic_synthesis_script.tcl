# Formal verification setup file
set_svf "../logic_synthesis_output/system_top.svf"

# Place the ICG cell
cd "../../RTL/clock_gating_cell"
exec tclsh place_ICG_cell.tcl -p
cd "../../logic_synthesis/scripts"

# Add the path of the std cells and the RTL files to the search path variable
lappend search_path "../../lib/std_cells"
lappend search_path "../../RTL/system_top" "../../RTL/UART/UART_transmitter" \
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
# It is used to map generic cells to technology cells
set target_library [list $SSLIB]

# Link library is the list of design files and libraries used during linking
set link_library [list * $SSLIB $FFLIB]

# Read RTL design files
set file_format verilog

# Translate the module into a technology independent representation (GTECH)
read_file -format $file_format "system_top.v"

# Set top module
current_design system_top

# Link the top module with its submodules
link

# Check the design consistency
check_design

# Constraints
source -echo ./constraints.tcl

# Mapping, optimization, & STA with high effort
compile_ultra -no_autoungroup


# Generate synthesis reports
report_power -hierarchy -verbose > "../logic_synthesis_output/reports/power.rpt"
report_area -hierarchy > "../logic_synthesis_output/reports/area.rpt"
report_timing -max_paths 10 -delay_type max > "../logic_synthesis_output/reports/setup.rpt"
report_timing -max_paths 10 -delay_type min > "../logic_synthesis_output/reports/hold.rpt"
report_clock -attributes > "../logic_synthesis_output/reports/clocks.rpt"
report_constraint -all_violators > "../logic_synthesis_output/reports/constraints.rpt"
report_port > "../logic_synthesis_output/reports/ports.rpt"

# Generate Verilog gate level netlist
write_file -format verilog -hierarchy -output "../logic_synthesis_output/netlist/system_top_netlist.v"

# Generate DDC gate level netlist
write_file -format ddc -hierarchy -output "../logic_synthesis_output/netlist/system_top_netlist.ddc"

# Generate SDC (Synopsys Design Constraints) file
write_sdc -nosplit "../logic_synthesis_output/system_top.sdc"

# Generate SDF (Standard Delay Format) file used for timing simulation
write_sdf "../logic_synthesis_output/system_top.sdf"


# Remove the ICG cell
cd "../../RTL/clock_gating_cell"
exec tclsh place_ICG_cell.tcl -r
cd "../../logic_synthesis/scripts"

# DFT preparation
set flops_per_chain 100.0

set num_flops [sizeof_collection [all_registers -edge_triggered]]

set num_chains [expr int(ceil($num_flops / $flops_per_chain))]

# Close the design compiler tool
exit