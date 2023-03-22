# Run the testbench
exec cmd.exe /c "vlib work"
exec cmd.exe /c "vlog bus_synchronizer_tb.v"
exec {*}[auto_execok start] vmap -c


# Generate the gray codes using the python script
exec cmd.exe /c "python gray_code_generator.py"


exec {*}[auto_execok start] vsim work.bus_synchronizer_tb -do "add wave -position insertpoint  \
sim:/bus_synchronizer_tb/U_bus_synchronizer/clk \
sim:/bus_synchronizer_tb/U_bus_synchronizer/reset \
sim:/bus_synchronizer_tb/U_bus_synchronizer/asynchronous_data \
sim:/bus_synchronizer_tb/U_bus_synchronizer/synchronous_data; run -all"


exec cmd.exe /c "del output.txt > nul 2>&1"
exec cmd.exe /c "del transcript > nul 2>&1"
exec cmd.exe /c "del modelsim.ini > nul 2>&1"
exec cmd.exe /c "del vsim.wlf > nul 2>&1"
exec cmd.exe /c "del vsim_stacktrace.vstf > nul 2>&1"
exec cmd.exe /c "del wlft3ghn8c > nul 2>&1"
exec cmd.exe /c "del *.vstf > nul 2>&1"
exec cmd.exe /c "rmdir /s /q work > nul 2>&1"