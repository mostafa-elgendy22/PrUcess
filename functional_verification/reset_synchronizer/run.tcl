exec cmd.exe /c "vlib work"
exec cmd.exe /c "vlog ../../RTL/reset_synchronizer/reset_synchronizer.v"
exec {*}[auto_execok start] vmap -c
exec {*}[auto_execok start] vsim work.reset_synchronizer -do "do reset_synchronizer.do"


exec cmd.exe /c "del transcript > nul 2>&1"
exec cmd.exe /c "del modelsim.ini > nul 2>&1"
exec cmd.exe /c "del vsim.wlf > nul 2>&1"
exec cmd.exe /c "del vsim_stacktrace.vstf > nul 2>&1"
exec cmd.exe /c "del wlft3ghn8c > nul 2>&1"
exec cmd.exe /c "rmdir /s /q work > nul 2>&1"