Do the following steps initially:
1. install python
2. run this command "pip install bitarray"

You can go to "system_top/functional_verification/test_cases_generator.py" and add more test cases at the end
of the file following the same function calls as written in the file.

Run the script "run.tcl" to automate the whole simulation process. (it also compares the results of the
verilog module and the python module to make sure that the simulation is correct.)

The simulation might take some time because the periodic time of the UART_clock is very large.