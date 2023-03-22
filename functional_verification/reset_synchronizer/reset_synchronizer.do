vsim -gui work.reset_synchronizer

add wave -position insertpoint  \
sim:/reset_synchronizer/clk \
sim:/reset_synchronizer/reset \
sim:/reset_synchronizer/reset_synchronized

force -freeze sim:/reset_synchronizer/clk 0 0, 1 {10 ps} -r 20 ps
force -freeze sim:/reset_synchronizer/reset 0 0
run {25 ps}

force -freeze sim:/reset_synchronizer/reset 1 0
run {49 ps}

force -freeze sim:/reset_synchronizer/reset 0 0
run {24 ps}

force -freeze sim:/reset_synchronizer/reset 1 0
run {39 ps}

force -freeze sim:/reset_synchronizer/reset 0 0
run {86 ps}

force -freeze sim:/reset_synchronizer/reset 1 0
run {28 ps}

force -freeze sim:/reset_synchronizer/reset 0 0
run {43 ps}

force -freeze sim:/reset_synchronizer/reset 1 0
run {29 ps}

force -freeze sim:/reset_synchronizer/reset 0 0
run {86 ps}

force -freeze sim:/reset_synchronizer/reset 1 0
run {39 ps}

force -freeze sim:/reset_synchronizer/reset 0 0
run {86 ps}

# force -freeze sim:/reset_synchronizer/clk 0 0, 1 {10 ps} -r 20 ps
# force -freeze sim:/reset_synchronizer/reset 0 0
# run {29 ps}


# force -freeze sim:/reset_synchronizer/reset 1 0
# run {21 ps}

# force -freeze sim:/reset_synchronizer/reset 0 0
# run {40 ps}