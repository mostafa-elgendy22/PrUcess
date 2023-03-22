puts "--------------------- Data synchronizer test cases --------------------"
cd data_synchronizer
source run.tcl
puts "-----------------------------------------------------------------------"

puts "----------------------- Register file test cases ----------------------"
cd ../register_file
source run.tcl
puts "-----------------------------------------------------------------------"

puts "----------------------- UART receiver test cases ----------------------"
cd ../UART/UART_receiver
source run.tcl
puts "-----------------------------------------------------------------------"

puts "---------------------- UART transmitter test cases --------------------"
cd ../UART_transmitter
source run.tcl
puts "-----------------------------------------------------------------------"

puts "----------------- UART receiver controller test cases -----------------"
cd ../../system_controller/UART_receiver_controller
source run.tcl
puts "-----------------------------------------------------------------------"

puts "---------------- UART transmitter controller test cases ---------------"
cd ../UART_transmitter_controller
source run.tcl
puts "-----------------------------------------------------------------------"

puts "------------------------ System top test cases ------------------------"
cd ../../system_top
source run.tcl
puts "-----------------------------------------------------------------------"