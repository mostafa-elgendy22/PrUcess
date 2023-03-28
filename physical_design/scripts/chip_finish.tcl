# Add filler cells
set filler_cell_list {FILL1M FILL2M FILL4M FILL8M FILL16M FILL32M FILL64M}
addFiller -cell $filler_cell_list -prefix FILLER -markFixed

# Generate post-physical_design gate level netlist
saveNetlist "../physical_design_output/netlist/system_top_netlist.v"

# Generate post-physical_design gate level netlist with PG Pins (for analog IR drop simulation)
saveNetlist "../physical_design_output/netlist/system_top_netlist_PG.v" -includePowerGround

# Generate SDF file (used in GLS)
delayCal -sdf "../physical_design_output/system_top.sdf" -version 3.0

# Generate reports
report_area > "../physical_design_output/reports/area.rpt"
report_power -outfile "../physical_design_output/reports/power.rpt"

# Generate GDS file
streamOut "../physical_design_output/system_top.gds" -mapFile "../design/gds2InLayer.map" -libName DesignLib -stripes 1 -units 2000 -mode ALL