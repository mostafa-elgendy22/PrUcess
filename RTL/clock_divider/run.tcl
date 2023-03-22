exec cmd.exe /c "vlib work"
exec cmd.exe /c "vlog clock_divider.v"
exec {*}[auto_execok start] vmap -c


# Open the waveform
exec {*}[auto_execok start] vsim work.clock_divider -do "do functional_verification/clock_divider.do"


exec cmd.exe /c "del output.txt > nul 2>&1"
exec cmd.exe /c "del transcript > nul 2>&1"
exec cmd.exe /c "del modelsim.ini > nul 2>&1"
exec cmd.exe /c "del vsim.wlf > nul 2>&1"
exec cmd.exe /c "del vsim_stacktrace.vstf > nul 2>&1"
exec cmd.exe /c "del wlft3ghn8c > nul 2>&1"
exec cmd.exe /c "del *.vstf > nul 2>&1"
exec cmd.exe /c "rmdir /s /q work > nul 2>&1"