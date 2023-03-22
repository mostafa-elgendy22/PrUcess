# Define CTS mode 
setCTSMode -specMultiMode true -engine ck -routeClkNet true

# Generate CTS file (which includes clocks)
clockDesign -genSpecOnly clock.ctstch

# Insert clock tree
clockDesign -specFile clock.ctstch -outDir clock_report -fixedInstBeforeCTS