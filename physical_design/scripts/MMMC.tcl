# Define corners (standard cells' timing information)
create_library_set -name min_library -timing "../../lib/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.lib"
create_library_set -name max_library -timing "../../lib/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.lib"
# create_library_set -name typ_library -timing "../std_cells/libs/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.lib"

# Define modes
create_constraint_mode -name function_mode -sdc_files "../../DFT/DFT_output/reports/timing_reports/function_mode/system_top.sdc"
create_constraint_mode -name test_capture_mode -sdc_files "../../DFT/DFT_output/reports/timing_reports/test_capture_mode/system_top.sdc"
create_constraint_mode -name test_scan_mode -sdc_files "../../DFT/DFT_output/reports/timing_reports/test_scan_mode/system_top.sdc"


# Wires' timing information (using wire resistance and capacitance) "should use RC-table but it is missing"
create_rc_corner -name RC_corner -T {25}

# Merge standard cells' delays and Wires' delays
create_delay_corner -name max_corner -library_set max_library -rc_corner RC_corner
create_delay_corner -name min_corner -library_set min_library -rc_corner RC_corner


# Run STA on different modes
create_analysis_view -name function_setup_analysis_view -delay_corner max_corner -constraint_mode function_mode
create_analysis_view -name function_hold_analysis_view  -delay_corner min_corner -constraint_mode function_mode

create_analysis_view -name test_scan_setup_analysis_view -delay_corner max_corner -constraint_mode test_scan_mode
create_analysis_view -name test_scan_hold_analysis_view  -delay_corner min_corner -constraint_mode test_scan_mode

create_analysis_view -name test_capture_setup_analysis_view -delay_corner max_corner -constraint_mode test_capture_mode
create_analysis_view -name test_capture_hold_analysis_view  -delay_corner min_corner -constraint_mode test_capture_mode

set_analysis_view \
-setup {function_setup_analysis_view test_scan_setup_analysis_view test_capture_setup_analysis_view} \
-hold {function_hold_analysis_view test_scan_hold_analysis_view test_capture_hold_analysis_view}