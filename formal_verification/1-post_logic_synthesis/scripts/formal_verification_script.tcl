# Add the path of the std cells, RTL files, and the synthesis files to the search path variable
lappend search_path "../../../lib/std_cells"
lappend search_path "../../../RTL/system_top" "../../../RTL/UART/UART_transmitter" \
                    "../../../RTL/UART/UART_receiver" "../../../RTL/UART/UART" \
                    "../../../RTL/ALU" "../../../RTL/bus_synchronizer" \
                    "../../../RTL/clock_divider" "../../../RTL/clock_gating_cell" \
                    "../../../RTL/data_synchronizer" "../../../RTL/register_file" \
                    "../../../RTL/reset_synchronizer" "../../../RTL/system_controller"
lappend search_path "../../../logic_synthesis/logic_synthesis_output"
lappend search_path "../../../logic_synthesis/logic_synthesis_output/netlist"

# Place the ICG cell
cd "../../../RTL/clock_gating_cell"
exec tclsh place_ICG_cell.tcl -p
cd "../../formal_verification/1-post_logic_synthesis/scripts"

# Standard cells libraries
set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"


# The assumptions made in the synthesis will also be made in formality
# After using this command, setting dont verify SO port is not necessary because
# it ignores any undrived port
set synopsys_auto_setup true

# Formal verification setup file
set_svf "system_top.svf"


# -------------------------- Reference Design --------------------------
# Load standard cells library
read_db -container reference [list $SSLIB]

# Read reference design files (golden RTL files)
read_verilog -container reference "system_top.v"

# Set the reference design
set_reference_design "system_top"

# Set the top module for the reference container
set_top "system_top"
# ----------------------------------------------------------------------


#-------------------------- Implementation Design --------------------------
# Load standard cells library
read_db -container implementation [list $SSLIB]

# Read implementation design files (i.e. netlist generated the synthesis)
read_verilog -container implementation "system_top_netlist.v"

# Set the implementation design
set_implementation_design "system_top"

# Set the top module for the implementation container
set_top "system_top"
#----------------------------------------------------------------------------

# Match compare points
match


# Verify the equivalence of the compare points
set successful [verify]

if {!$successful} {
    diagnose
    analyze_points -failing
}

# Generate reports
report_passing_points > "../formal_verification_output/reports/passing_points.rpt"
report_failing_points > "../formal_verification_output/reports/failing_points.rpt"
report_aborted_points > "../formal_verification_output/reports/aborted_points.rpt"
report_unverified_points > "../formal_verification_output/reports/unverified_points.rpt"

# Remove the ICG cell
cd "../../../RTL/clock_gating_cell"
exec tclsh place_ICG_cell.tcl -r
cd "../../formal_verification/1-post_logic_synthesis/scripts"

start_gui

exit
