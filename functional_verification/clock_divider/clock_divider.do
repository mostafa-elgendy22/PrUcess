vsim -gui work.clock_divider

add wave -position insertpoint  \
sim:/clock_divider/reference_clk \
sim:/clock_divider/reset \
sim:/clock_divider/clk_divider_enable \
sim:/clock_divider/division_ratio \
sim:/clock_divider/counter \
sim:/clock_divider/output_clk


force -freeze sim:/clock_divider/reference_clk 0 0, 1 {20 ps} -r 40 ps
force -freeze sim:/clock_divider/clk_divider_enable 0 0
force -freeze sim:/clock_divider/reset 0 0
run {80 ps}

force -freeze sim:/clock_divider/reset 1 0
run {130 ps}



force -freeze sim:/clock_divider/clk_divider_enable 1 0
force -freeze sim:/clock_divider/division_ratio 00_0101 0
run {830 ps}


force -freeze sim:/clock_divider/division_ratio 00_0011 0
run {3000 ps}


force -freeze sim:/clock_divider/division_ratio 00_1000 0
run {800 ps}


force -freeze sim:/clock_divider/division_ratio 00_0110 0
run {800 ps}