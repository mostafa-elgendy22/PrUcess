# Add the path of the std cells, RTL files, and the synthesis files to the search path variable
lappend search_path "../../../../../../../lib/std_cells"
lappend search_path "../../../../"
lappend search_path "../../../DFT/DFT_output"
lappend search_path "../../../DFT/DFT_output/netlist"

# Standard cells libraries
set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"


# The assumptions made in the synthesis will also be made in formality
set synopsys_auto_setup true
# set verification_verify_directly_undriven_output true

# Formal verification setup file
set_svf "UART_receiver.svf"


#-------------------------- Reference Design --------------------------#
# Load standard cells library
read_db -container reference [list $SSLIB]

# Read reference design files (golden RTL files)
read_verilog -container reference "UART_receiver_DFT.v"

# Set the reference design
set_reference_design "UART_receiver"

# Set the top module for the reference container
set_top "UART_receiver"
#----------------------------------------------------------------------#


#-------------------------- Implementation Design --------------------------#
# Load standard cells library
read_db -container implementation [list $SSLIB]

# Read implementation design files (i.e. netlist generated the synthesis)
read_verilog -container implementation "UART_receiver_netlist.v"

# Set the implementation design
set_implementation_design "UART_receiver"

# Set the top module for the implementation container
set_top "UART_receiver"
#----------------------------------------------------------------------------#


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


start_gui

exit