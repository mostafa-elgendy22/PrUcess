# Chip dimensions' specifications
floorPlan -d 240.67 160.0 0.0 0.0 0.0 0.0

# Connect the VDD & VSS (specified in design import step) to all standard cells' power & ground pins
globalNetConnect VDD -type pgpin -pin VDD -inst *
globalNetConnect GND -type pgpin -pin VSS -inst *