vsim -gui work.clock_gating_cell

add wave -position insertpoint  \
sim:/clock_gating_cell/clk \
sim:/clock_gating_cell/clk_enable \
sim:/clock_gating_cell/gated_clock

force -freeze sim:/clock_gating_cell/clk 0 0, 1 {10 ps} -r 20 ps
force -freeze sim:/clock_gating_cell/clk_enable 0 0
run {25 ps}

force -freeze sim:/clock_gating_cell/clk_enable 1 0
run {49 ps}

force -freeze sim:/clock_gating_cell/clk_enable 0 0
run {24 ps}

force -freeze sim:/clock_gating_cell/clk_enable 1 0
run {39 ps}

force -freeze sim:/clock_gating_cell/clk_enable 0 0
run {86 ps}

force -freeze sim:/clock_gating_cell/clk_enable 1 0
run {28 ps}

force -freeze sim:/clock_gating_cell/clk_enable 0 0
run {43 ps}

force -freeze sim:/clock_gating_cell/clk_enable 1 0
run {29 ps}

force -freeze sim:/clock_gating_cell/clk_enable 0 0
run {86 ps}

force -freeze sim:/clock_gating_cell/clk_enable 1 0
run {39 ps}

force -freeze sim:/clock_gating_cell/clk_enable 0 0
run {86 ps}