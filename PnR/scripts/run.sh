# This script runs the PnR flow
#!/bin/bash

innovus

# Clean the directory from temporary files
rm -f -r .cadence
rm -f innovus.logv
rm -f .system_top*
rm -f *.rpt
rm -f *.old
rm -f *.rguide
rm -f .tmp.cfp
rm -f *.cts_trace
rm -f CTS_RP_MOVE.txt
cd ../PnR_output/reports
rm -f -r timing_reports
rm -f -r clock_reports
cd ../../scripts
mv -f clock.ctstch.function_mode "clock_report/clock.ctstch.function_mode" 2>/dev/null
mv -f clock.ctstch.test_capture_mode "clock_report/clock.ctstch.test_capture_mode" 2>/dev/null
mv -f clock.ctstch.test_scan_mode "clock_report/clock.ctstch.test_scan_mode" 2>/dev/null
mv -f clock_report "../PnR_output/reports/clock_reports" 2>/dev/null
mv -f timingReports "../PnR_output/reports/timing_reports" 2>/dev/null
mv -f innovus.log "../PnR_output/logs/innovus.log" 2>/dev/null
mv -f innovus.cmd "../PnR_output/logs/innovus.cmd" 2>/dev/null