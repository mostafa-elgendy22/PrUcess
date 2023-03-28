# Add the path of the std cells, RTL files, and the synthesis files to the search path variable
lappend search_path "../../../lib/std_cells"
lappend search_path "../../../RTL/system_top_DFT" "../../../RTL/UART/UART_transmitter" \
                    "../../../RTL/UART/UART_receiver" "../../../RTL/UART/UART" \
                    "../../../RTL/ALU" "../../../RTL/bus_synchronizer" \
                    "../../../RTL/clock_divider" "../../../RTL/clock_gating_cell" \
                    "../../../RTL/data_synchronizer" "../../../RTL/register_file" \
                    "../../../RTL/reset_synchronizer" "../../../RTL/system_controller"
lappend search_path "../../../DFT/DFT_output"
lappend search_path "../../../physical_design/physical_design_output"
lappend search_path "../../../physical_design/physical_design_output/netlist"

# Place the ICG cell
cd "../../../RTL/clock_gating_cell"
exec tclsh place_ICG_cell.tcl -p
cd "../../formal_verification/3-post_physical_design/scripts"

# Standard cells libraries
set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"


# The assumptions made in the synthesis will also be made in formality
# After using this command, setting dont verify SO port is not necessary because
# it ignores any undrived port
# set synopsys_auto_setup true

# This can be used to prevent ignoring undrived ports
# set verification_verify_directly_undriven_output true

# Formal verification setup file
set_svf "system_top.svf"


#--------------------------- Reference Design -----------------------------#
# Load standard cells library
read_db -container reference [list $SSLIB]

# Read reference design files (golden RTL files)
read_verilog -container reference "system_top_DFT.v"

# Set the reference design
set_reference_design "system_top"

# Set the top module for the reference container
set_top "system_top"
#---------------------------------------------------------------------------#


#-------------------------- Implementation Design --------------------------#
# Load standard cells library
read_db -container implementation [list $SSLIB]

# Read implementation design files (i.e. netlist generated after the logic synthesis)
read_verilog -container implementation "system_top_netlist.v"

# Set the implementation design
set_implementation_design "system_top"

# Set the top module for the implementation container
set_top "system_top"
#----------------------------------------------------------------------------#

# All ATPG enable ports (test_mode, scan_enable) are zero during compare (only functional mode is verified)
# test_mode
set_constant reference:/WORK/*/test_mode 0
set_constant implementation:/WORK/*/test_mode 0

# scan_enable
set_constant reference:/WORK/*/SE 0
set_constant implementation:/WORK/*/SE 0

# Don't verify the SO port (it is undriven in the RTL module but it is driven by logic after DFT insertion)
set_dont_verify_points -type port {reference:/WORK/*/SO[0] reference:/WORK/*/SO[1] reference:/WORK/*/SO[2]}
set_dont_verify_points -type port {implementation:/WORK/*/SO[0] implementation:/WORK/*/SO[1] implementation:/WORK/*/SO[2]}

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
cd "../../formal_verification/3-post_physical_design/scripts"

start_gui

exit