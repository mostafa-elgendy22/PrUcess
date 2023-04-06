exec cmd.exe /c "vlib work"
exec cmd.exe /c "vlog ../../RTL/clock_gating_cell/clock_gating_cell.v"
exec {*}[auto_execok start] vmap -c
exec {*}[auto_execok start] vsim work.clock_gating_cell -do "do clock_gating_cell.do"


exec cmd.exe /c "del transcript > nul 2>&1"
exec cmd.exe /c "del modelsim.ini > nul 2>&1"
exec cmd.exe /c "del vsim.wlf > nul 2>&1"
exec cmd.exe /c "del vsim_stacktrace.vstf > nul 2>&1"
exec cmd.exe /c "del wlft3ghn8c > nul 2>&1"
exec cmd.exe /c "rmdir /s /q work > nul 2>&1"