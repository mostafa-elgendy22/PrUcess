/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : K-2015.06
// Date      : Wed Mar 22 23:31:43 2023
/////////////////////////////////////////////////////////////


module multiplexer_2x1_1 ( IN0, IN1, select, OUT );
  input IN0, IN1, select;
  output OUT;


  CLKMX2X2M U1 ( .A(IN0), .B(IN1), .S0(select), .Y(OUT) );
endmodule


module multiplexer_2x1_0 ( IN0, IN1, select, OUT );
  input IN0, IN1, select;
  output OUT;


  MX2XLM U1 ( .A(IN0), .B(IN1), .S0(select), .Y(OUT) );
endmodule


module reset_synchronizer_test_1 ( clk, reset, reset_synchronized, test_si, 
        test_se );
  input clk, reset, test_si, test_se;
  output reset_synchronized;
  wire   \Q[0] ;

  SDFFRQX1M \Q_reg[0]  ( .D(1'b1), .SI(test_si), .SE(test_se), .CK(clk), .RN(
        reset), .Q(\Q[0] ) );
  SDFFRQX1M \Q_reg[1]  ( .D(\Q[0] ), .SI(\Q[0] ), .SE(test_se), .CK(clk), .RN(
        reset), .Q(reset_synchronized) );
endmodule


module multiplexer_2x1_3 ( IN0, IN1, select, OUT );
  input IN0, IN1, select;
  output OUT;


  MX2XLM U1 ( .A(IN0), .B(IN1), .S0(select), .Y(OUT) );
endmodule


module UART_transmitter_controller_test_1 ( clk, reset, ALU_result_valid, 
        ALU_result, read_data_valid, read_data, transmitter_busy_synchronized, 
        transmitter_Q_pulse_generator, transmitter_parallel_data_valid, 
        transmitter_parallel_data, UART_receiver_controller_enable, test_si, 
        test_so, test_se );
  input [15:0] ALU_result;
  input [7:0] read_data;
  output [7:0] transmitter_parallel_data;
  input clk, reset, ALU_result_valid, read_data_valid,
         transmitter_busy_synchronized, transmitter_Q_pulse_generator, test_si,
         test_se;
  output transmitter_parallel_data_valid, UART_receiver_controller_enable,
         test_so;
  wire   N62, D_UART_receiver_controller_enable, n27, n29, n31, n33, n35, n37,
         n39, n41, n43, n45, n47, n49, n51, n53, n55, n57, n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n26;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  wire   [15:0] message;
  wire   [1:0] transmission_current_state;
  wire   [1:0] transmission_next_state;
  assign test_so = transmission_current_state[1];
  assign N62 = read_data_valid;

  SDFFRQX1M \current_state_reg[2]  ( .D(next_state[2]), .SI(current_state[1]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(current_state[2]) );
  SDFFRQX1M \current_state_reg[1]  ( .D(next_state[1]), .SI(current_state[0]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(current_state[1]) );
  SDFFRQX1M \current_state_reg[0]  ( .D(next_state[0]), .SI(
        UART_receiver_controller_enable), .SE(test_se), .CK(clk), .RN(reset), 
        .Q(current_state[0]) );
  SDFFRQX1M \transmission_current_state_reg[1]  ( .D(
        transmission_next_state[1]), .SI(transmission_current_state[0]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(transmission_current_state[1]) );
  SDFFRQX1M \transmission_current_state_reg[0]  ( .D(
        transmission_next_state[0]), .SI(message[15]), .SE(test_se), .CK(clk), 
        .RN(reset), .Q(transmission_current_state[0]) );
  SDFFRQX1M \message_reg[0]  ( .D(n27), .SI(current_state[2]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(message[0]) );
  NAND2BXLM U3 ( .AN(current_state[0]), .B(n21), .Y(n17) );
  INVXLM U4 ( .A(n6), .Y(n39) );
  NOR3BXLM U5 ( .AN(transmission_current_state[0]), .B(
        transmission_current_state[1]), .C(transmitter_busy_synchronized), .Y(
        transmission_next_state[1]) );
  INVXLM U6 ( .A(transmitter_busy_synchronized), .Y(n21) );
  NOR2XLM U7 ( .A(transmission_current_state[1]), .B(n21), .Y(
        transmission_next_state[0]) );
  NOR2BXLM U8 ( .AN(transmission_current_state[1]), .B(
        transmission_current_state[0]), .Y(n20) );
  NOR2XLM U9 ( .A(current_state[0]), .B(current_state[1]), .Y(n22) );
  NAND2XLM U10 ( .A(current_state[2]), .B(n22), .Y(n10) );
  NAND3BXLM U11 ( .AN(transmitter_Q_pulse_generator), .B(current_state[1]), 
        .C(current_state[0]), .Y(n1) );
  OAI22XLM U12 ( .A0(n20), .A1(n10), .B0(current_state[2]), .B1(n1), .Y(
        next_state[2]) );
  NOR2XLM U13 ( .A(N62), .B(ALU_result_valid), .Y(n13) );
  NAND2BXLM U14 ( .AN(N62), .B(ALU_result_valid), .Y(n16) );
  INVXLM U15 ( .A(n16), .Y(n12) );
  AOI222XLM U16 ( .A0(N62), .A1(read_data[5]), .B0(message[5]), .B1(n13), .C0(
        n12), .C1(ALU_result[5]), .Y(n2) );
  INVXLM U17 ( .A(n2), .Y(n37) );
  AOI222XLM U18 ( .A0(N62), .A1(read_data[7]), .B0(message[7]), .B1(n13), .C0(
        n12), .C1(ALU_result[7]), .Y(n3) );
  INVXLM U19 ( .A(n3), .Y(n41) );
  AOI222XLM U20 ( .A0(N62), .A1(read_data[2]), .B0(message[2]), .B1(n13), .C0(
        n12), .C1(ALU_result[2]), .Y(n4) );
  INVXLM U21 ( .A(n4), .Y(n31) );
  AOI222XLM U22 ( .A0(N62), .A1(read_data[1]), .B0(message[1]), .B1(n13), .C0(
        n12), .C1(ALU_result[1]), .Y(n5) );
  INVXLM U23 ( .A(n5), .Y(n29) );
  AOI222XLM U24 ( .A0(N62), .A1(read_data[6]), .B0(message[6]), .B1(n13), .C0(
        n12), .C1(ALU_result[6]), .Y(n6) );
  AOI222XLM U25 ( .A0(N62), .A1(read_data[4]), .B0(message[4]), .B1(n13), .C0(
        n12), .C1(ALU_result[4]), .Y(n7) );
  INVXLM U26 ( .A(n7), .Y(n35) );
  AOI222XLM U27 ( .A0(N62), .A1(read_data[3]), .B0(message[3]), .B1(n13), .C0(
        n12), .C1(ALU_result[3]), .Y(n8) );
  INVXLM U28 ( .A(n8), .Y(n33) );
  AOI222XLM U29 ( .A0(N62), .A1(read_data[0]), .B0(message[0]), .B1(n13), .C0(
        n12), .C1(ALU_result[0]), .Y(n9) );
  INVXLM U30 ( .A(n9), .Y(n27) );
  AOI211XLM U31 ( .A0(current_state[0]), .A1(current_state[1]), .B0(
        current_state[2]), .C0(n22), .Y(n15) );
  NAND2BXLM U32 ( .AN(n15), .B(n10), .Y(transmitter_parallel_data_valid) );
  NOR2XLM U33 ( .A(current_state[2]), .B(n22), .Y(n11) );
  INVXLM U34 ( .A(n10), .Y(n14) );
  NOR2XLM U35 ( .A(n11), .B(n14), .Y(D_UART_receiver_controller_enable) );
  CLKBUFX1M U36 ( .A(reset), .Y(n26) );
  AO22XLM U37 ( .A0(message[15]), .A1(n13), .B0(n12), .B1(ALU_result[15]), .Y(
        n57) );
  AO22XLM U38 ( .A0(message[14]), .A1(n13), .B0(n12), .B1(ALU_result[14]), .Y(
        n55) );
  AO22XLM U39 ( .A0(message[13]), .A1(n13), .B0(n12), .B1(ALU_result[13]), .Y(
        n53) );
  AO22XLM U40 ( .A0(message[12]), .A1(n13), .B0(n12), .B1(ALU_result[12]), .Y(
        n51) );
  AO22XLM U41 ( .A0(message[11]), .A1(n13), .B0(n12), .B1(ALU_result[11]), .Y(
        n49) );
  AO22XLM U42 ( .A0(message[10]), .A1(n13), .B0(n12), .B1(ALU_result[10]), .Y(
        n47) );
  AO22XLM U43 ( .A0(message[9]), .A1(n13), .B0(n12), .B1(ALU_result[9]), .Y(
        n45) );
  AO22XLM U44 ( .A0(message[8]), .A1(n13), .B0(n12), .B1(ALU_result[8]), .Y(
        n43) );
  AO22XLM U46 ( .A0(n15), .A1(message[7]), .B0(n14), .B1(message[15]), .Y(
        transmitter_parallel_data[7]) );
  AO22XLM U47 ( .A0(n15), .A1(message[6]), .B0(n14), .B1(message[14]), .Y(
        transmitter_parallel_data[6]) );
  AO22XLM U48 ( .A0(n15), .A1(message[5]), .B0(n14), .B1(message[13]), .Y(
        transmitter_parallel_data[5]) );
  AO22XLM U49 ( .A0(n15), .A1(message[4]), .B0(n14), .B1(message[12]), .Y(
        transmitter_parallel_data[4]) );
  AO22XLM U50 ( .A0(n15), .A1(message[3]), .B0(n14), .B1(message[11]), .Y(
        transmitter_parallel_data[3]) );
  AO22XLM U51 ( .A0(n15), .A1(message[2]), .B0(n14), .B1(message[10]), .Y(
        transmitter_parallel_data[2]) );
  AO22XLM U52 ( .A0(n15), .A1(message[1]), .B0(n14), .B1(message[9]), .Y(
        transmitter_parallel_data[1]) );
  AO22XLM U53 ( .A0(n15), .A1(message[0]), .B0(n14), .B1(message[8]), .Y(
        transmitter_parallel_data[0]) );
  OAI2B1XLM U54 ( .A1N(current_state[0]), .A0(transmitter_Q_pulse_generator), 
        .B0(current_state[1]), .Y(n18) );
  AOI221XLM U55 ( .A0(n17), .A1(n18), .B0(n16), .B1(n18), .C0(current_state[2]), .Y(next_state[1]) );
  OAI21XLM U56 ( .A0(n20), .A1(current_state[1]), .B0(n18), .Y(n19) );
  OAI21XLM U57 ( .A0(n20), .A1(current_state[0]), .B0(n19), .Y(n24) );
  NAND3XLM U58 ( .A(N62), .B(n22), .C(n21), .Y(n23) );
  AOI21XLM U59 ( .A0(n24), .A1(n23), .B0(current_state[2]), .Y(next_state[0])
         );
  SDFFRQX2M \message_reg[6]  ( .D(n39), .SI(message[5]), .SE(test_se), .CK(clk), .RN(n26), .Q(message[6]) );
  SDFFRQX2M \message_reg[8]  ( .D(n43), .SI(message[7]), .SE(test_se), .CK(clk), .RN(reset), .Q(message[8]) );
  SDFFRQX2M \message_reg[2]  ( .D(n31), .SI(message[1]), .SE(test_se), .CK(clk), .RN(n26), .Q(message[2]) );
  SDFFRQX2M \message_reg[3]  ( .D(n33), .SI(message[2]), .SE(test_se), .CK(clk), .RN(n26), .Q(message[3]) );
  SDFFRQX2M \message_reg[4]  ( .D(n35), .SI(message[3]), .SE(test_se), .CK(clk), .RN(n26), .Q(message[4]) );
  SDFFRQX2M \message_reg[5]  ( .D(n37), .SI(message[4]), .SE(test_se), .CK(clk), .RN(n26), .Q(message[5]) );
  SDFFRQX2M \message_reg[7]  ( .D(n41), .SI(message[6]), .SE(test_se), .CK(clk), .RN(n26), .Q(message[7]) );
  SDFFRQX2M \message_reg[9]  ( .D(n45), .SI(message[8]), .SE(test_se), .CK(clk), .RN(n26), .Q(message[9]) );
  SDFFRQX2M \message_reg[10]  ( .D(n47), .SI(message[9]), .SE(test_se), .CK(
        clk), .RN(n26), .Q(message[10]) );
  SDFFRQX2M \message_reg[11]  ( .D(n49), .SI(message[10]), .SE(test_se), .CK(
        clk), .RN(n26), .Q(message[11]) );
  SDFFRQX2M \message_reg[12]  ( .D(n51), .SI(message[11]), .SE(test_se), .CK(
        clk), .RN(n26), .Q(message[12]) );
  SDFFRQX2M \message_reg[13]  ( .D(n53), .SI(message[12]), .SE(test_se), .CK(
        clk), .RN(n26), .Q(message[13]) );
  SDFFRQX2M \message_reg[14]  ( .D(n55), .SI(message[13]), .SE(test_se), .CK(
        clk), .RN(reset), .Q(message[14]) );
  SDFFSQX1M UART_receiver_controller_enable_reg ( .D(
        D_UART_receiver_controller_enable), .SI(test_si), .SE(test_se), .CK(
        clk), .SN(reset), .Q(UART_receiver_controller_enable) );
  SDFFRQX1M \message_reg[1]  ( .D(n29), .SI(message[0]), .SE(test_se), .CK(clk), .RN(n26), .Q(message[1]) );
  SDFFRQX1M \message_reg[15]  ( .D(n57), .SI(message[14]), .SE(test_se), .CK(
        clk), .RN(reset), .Q(message[15]) );
endmodule


module UART_receiver_controller_test_1 ( clk, reset, enable, 
        parallel_data_valid_synchronized, parallel_data_synchronized, 
        ALU_function, ALU_enable, ALU_clk_enable, address, write_enable, 
        write_data, read_enable, test_si, test_so, test_se );
  input [7:0] parallel_data_synchronized;
  output [3:0] ALU_function;
  output [3:0] address;
  output [7:0] write_data;
  input clk, reset, enable, parallel_data_valid_synchronized, test_si, test_se;
  output ALU_enable, ALU_clk_enable, write_enable, read_enable, test_so;
  wire   N102, n46, n47, n48, n49, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  wire   [3:0] Q_write_address_register;
  wire   [1:0] counter;
  assign test_so = current_state[2];

  SDFFRQX1M \current_state_reg[0]  ( .D(next_state[0]), .SI(counter[1]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(current_state[0]) );
  SDFFRQX1M \current_state_reg[2]  ( .D(next_state[2]), .SI(current_state[1]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(current_state[2]) );
  SDFFRQX1M \current_state_reg[1]  ( .D(next_state[1]), .SI(current_state[0]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(current_state[1]) );
  SDFFRQX1M \counter_reg[1]  ( .D(N102), .SI(counter[0]), .SE(test_se), .CK(
        clk), .RN(reset), .Q(counter[1]) );
  NOR2BXLM U3 ( .AN(n18), .B(n16), .Y(n15) );
  NOR2XLM U4 ( .A(n15), .B(n31), .Y(write_data[2]) );
  NOR2XLM U5 ( .A(n29), .B(n22), .Y(ALU_function[0]) );
  INVXLM U6 ( .A(n14), .Y(n21) );
  INVXLM U7 ( .A(parallel_data_valid_synchronized), .Y(n8) );
  NOR3XLM U8 ( .A(counter[1]), .B(counter[0]), .C(n8), .Y(n1) );
  INVXLM U9 ( .A(current_state[1]), .Y(n19) );
  NAND3XLM U10 ( .A(current_state[2]), .B(n1), .C(n19), .Y(n18) );
  INVXLM U11 ( .A(n1), .Y(n27) );
  NOR4XLM U12 ( .A(current_state[0]), .B(current_state[2]), .C(n19), .D(n27), 
        .Y(n16) );
  INVXLM U13 ( .A(parallel_data_synchronized[2]), .Y(n31) );
  INVXLM U14 ( .A(parallel_data_synchronized[3]), .Y(n32) );
  NOR2XLM U15 ( .A(n15), .B(n32), .Y(write_data[3]) );
  INVXLM U16 ( .A(parallel_data_synchronized[1]), .Y(n30) );
  INVXLM U17 ( .A(current_state[0]), .Y(n28) );
  NOR2XLM U18 ( .A(n28), .B(n19), .Y(n26) );
  INVXLM U19 ( .A(current_state[2]), .Y(n25) );
  NAND3XLM U20 ( .A(n26), .B(n25), .C(n1), .Y(n2) );
  OAI2BB2XLM U21 ( .B0(n30), .B1(n2), .A0N(n16), .A1N(
        Q_write_address_register[1]), .Y(address[1]) );
  OAI2BB2XLM U22 ( .B0(n31), .B1(n2), .A0N(n16), .A1N(
        Q_write_address_register[2]), .Y(address[2]) );
  OAI2BB2XLM U23 ( .B0(n32), .B1(n2), .A0N(n16), .A1N(
        Q_write_address_register[3]), .Y(address[3]) );
  INVXLM U24 ( .A(n2), .Y(read_enable) );
  INVXLM U25 ( .A(n15), .Y(write_enable) );
  NOR2XLM U26 ( .A(n25), .B(n19), .Y(n14) );
  NOR2XLM U27 ( .A(n28), .B(n21), .Y(ALU_enable) );
  INVXLM U28 ( .A(ALU_enable), .Y(n22) );
  NOR2XLM U29 ( .A(n32), .B(n22), .Y(ALU_function[3]) );
  NOR2XLM U30 ( .A(n31), .B(n22), .Y(ALU_function[2]) );
  AND2X1M U31 ( .A(parallel_data_synchronized[6]), .B(write_enable), .Y(
        write_data[6]) );
  INVXLM U32 ( .A(parallel_data_synchronized[0]), .Y(n29) );
  NOR2XLM U33 ( .A(n15), .B(n29), .Y(write_data[0]) );
  INVXLM U34 ( .A(parallel_data_synchronized[5]), .Y(n3) );
  NOR2XLM U35 ( .A(n15), .B(n3), .Y(write_data[5]) );
  INVXLM U36 ( .A(parallel_data_synchronized[4]), .Y(n10) );
  NOR2XLM U37 ( .A(n15), .B(n10), .Y(write_data[4]) );
  AND2X1M U38 ( .A(parallel_data_synchronized[7]), .B(write_enable), .Y(
        write_data[7]) );
  NOR2XLM U39 ( .A(n30), .B(n22), .Y(ALU_function[1]) );
  AOI33XLM U40 ( .A0(parallel_data_valid_synchronized), .A1(current_state[0]), 
        .A2(n19), .B0(current_state[1]), .B1(n25), .B2(n8), .Y(n7) );
  NOR4XLM U41 ( .A(parallel_data_synchronized[2]), .B(
        parallel_data_synchronized[6]), .C(n30), .D(n3), .Y(n11) );
  AND4XLM U42 ( .A(parallel_data_synchronized[6]), .B(
        parallel_data_synchronized[2]), .C(n3), .D(n30), .Y(n24) );
  NOR2XLM U43 ( .A(n11), .B(n24), .Y(n5) );
  NOR4XLM U44 ( .A(current_state[2]), .B(current_state[0]), .C(
        current_state[1]), .D(n8), .Y(n4) );
  NAND4XLM U45 ( .A(enable), .B(parallel_data_synchronized[3]), .C(
        parallel_data_synchronized[7]), .D(n4), .Y(n9) );
  OR4X1M U46 ( .A(n5), .B(n9), .C(n29), .D(n10), .Y(n6) );
  OAI211XLM U47 ( .A0(current_state[0]), .A1(n21), .B0(n7), .C0(n6), .Y(
        next_state[1]) );
  NOR2XLM U48 ( .A(current_state[0]), .B(n8), .Y(n12) );
  AOI221XLM U49 ( .A0(parallel_data_synchronized[0]), .A1(n10), .B0(n29), .B1(
        parallel_data_synchronized[4]), .C0(n9), .Y(n23) );
  AOI22XLM U50 ( .A0(current_state[2]), .A1(n12), .B0(n11), .B1(n23), .Y(n13)
         );
  OAI31XLM U51 ( .A0(parallel_data_valid_synchronized), .A1(n14), .A2(n28), 
        .B0(n13), .Y(next_state[0]) );
  NOR2XLM U52 ( .A(n15), .B(n30), .Y(write_data[1]) );
  AOI22XLM U53 ( .A0(parallel_data_synchronized[0]), .A1(read_enable), .B0(
        Q_write_address_register[0]), .B1(n16), .Y(n17) );
  OAI21XLM U54 ( .A0(n28), .A1(n18), .B0(n17), .Y(address[0]) );
  NAND4BXLM U55 ( .AN(counter[0]), .B(counter[1]), .C(n25), .D(n19), .Y(n20)
         );
  OAI222XLM U56 ( .A0(n21), .A1(n27), .B0(n21), .B1(n28), .C0(current_state[0]), .C1(n20), .Y(ALU_clk_enable) );
  NOR2XLM U57 ( .A(parallel_data_valid_synchronized), .B(n22), .Y(N102) );
  OAI2BB2XLM U58 ( .B0(n26), .B1(n25), .A0N(n24), .A1N(n23), .Y(next_state[2])
         );
  NOR4XLM U59 ( .A(current_state[1]), .B(current_state[2]), .C(n28), .D(n27), 
        .Y(n33) );
  AOI2BB2XLM U60 ( .B0(n33), .B1(n29), .A0N(Q_write_address_register[0]), 
        .A1N(n33), .Y(n49) );
  AOI2BB2XLM U61 ( .B0(n33), .B1(n30), .A0N(Q_write_address_register[1]), 
        .A1N(n33), .Y(n48) );
  AOI2BB2XLM U62 ( .B0(n33), .B1(n31), .A0N(Q_write_address_register[2]), 
        .A1N(n33), .Y(n47) );
  AOI2BB2XLM U63 ( .B0(n33), .B1(n32), .A0N(Q_write_address_register[3]), 
        .A1N(n33), .Y(n46) );
  SDFFRQX2M \Q_write_address_register_reg[3]  ( .D(n46), .SI(
        Q_write_address_register[2]), .SE(test_se), .CK(clk), .RN(reset), .Q(
        Q_write_address_register[3]) );
  SDFFRQX2M \Q_write_address_register_reg[0]  ( .D(n49), .SI(test_si), .SE(
        test_se), .CK(clk), .RN(reset), .Q(Q_write_address_register[0]) );
  SDFFRQX2M \Q_write_address_register_reg[1]  ( .D(n48), .SI(
        Q_write_address_register[0]), .SE(test_se), .CK(clk), .RN(reset), .Q(
        Q_write_address_register[1]) );
  SDFFRQX2M \Q_write_address_register_reg[2]  ( .D(n47), .SI(
        Q_write_address_register[1]), .SE(test_se), .CK(clk), .RN(reset), .Q(
        Q_write_address_register[2]) );
  SDFFRQX2M \counter_reg[0]  ( .D(parallel_data_valid_synchronized), .SI(
        Q_write_address_register[3]), .SE(test_se), .CK(clk), .RN(reset), .Q(
        counter[0]) );
endmodule


module system_controller_test_1 ( clk, reset, ALU_result_valid, ALU_result, 
        register_file_read_data_valid, register_file_read_data, 
        transmitter_busy_synchronized, transmitter_Q_pulse_generator, 
        receiver_parallel_data_valid_synchronized, 
        receiver_parallel_data_synchronized, ALU_function, ALU_enable, 
        ALU_clk_enable, transmitter_parallel_data_valid, 
        transmitter_parallel_data, register_file_address, 
        register_file_write_enable, register_file_write_data, 
        register_file_read_enable, test_so, test_se );
  input [15:0] ALU_result;
  input [7:0] register_file_read_data;
  input [7:0] receiver_parallel_data_synchronized;
  output [3:0] ALU_function;
  output [7:0] transmitter_parallel_data;
  output [3:0] register_file_address;
  output [7:0] register_file_write_data;
  input clk, reset, ALU_result_valid, register_file_read_data_valid,
         transmitter_busy_synchronized, transmitter_Q_pulse_generator,
         receiver_parallel_data_valid_synchronized, test_se;
  output ALU_enable, ALU_clk_enable, transmitter_parallel_data_valid,
         register_file_write_enable, register_file_read_enable, test_so;
  wire   receiver_controller_enable, n2;

  UART_transmitter_controller_test_1 U_UART_transmitter_controller ( .clk(clk), 
        .reset(reset), .ALU_result_valid(ALU_result_valid), .ALU_result(
        ALU_result), .read_data_valid(register_file_read_data_valid), 
        .read_data(register_file_read_data), .transmitter_busy_synchronized(
        transmitter_busy_synchronized), .transmitter_Q_pulse_generator(
        transmitter_Q_pulse_generator), .transmitter_parallel_data_valid(
        transmitter_parallel_data_valid), .transmitter_parallel_data(
        transmitter_parallel_data), .UART_receiver_controller_enable(
        receiver_controller_enable), .test_si(n2), .test_so(test_so), 
        .test_se(test_se) );
  UART_receiver_controller_test_1 U_UART_receiver_controller ( .clk(clk), 
        .reset(reset), .enable(receiver_controller_enable), 
        .parallel_data_valid_synchronized(
        receiver_parallel_data_valid_synchronized), 
        .parallel_data_synchronized(receiver_parallel_data_synchronized), 
        .ALU_function(ALU_function), .ALU_enable(ALU_enable), .ALU_clk_enable(
        ALU_clk_enable), .address(register_file_address), .write_enable(
        register_file_write_enable), .write_data(register_file_write_data), 
        .read_enable(register_file_read_enable), .test_si(
        register_file_read_data_valid), .test_so(n2), .test_se(test_se) );
endmodule


module clock_gating_cell ( clk, clk_enable, gated_clock );
  input clk, clk_enable;
  output gated_clock;


  TLATNCAX4M U_ICG_cell ( .E(clk_enable), .CK(clk), .ECK(gated_clock) );
endmodule


module ALU_test_1 ( clk, reset, A, B, ALU_function, enable, ALU_result_valid, 
        ALU_result, test_si, test_se );
  input [7:0] A;
  input [7:0] B;
  input [3:0] ALU_function;
  output [15:0] ALU_result;
  input clk, reset, enable, test_si, test_se;
  output ALU_result_valid;
  wire   N178, N179, N180, N181, N182, N183, N184, N185, N186, N187, N188,
         N189, N190, N191, N192, N193, N194, \C7M/DATA15_0 , \C7M/DATA15_1 ,
         \C7M/DATA15_2 , \C7M/DATA15_3 , \C7M/DATA15_4 , \C7M/DATA15_5 ,
         \C7M/DATA15_6 , \C7M/DATA15_7 , \DP_OP_29J1_122_2578/n43 ,
         \DP_OP_29J1_122_2578/n29 , \DP_OP_29J1_122_2578/n28 ,
         \DP_OP_29J1_122_2578/n27 , \DP_OP_29J1_122_2578/n26 ,
         \DP_OP_29J1_122_2578/n25 , \DP_OP_29J1_122_2578/n24 ,
         \DP_OP_29J1_122_2578/n23 , \DP_OP_29J1_122_2578/n22 ,
         \DP_OP_29J1_122_2578/n16 , \DP_OP_29J1_122_2578/n15 ,
         \DP_OP_29J1_122_2578/n14 , \DP_OP_29J1_122_2578/n13 ,
         \DP_OP_29J1_122_2578/n12 , \DP_OP_29J1_122_2578/n11 ,
         \DP_OP_29J1_122_2578/n10 , \DP_OP_29J1_122_2578/n9 , \intadd_0/A[4] ,
         \intadd_0/A[3] , \intadd_0/A[2] , \intadd_0/A[1] , \intadd_0/A[0] ,
         \intadd_0/B[4] , \intadd_0/B[3] , \intadd_0/B[2] , \intadd_0/B[1] ,
         \intadd_0/B[0] , \intadd_0/CI , \intadd_0/SUM[4] , \intadd_0/SUM[3] ,
         \intadd_0/SUM[2] , \intadd_0/SUM[1] , \intadd_0/SUM[0] ,
         \intadd_0/n5 , \intadd_0/n4 , \intadd_0/n3 , \intadd_0/n2 ,
         \intadd_0/n1 , \intadd_1/A[3] , \intadd_1/A[2] , \intadd_1/A[1] ,
         \intadd_1/A[0] , \intadd_1/B[4] , \intadd_1/B[3] , \intadd_1/B[2] ,
         \intadd_1/B[1] , \intadd_1/B[0] , \intadd_1/CI , \intadd_1/SUM[4] ,
         \intadd_1/SUM[3] , \intadd_1/SUM[2] , \intadd_1/SUM[1] ,
         \intadd_1/SUM[0] , \intadd_1/n5 , \intadd_1/n4 , \intadd_1/n3 ,
         \intadd_1/n2 , \intadd_1/n1 , \intadd_2/A[3] , \intadd_2/A[2] ,
         \intadd_2/A[1] , \intadd_2/A[0] , \intadd_2/B[3] , \intadd_2/B[2] ,
         \intadd_2/B[1] , \intadd_2/B[0] , \intadd_2/CI , \intadd_2/SUM[3] ,
         \intadd_2/SUM[2] , \intadd_2/SUM[1] , \intadd_2/SUM[0] ,
         \intadd_2/n4 , \intadd_2/n3 , \intadd_2/n2 , \intadd_2/n1 ,
         \intadd_3/A[3] , \intadd_3/A[2] , \intadd_3/A[1] , \intadd_3/A[0] ,
         \intadd_3/B[2] , \intadd_3/B[1] , \intadd_3/B[0] , \intadd_3/CI ,
         \intadd_3/SUM[2] , \intadd_3/SUM[0] , \intadd_3/n4 , \intadd_3/n3 ,
         \intadd_3/n2 , \intadd_3/n1 , \intadd_4/A[0] , \intadd_4/B[1] ,
         \intadd_4/B[0] , \intadd_4/CI , \intadd_4/SUM[0] , \intadd_4/n3 ,
         \intadd_4/n2 , \intadd_4/n1 , \intadd_5/A[2] , \intadd_5/A[0] ,
         \intadd_5/B[1] , \intadd_5/B[0] , \intadd_5/CI , \intadd_5/n3 ,
         \intadd_5/n2 , \intadd_5/n1 , \intadd_6/A[2] , \intadd_6/A[0] ,
         \intadd_6/B[2] , \intadd_6/B[1] , \intadd_6/B[0] , \intadd_6/CI ,
         \intadd_6/SUM[2] , \intadd_6/SUM[1] , \intadd_6/SUM[0] ,
         \intadd_6/n3 , \intadd_6/n2 , \intadd_6/n1 , \intadd_7/A[1] ,
         \intadd_7/A[0] , \intadd_7/B[2] , \intadd_7/B[1] , \intadd_7/B[0] ,
         \intadd_7/CI , \intadd_7/SUM[2] , \intadd_7/SUM[1] ,
         \intadd_7/SUM[0] , \intadd_7/n3 , \intadd_7/n2 , \intadd_7/n1 , n1,
         n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n148, n149, n150, n151, n152, n153, n154, n155, n156,
         n157, n158, n159, n160, n161, n162, n163, n164, n165, n166, n167,
         n168, n169, n170, n171, n172, n173, n174, n175, n176, n177, n178,
         n179, n180, n181, n182, n183, n184, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n195, n196, n197, n198, n199, n200,
         n201, n202, n203, n204, n205, n206, n207, n208, n209, n210, n211,
         n212, n213, n214, n215, n216, n217, n218, n219, n220, n221, n222,
         n223, n224, n225, n226, n227, n228, n229, n230, n231, n232, n233,
         n234, n235, n236, n237, n238, n239, n240, n241, n242, n243, n244,
         n245, n246, n247, n248, n249, n250, n251, n252, n253, n254, n255,
         n256, n257, n258, n259, n260, n261, n262, n263, n264, n265, n266,
         n267, n268, n269, n270, n271, n272, n273, n274, n275, n276, n277,
         n278, n279, n280, n281, n282, n283, n284, n285, n286, n287, n288,
         n289, n290, n291, n292, n293, n294, n295, n296, n297, n298, n299,
         n300, n301, n302, n303, n304, n305, n306, n307, n308, n309, n310,
         n311, n312, n313, n314, n315, n316, n317, n318, n319, n320, n321,
         n322, n323, n324, n325, n326, n327, n328, n329, n330, n331, n332,
         n333, n334, n335, n336, n337, n338, n339, n340, n341, n342, n343,
         n344, n345, n346, n347, n348, n349, n350, n351, n352, n353, n354,
         n355, n356, n357, n358, n359, n360, n361, n362, n363, n364, n365,
         n366, n367, n368, n369, n370, n371, n372;

  SDFFRQX1M \ALU_result_reg[15]  ( .D(N194), .SI(ALU_result[14]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[15]) );
  SDFFRQX1M \ALU_result_reg[14]  ( .D(N193), .SI(ALU_result[13]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[14]) );
  SDFFRQX1M \ALU_result_reg[13]  ( .D(N192), .SI(ALU_result[12]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[13]) );
  SDFFRQX1M \ALU_result_reg[12]  ( .D(N191), .SI(ALU_result[11]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[12]) );
  SDFFRQX1M \ALU_result_reg[11]  ( .D(N190), .SI(ALU_result[10]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[11]) );
  SDFFRQX1M \ALU_result_reg[10]  ( .D(N189), .SI(ALU_result[9]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[10]) );
  SDFFRQX1M \ALU_result_reg[9]  ( .D(N188), .SI(ALU_result[8]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[9]) );
  SDFFRQX1M \ALU_result_reg[8]  ( .D(N187), .SI(ALU_result[7]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[8]) );
  SDFFRQX1M \ALU_result_reg[7]  ( .D(N186), .SI(ALU_result[6]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[7]) );
  SDFFRQX1M \ALU_result_reg[6]  ( .D(N185), .SI(ALU_result[5]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[6]) );
  SDFFRQX1M \ALU_result_reg[5]  ( .D(N184), .SI(ALU_result[4]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[5]) );
  SDFFRQX1M \ALU_result_reg[4]  ( .D(N183), .SI(ALU_result[3]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[4]) );
  SDFFRQX1M \ALU_result_reg[3]  ( .D(N182), .SI(ALU_result[2]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[3]) );
  SDFFRQX1M \ALU_result_reg[2]  ( .D(N181), .SI(ALU_result[1]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[2]) );
  SDFFRQX1M \ALU_result_reg[1]  ( .D(N180), .SI(ALU_result[0]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result[1]) );
  SDFFRQX1M \ALU_result_reg[0]  ( .D(N179), .SI(test_si), .SE(test_se), .CK(
        clk), .RN(reset), .Q(ALU_result[0]) );
  SDFFRQX1M ALU_result_valid_reg ( .D(N178), .SI(ALU_result[15]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(ALU_result_valid) );
  ADDFX1M \intadd_3/U3  ( .A(\intadd_3/A[2] ), .B(\intadd_3/B[2] ), .CI(
        \intadd_3/n3 ), .CO(\intadd_3/n2 ), .S(\intadd_3/SUM[2] ) );
  ADDFX1M \intadd_4/U3  ( .A(\intadd_0/SUM[0] ), .B(\intadd_4/B[1] ), .CI(
        \intadd_4/n3 ), .CO(\intadd_4/n2 ), .S(\intadd_1/A[2] ) );
  ADDFX1M \intadd_4/U2  ( .A(\intadd_0/SUM[1] ), .B(\intadd_3/SUM[2] ), .CI(
        \intadd_4/n2 ), .CO(\intadd_4/n1 ), .S(\intadd_1/B[3] ) );
  ADDFX1M \intadd_3/U2  ( .A(\intadd_3/A[3] ), .B(\intadd_0/SUM[2] ), .CI(
        \intadd_3/n2 ), .CO(\intadd_3/n1 ), .S(\intadd_1/B[4] ) );
  ADDFX1M \intadd_6/U2  ( .A(\intadd_6/A[2] ), .B(\intadd_6/B[2] ), .CI(
        \intadd_6/n2 ), .CO(\intadd_6/n1 ), .S(\intadd_6/SUM[2] ) );
  ADDFX1M \intadd_0/U3  ( .A(\intadd_0/A[3] ), .B(\intadd_0/B[3] ), .CI(
        \intadd_0/n3 ), .CO(\intadd_0/n2 ), .S(\intadd_0/SUM[3] ) );
  ADDFX1M \intadd_2/U3  ( .A(\intadd_2/A[2] ), .B(\intadd_2/B[2] ), .CI(
        \intadd_2/n3 ), .CO(\intadd_2/n2 ), .S(\intadd_2/SUM[2] ) );
  ADDFX1M \intadd_1/U2  ( .A(\intadd_4/n1 ), .B(\intadd_1/B[4] ), .CI(
        \intadd_1/n2 ), .CO(\intadd_1/n1 ), .S(\intadd_1/SUM[4] ) );
  ADDFX1M \DP_OP_29J1_122_2578/U18  ( .A(\DP_OP_29J1_122_2578/n26 ), .B(A[3]), 
        .CI(\DP_OP_29J1_122_2578/n14 ), .CO(\DP_OP_29J1_122_2578/n13 ), .S(
        \C7M/DATA15_3 ) );
  ADDFX1M \DP_OP_29J1_122_2578/U17  ( .A(\DP_OP_29J1_122_2578/n25 ), .B(A[4]), 
        .CI(\DP_OP_29J1_122_2578/n13 ), .CO(\DP_OP_29J1_122_2578/n12 ), .S(
        \C7M/DATA15_4 ) );
  ADDFX1M \DP_OP_29J1_122_2578/U14  ( .A(\DP_OP_29J1_122_2578/n22 ), .B(A[7]), 
        .CI(\DP_OP_29J1_122_2578/n10 ), .CO(\DP_OP_29J1_122_2578/n9 ), .S(
        \C7M/DATA15_7 ) );
  ADDFX1M \intadd_0/U5  ( .A(\intadd_0/A[1] ), .B(\intadd_0/B[1] ), .CI(
        \intadd_0/n5 ), .CO(\intadd_0/n4 ), .S(\intadd_0/SUM[1] ) );
  ADDFX1M \intadd_3/U5  ( .A(\intadd_3/A[0] ), .B(\intadd_3/B[0] ), .CI(
        \intadd_3/CI ), .CO(\intadd_3/n4 ), .S(\intadd_3/SUM[0] ) );
  ADDFX1M \intadd_3/U4  ( .A(\intadd_3/A[1] ), .B(\intadd_3/B[1] ), .CI(
        \intadd_3/n4 ), .CO(\intadd_3/n3 ), .S(\intadd_1/B[2] ) );
  ADDFX1M \intadd_4/U4  ( .A(\intadd_4/A[0] ), .B(\intadd_4/B[0] ), .CI(
        \intadd_4/CI ), .CO(\intadd_4/n3 ), .S(\intadd_4/SUM[0] ) );
  ADDFX1M \intadd_5/U4  ( .A(\intadd_5/A[0] ), .B(\intadd_5/B[0] ), .CI(
        \intadd_5/CI ), .CO(\intadd_5/n3 ), .S(\intadd_0/A[2] ) );
  ADDFX1M \intadd_0/U4  ( .A(\intadd_0/A[2] ), .B(\intadd_0/B[2] ), .CI(
        \intadd_0/n4 ), .CO(\intadd_0/n3 ), .S(\intadd_0/SUM[2] ) );
  ADDFX1M \intadd_6/U4  ( .A(\intadd_6/A[0] ), .B(\intadd_6/B[0] ), .CI(
        \intadd_6/CI ), .CO(\intadd_6/n3 ), .S(\intadd_6/SUM[0] ) );
  ADDFX1M \intadd_7/U2  ( .A(\intadd_6/SUM[0] ), .B(\intadd_7/B[2] ), .CI(
        \intadd_7/n2 ), .CO(\intadd_7/n1 ), .S(\intadd_7/SUM[2] ) );
  ADDFX1M \intadd_1/U5  ( .A(\intadd_1/A[1] ), .B(\intadd_1/B[1] ), .CI(
        \intadd_1/n5 ), .CO(\intadd_1/n4 ), .S(\intadd_1/SUM[1] ) );
  ADDFX1M \intadd_2/U5  ( .A(\intadd_2/A[0] ), .B(\intadd_2/B[0] ), .CI(
        \intadd_2/CI ), .CO(\intadd_2/n4 ), .S(\intadd_2/SUM[0] ) );
  ADDFX1M \intadd_5/U3  ( .A(\intadd_2/SUM[0] ), .B(\intadd_5/B[1] ), .CI(
        \intadd_5/n3 ), .CO(\intadd_5/n2 ), .S(\intadd_0/B[3] ) );
  ADDFX1M \intadd_2/U4  ( .A(\intadd_2/A[1] ), .B(\intadd_2/B[1] ), .CI(
        \intadd_2/n4 ), .CO(\intadd_2/n3 ), .S(\intadd_2/SUM[1] ) );
  ADDFX1M \intadd_5/U2  ( .A(\intadd_5/A[2] ), .B(\intadd_2/SUM[1] ), .CI(
        \intadd_5/n2 ), .CO(\intadd_5/n1 ), .S(\intadd_0/B[4] ) );
  ADDFX1M \intadd_0/U2  ( .A(\intadd_0/A[4] ), .B(\intadd_0/B[4] ), .CI(
        \intadd_0/n2 ), .CO(\intadd_0/n1 ), .S(\intadd_0/SUM[4] ) );
  INVXLM U3 ( .A(n19), .Y(n259) );
  NAND3XLM U4 ( .A(n27), .B(n4), .C(n15), .Y(n19) );
  NOR2XLM U5 ( .A(A[0]), .B(n317), .Y(n153) );
  AOI22XLM U6 ( .A0(B[0]), .A1(n153), .B0(A[1]), .B1(n155), .Y(n154) );
  NOR2XLM U7 ( .A(A[0]), .B(n372), .Y(n157) );
  OAI31XLM U8 ( .A0(n152), .A1(n151), .A2(n150), .B0(n149), .Y(n159) );
  INVXLM U9 ( .A(n201), .Y(n183) );
  NOR2XLM U10 ( .A(B[3]), .B(n112), .Y(n142) );
  NAND2XLM U11 ( .A(A[0]), .B(n372), .Y(n189) );
  OAI21XLM U12 ( .A0(n98), .A1(n97), .B0(n99), .Y(n96) );
  OAI21XLM U13 ( .A0(n46), .A1(n47), .B0(n44), .Y(n61) );
  OAI21XLM U14 ( .A0(n136), .A1(n135), .B0(n137), .Y(n134) );
  AOI22XLM U15 ( .A0(n317), .A1(n62), .B0(n61), .B1(n45), .Y(n55) );
  NOR4XLM U16 ( .A(n368), .B(n366), .C(n317), .D(n372), .Y(\intadd_1/A[0] ) );
  NOR2XLM U17 ( .A(n323), .B(n358), .Y(n304) );
  AOI31XLM U18 ( .A0(n210), .A1(n209), .A2(n208), .B0(n207), .Y(n212) );
  AOI222XLM U19 ( .A0(B[3]), .A1(n73), .B0(B[3]), .B1(n75), .C0(n73), .C1(n75), 
        .Y(n68) );
  INVXLM U20 ( .A(\intadd_7/n1 ), .Y(n291) );
  OAI31XLM U21 ( .A0(n305), .A1(n304), .A2(n303), .B0(n302), .Y(
        \intadd_0/B[2] ) );
  NOR2XLM U22 ( .A(n88), .B(n334), .Y(n118) );
  NAND2XLM U23 ( .A(n323), .B(n318), .Y(n92) );
  OAI211XLM U24 ( .A0(n69), .A1(n54), .B0(n53), .C0(n52), .Y(n242) );
  INVXLM U25 ( .A(n231), .Y(n349) );
  INVXLM U26 ( .A(n345), .Y(n253) );
  INVXLM U27 ( .A(\intadd_2/SUM[2] ), .Y(n271) );
  OAI211XLM U28 ( .A0(n358), .A1(n233), .B0(n127), .C0(n126), .Y(n128) );
  NOR2BXLM U29 ( .AN(n22), .B(n21), .Y(n354) );
  OAI22XLM U30 ( .A0(n274), .A1(n349), .B0(n319), .B1(n253), .Y(n17) );
  OAI21XLM U31 ( .A0(n321), .A1(n253), .B0(n248), .Y(n249) );
  AOI211XLM U32 ( .A0(\C7M/DATA15_6 ), .A1(n259), .B0(n29), .C0(n28), .Y(n30)
         );
  AOI21XLM U33 ( .A0(n34), .A1(n259), .B0(n33), .Y(n35) );
  OAI2BB1XLM U34 ( .A0N(n259), .A1N(n251), .B0(n250), .Y(N187) );
  INVXLM U35 ( .A(ALU_function[2]), .Y(n4) );
  INVXLM U36 ( .A(ALU_function[0]), .Y(n198) );
  NOR2XLM U37 ( .A(n4), .B(n198), .Y(n22) );
  INVXLM U38 ( .A(enable), .Y(n1) );
  AOI31XLM U39 ( .A0(ALU_function[3]), .A1(ALU_function[1]), .A2(n22), .B0(n1), 
        .Y(N178) );
  NOR2BXLM U40 ( .AN(ALU_function[0]), .B(ALU_function[2]), .Y(n23) );
  NOR3BX1M U41 ( .AN(n23), .B(ALU_function[3]), .C(ALU_function[1]), .Y(
        \DP_OP_29J1_122_2578/n43 ) );
  INVXLM U42 ( .A(\DP_OP_29J1_122_2578/n43 ), .Y(n247) );
  NOR2XLM U43 ( .A(\DP_OP_29J1_122_2578/n9 ), .B(n247), .Y(n34) );
  INVXLM U44 ( .A(ALU_function[3]), .Y(n27) );
  INVXLM U45 ( .A(ALU_function[1]), .Y(n217) );
  NAND2XLM U46 ( .A(enable), .B(n217), .Y(n24) );
  INVXLM U47 ( .A(n24), .Y(n15) );
  INVXLM U48 ( .A(\intadd_1/n1 ), .Y(n282) );
  INVXLM U49 ( .A(\intadd_0/SUM[3] ), .Y(n281) );
  AOI22XLM U50 ( .A0(\intadd_0/SUM[3] ), .A1(\intadd_1/n1 ), .B0(n282), .B1(
        n281), .Y(n3) );
  NAND2XLM U51 ( .A(enable), .B(ALU_function[1]), .Y(n16) );
  NAND2BXLM U52 ( .AN(n16), .B(n27), .Y(n14) );
  NOR3X1M U53 ( .A(ALU_function[2]), .B(ALU_function[0]), .C(n14), .Y(n344) );
  INVXLM U54 ( .A(n344), .Y(n37) );
  AOI21XLM U55 ( .A0(\intadd_3/n1 ), .A1(n3), .B0(n37), .Y(n2) );
  OAI21XLM U56 ( .A0(\intadd_3/n1 ), .A1(n3), .B0(n2), .Y(n5) );
  NOR2XLM U57 ( .A(n4), .B(ALU_function[0]), .Y(n213) );
  INVXLM U58 ( .A(n213), .Y(n26) );
  NOR2XLM U59 ( .A(n26), .B(n14), .Y(n231) );
  NAND2XLM U60 ( .A(ALU_function[3]), .B(n15), .Y(n21) );
  AOI221XLM U61 ( .A0(ALU_function[2]), .A1(n14), .B0(n4), .B1(n21), .C0(n198), 
        .Y(n178) );
  NOR2XLM U62 ( .A(n231), .B(n178), .Y(n248) );
  OAI2B11XLM U63 ( .A1N(n34), .A0(n19), .B0(n5), .C0(n248), .Y(N189) );
  INVXLM U64 ( .A(\intadd_0/n1 ), .Y(n272) );
  AOI22XLM U65 ( .A0(\intadd_2/SUM[2] ), .A1(\intadd_0/n1 ), .B0(n272), .B1(
        n271), .Y(n7) );
  AOI21XLM U66 ( .A0(\intadd_5/n1 ), .A1(n7), .B0(n37), .Y(n6) );
  OAI21XLM U67 ( .A0(\intadd_5/n1 ), .A1(n7), .B0(n6), .Y(n8) );
  OAI2B11XLM U68 ( .A1N(n34), .A0(n19), .B0(n8), .C0(n248), .Y(N191) );
  INVXLM U69 ( .A(A[7]), .Y(n321) );
  INVXLM U70 ( .A(B[5]), .Y(n311) );
  NOR2XLM U71 ( .A(n321), .B(n311), .Y(n275) );
  INVXLM U72 ( .A(A[6]), .Y(n370) );
  INVXLM U73 ( .A(B[6]), .Y(n318) );
  NOR2XLM U74 ( .A(n370), .B(n318), .Y(n274) );
  INVXLM U75 ( .A(B[7]), .Y(n323) );
  INVXLM U76 ( .A(A[5]), .Y(n319) );
  NOR2XLM U77 ( .A(n323), .B(n319), .Y(n273) );
  NOR2XLM U78 ( .A(n323), .B(n370), .Y(n268) );
  NOR2XLM U79 ( .A(n321), .B(n318), .Y(n267) );
  NOR2XLM U80 ( .A(n321), .B(n323), .Y(n256) );
  OAI211XLM U81 ( .A0(\intadd_2/n1 ), .A1(n10), .B0(n256), .C0(n344), .Y(n9)
         );
  OAI2B11XLM U82 ( .A1N(n34), .A0(n19), .B0(n9), .C0(n248), .Y(N194) );
  AOI2BB2XLM U83 ( .B0(n256), .B1(n10), .A0N(n10), .A1N(n256), .Y(n12) );
  AOI21XLM U84 ( .A0(\intadd_2/n1 ), .A1(n12), .B0(n37), .Y(n11) );
  OAI21XLM U85 ( .A0(\intadd_2/n1 ), .A1(n12), .B0(n11), .Y(n13) );
  OAI2B11XLM U86 ( .A1N(n34), .A0(n19), .B0(n13), .C0(n248), .Y(N193) );
  NOR2BXLM U87 ( .AN(n23), .B(n14), .Y(n353) );
  INVXLM U88 ( .A(n353), .Y(n266) );
  INVXLM U89 ( .A(B[1]), .Y(n317) );
  INVXLM U90 ( .A(B[3]), .Y(n327) );
  NAND3XLM U91 ( .A(n323), .B(n318), .C(n311), .Y(n70) );
  NOR2XLM U92 ( .A(B[4]), .B(n70), .Y(n52) );
  NAND2XLM U93 ( .A(n327), .B(n52), .Y(n42) );
  NOR2XLM U94 ( .A(n42), .B(B[2]), .Y(n252) );
  AOI21BXLM U95 ( .A0(n370), .A1(B[0]), .B0N(n252), .Y(n40) );
  OAI21XLM U96 ( .A0(A[7]), .A1(n317), .B0(n40), .Y(n38) );
  NAND3XLM U97 ( .A(n27), .B(n22), .C(n15), .Y(n228) );
  AOI21XLM U98 ( .A0(n370), .A1(n318), .B0(n228), .Y(n18) );
  NOR3XLM U99 ( .A(n27), .B(n26), .C(n16), .Y(n345) );
  AOI211XLM U100 ( .A0(n344), .A1(\intadd_6/SUM[2] ), .B0(n18), .C0(n17), .Y(
        n31) );
  INVXLM U101 ( .A(n178), .Y(n343) );
  NAND2XLM U102 ( .A(n370), .B(n318), .Y(n20) );
  AOI22XLM U103 ( .A0(A[6]), .A1(n318), .B0(B[6]), .B1(n370), .Y(n191) );
  NOR3XLM U104 ( .A(ALU_function[2]), .B(ALU_function[0]), .C(n21), .Y(n226)
         );
  INVXLM U105 ( .A(n226), .Y(n340) );
  OAI22XLM U106 ( .A0(n343), .A1(n20), .B0(n191), .B1(n340), .Y(n29) );
  INVXLM U107 ( .A(n354), .Y(n233) );
  NOR2XLM U108 ( .A(n23), .B(n27), .Y(n25) );
  AOI211XLM U109 ( .A0(n27), .A1(n26), .B0(n25), .C0(n24), .Y(n355) );
  OAI2BB2XLM U110 ( .B0(n233), .B1(n321), .A0N(n355), .A1N(n274), .Y(n28) );
  OAI211XLM U111 ( .A0(n266), .A1(n38), .B0(n31), .C0(n30), .Y(N185) );
  INVXLM U112 ( .A(n248), .Y(n33) );
  AOI21XLM U113 ( .A0(\intadd_1/SUM[4] ), .A1(n344), .B0(n33), .Y(n32) );
  OAI2BB1XLM U114 ( .A0N(n259), .A1N(n34), .B0(n32), .Y(N188) );
  OAI2BB1XLM U115 ( .A0N(n344), .A1N(\intadd_0/SUM[4] ), .B0(n35), .Y(N190) );
  OAI2BB1XLM U116 ( .A0N(n344), .A1N(\intadd_2/SUM[3] ), .B0(n35), .Y(N192) );
  NAND2XLM U117 ( .A(B[1]), .B(A[1]), .Y(n363) );
  NAND2XLM U118 ( .A(B[1]), .B(A[0]), .Y(n359) );
  INVXLM U119 ( .A(n228), .Y(n346) );
  AOI31XLM U120 ( .A0(B[0]), .A1(n344), .A2(n359), .B0(n346), .Y(n36) );
  INVXLM U121 ( .A(A[1]), .Y(n360) );
  NAND2XLM U122 ( .A(A[1]), .B(n317), .Y(n190) );
  OAI22XLM U123 ( .A0(n36), .A1(n360), .B0(n190), .B1(n340), .Y(n123) );
  INVXLM U124 ( .A(A[0]), .Y(n364) );
  NOR3XLM U125 ( .A(n317), .B(n364), .C(n37), .Y(n124) );
  AOI221XLM U126 ( .A0(n226), .A1(B[1]), .B0(n178), .B1(n317), .C0(n124), .Y(
        n121) );
  INVXLM U127 ( .A(A[4]), .Y(n368) );
  NAND2XLM U128 ( .A(B[0]), .B(n368), .Y(n62) );
  INVXLM U129 ( .A(B[2]), .Y(n362) );
  NAND2XLM U130 ( .A(n319), .B(B[0]), .Y(n47) );
  INVXLM U131 ( .A(n47), .Y(n48) );
  CLKINVX1M U132 ( .A(B[0]), .Y(n372) );
  OAI21XLM U133 ( .A0(n372), .A1(n38), .B0(A[6]), .Y(n49) );
  AOI222XLM U134 ( .A0(B[1]), .A1(n48), .B0(B[1]), .B1(n49), .C0(n48), .C1(n49), .Y(n39) );
  OAI21XLM U135 ( .A0(A[7]), .A1(n362), .B0(n39), .Y(n43) );
  AOI211XLM U136 ( .A0(n317), .A1(n252), .B0(n321), .C0(n40), .Y(n41) );
  INVXLM U137 ( .A(n41), .Y(n51) );
  AOI221XLM U138 ( .A0(B[2]), .A1(n43), .B0(n51), .B1(n43), .C0(n42), .Y(n236)
         );
  INVXLM U139 ( .A(n236), .Y(n46) );
  OAI21XLM U140 ( .A0(n46), .A1(n372), .B0(A[5]), .Y(n44) );
  NAND3XLM U141 ( .A(B[1]), .B(B[0]), .C(n368), .Y(n45) );
  NOR2XLM U142 ( .A(B[2]), .B(n55), .Y(n60) );
  AOI221XLM U143 ( .A0(n48), .A1(B[1]), .B0(n47), .B1(n317), .C0(n46), .Y(n50)
         );
  XOR2XLM U144 ( .A(n50), .B(n49), .Y(n59) );
  NOR2XLM U145 ( .A(n51), .B(n236), .Y(n69) );
  AOI222XLM U146 ( .A0(B[2]), .A1(n55), .B0(B[2]), .B1(n59), .C0(n55), .C1(n59), .Y(n54) );
  AO21XLM U147 ( .A0(n69), .A1(n54), .B0(n327), .Y(n53) );
  NAND2XLM U148 ( .A(B[2]), .B(n55), .Y(n56) );
  NAND2BXLM U149 ( .AN(n242), .B(n56), .Y(n58) );
  OAI21XLM U150 ( .A0(n60), .A1(n58), .B0(n59), .Y(n57) );
  OAI31XLM U151 ( .A0(n60), .A1(n59), .A2(n58), .B0(n57), .Y(n75) );
  INVXLM U152 ( .A(n61), .Y(n65) );
  AOI32XLM U153 ( .A0(B[0]), .A1(n317), .A2(n368), .B0(B[1]), .B1(n62), .Y(n64) );
  OAI21XLM U154 ( .A0(n242), .A1(n64), .B0(n65), .Y(n63) );
  OAI31XLM U155 ( .A0(n242), .A1(n65), .A2(n64), .B0(n63), .Y(n77) );
  INVXLM U156 ( .A(A[3]), .Y(n366) );
  NAND2XLM U157 ( .A(B[0]), .B(n366), .Y(n81) );
  OAI21XLM U158 ( .A0(n372), .A1(n242), .B0(A[4]), .Y(n66) );
  OAI31XLM U159 ( .A0(n372), .A1(A[4]), .A2(n242), .B0(n66), .Y(n84) );
  NAND3XLM U160 ( .A(B[1]), .B(B[0]), .C(n366), .Y(n67) );
  AOI22XLM U161 ( .A0(n317), .A1(n81), .B0(n84), .B1(n67), .Y(n76) );
  INVXLM U162 ( .A(n73), .Y(n72) );
  INVXLM U163 ( .A(B[4]), .Y(n310) );
  OAI21XLM U164 ( .A0(n69), .A1(n310), .B0(n68), .Y(n71) );
  NAND2XLM U165 ( .A(n69), .B(n242), .Y(n88) );
  AOI221XLM U166 ( .A0(B[4]), .A1(n71), .B0(n88), .B1(n71), .C0(n70), .Y(n334)
         );
  AOI221XLM U168 ( .A0(n73), .A1(B[3]), .B0(n72), .B1(n327), .C0(n85), .Y(n74)
         );
  XOR2XLM U169 ( .A(n75), .B(n74), .Y(n89) );
  INVXLM U170 ( .A(n89), .Y(n99) );
  MXI2XLM U172 ( .A(n78), .B(n77), .S0(n85), .Y(n116) );
  INVXLM U173 ( .A(A[2]), .Y(n358) );
  AOI21XLM U174 ( .A0(B[0]), .A1(n358), .B0(B[1]), .Y(n80) );
  OAI21XLM U175 ( .A0(n85), .A1(n372), .B0(A[3]), .Y(n79) );
  OAI31XLM U176 ( .A0(n85), .A1(A[3]), .A2(n372), .B0(n79), .Y(n105) );
  NOR2XLM U177 ( .A(n372), .B(A[2]), .Y(n102) );
  OAI2BB2XLM U178 ( .B0(n80), .B1(n105), .A0N(B[1]), .A1N(n102), .Y(n86) );
  NOR2XLM U179 ( .A(B[2]), .B(n86), .Y(n111) );
  AOI32XLM U180 ( .A0(B[0]), .A1(n317), .A2(n366), .B0(B[1]), .B1(n81), .Y(n83) );
  OAI21XLM U181 ( .A0(n85), .A1(n83), .B0(n84), .Y(n82) );
  OAI31XLM U182 ( .A0(n85), .A1(n84), .A2(n83), .B0(n82), .Y(n110) );
  NAND2XLM U183 ( .A(B[2]), .B(n86), .Y(n107) );
  OAI21XLM U184 ( .A0(n111), .A1(n110), .B0(n107), .Y(n87) );
  NOR2XLM U185 ( .A(B[3]), .B(n87), .Y(n113) );
  NAND2XLM U186 ( .A(B[3]), .B(n87), .Y(n114) );
  OAI21XLM U187 ( .A0(n116), .A1(n113), .B0(n114), .Y(n94) );
  NOR2XLM U188 ( .A(B[4]), .B(n94), .Y(n98) );
  INVXLM U189 ( .A(n118), .Y(n93) );
  AOI222XLM U190 ( .A0(B[4]), .A1(n94), .B0(B[4]), .B1(n89), .C0(n94), .C1(n89), .Y(n90) );
  AOI21XLM U191 ( .A0(n311), .A1(n118), .B0(n90), .Y(n91) );
  AOI211XLM U192 ( .A0(n93), .A1(B[5]), .B0(n92), .C0(n91), .Y(n352) );
  NAND2XLM U193 ( .A(B[4]), .B(n94), .Y(n95) );
  NAND2XLM U194 ( .A(n352), .B(n95), .Y(n97) );
  OAI31XLM U195 ( .A0(n99), .A1(n98), .A2(n97), .B0(n96), .Y(n137) );
  NOR2XLM U196 ( .A(A[1]), .B(n372), .Y(n148) );
  NOR2XLM U197 ( .A(B[1]), .B(n148), .Y(n101) );
  INVXLM U198 ( .A(n352), .Y(n117) );
  OAI21XLM U199 ( .A0(n117), .A1(n372), .B0(A[2]), .Y(n100) );
  OAI31XLM U200 ( .A0(n117), .A1(A[2]), .A2(n372), .B0(n100), .Y(n151) );
  OAI2BB2XLM U201 ( .B0(n101), .B1(n151), .A0N(B[1]), .A1N(n148), .Y(n106) );
  NOR2XLM U202 ( .A(B[2]), .B(n106), .Y(n143) );
  OAI32XLM U203 ( .A0(n317), .A1(A[2]), .A2(n372), .B0(B[1]), .B1(n102), .Y(
        n104) );
  OAI21XLM U204 ( .A0(n117), .A1(n104), .B0(n105), .Y(n103) );
  OAI31XLM U205 ( .A0(n117), .A1(n105), .A2(n104), .B0(n103), .Y(n146) );
  NAND2XLM U206 ( .A(B[2]), .B(n106), .Y(n144) );
  OAI21XLM U207 ( .A0(n143), .A1(n146), .B0(n144), .Y(n112) );
  NAND2XLM U208 ( .A(n107), .B(n352), .Y(n109) );
  OAI21XLM U209 ( .A0(n111), .A1(n109), .B0(n110), .Y(n108) );
  OAI31XLM U210 ( .A0(n111), .A1(n110), .A2(n109), .B0(n108), .Y(n141) );
  NAND2XLM U211 ( .A(B[3]), .B(n112), .Y(n138) );
  OAI21XLM U212 ( .A0(n142), .A1(n141), .B0(n138), .Y(n164) );
  NOR3BXLM U213 ( .AN(n114), .B(n113), .C(n117), .Y(n115) );
  XNOR2XLM U214 ( .A(n116), .B(n115), .Y(n168) );
  AOI222XLM U215 ( .A0(B[4]), .A1(n164), .B0(B[4]), .B1(n168), .C0(n164), .C1(
        n168), .Y(n131) );
  AOI222XLM U216 ( .A0(n137), .A1(n131), .B0(n137), .B1(n311), .C0(n131), .C1(
        n311), .Y(n119) );
  NAND2XLM U217 ( .A(n118), .B(n117), .Y(n177) );
  OR2X1M U218 ( .A(n119), .B(n177), .Y(n120) );
  AOI221XLM U219 ( .A0(B[6]), .A1(n120), .B0(n119), .B1(n177), .C0(B[7]), .Y(
        n175) );
  INVXLM U220 ( .A(n175), .Y(n152) );
  OAI22XLM U221 ( .A0(A[1]), .A1(n121), .B0(n152), .B1(n266), .Y(n122) );
  AOI211XLM U222 ( .A0(n231), .A1(n363), .B0(n123), .C0(n122), .Y(n130) );
  INVXLM U223 ( .A(n363), .Y(n125) );
  AOI22XLM U224 ( .A0(n125), .A1(n355), .B0(n124), .B1(n372), .Y(n127) );
  AOI22XLM U225 ( .A0(B[1]), .A1(n346), .B0(A[0]), .B1(n345), .Y(n126) );
  AOI21XLM U226 ( .A0(n259), .A1(\C7M/DATA15_1 ), .B0(n128), .Y(n129) );
  NAND2XLM U227 ( .A(n130), .B(n129), .Y(N180) );
  INVXLM U228 ( .A(n131), .Y(n132) );
  NOR2XLM U229 ( .A(B[5]), .B(n132), .Y(n136) );
  NAND2XLM U230 ( .A(B[5]), .B(n132), .Y(n133) );
  NAND2XLM U231 ( .A(n175), .B(n133), .Y(n135) );
  OAI31XLM U232 ( .A0(n137), .A1(n136), .A2(n135), .B0(n134), .Y(n173) );
  NAND2XLM U233 ( .A(n175), .B(n138), .Y(n140) );
  OAI21XLM U234 ( .A0(n142), .A1(n140), .B0(n141), .Y(n139) );
  OAI31XLM U235 ( .A0(n142), .A1(n141), .A2(n140), .B0(n139), .Y(n163) );
  NOR3BXLM U236 ( .AN(n144), .B(n143), .C(n152), .Y(n145) );
  XNOR2XLM U237 ( .A(n146), .B(n145), .Y(n161) );
  OAI32XLM U238 ( .A0(n317), .A1(A[1]), .A2(n372), .B0(B[1]), .B1(n148), .Y(
        n150) );
  OAI21XLM U239 ( .A0(n152), .A1(n150), .B0(n151), .Y(n149) );
  NOR2XLM U240 ( .A(n372), .B(n152), .Y(n155) );
  OAI21XLM U241 ( .A0(A[1]), .A1(n155), .B0(n154), .Y(n156) );
  OAI21XLM U242 ( .A0(B[1]), .A1(n157), .B0(n156), .Y(n158) );
  AOI222XLM U243 ( .A0(n362), .A1(n159), .B0(n362), .B1(n158), .C0(n159), .C1(
        n158), .Y(n160) );
  AOI222XLM U244 ( .A0(B[3]), .A1(n161), .B0(B[3]), .B1(n160), .C0(n161), .C1(
        n160), .Y(n162) );
  AOI222XLM U245 ( .A0(n310), .A1(n163), .B0(n310), .B1(n162), .C0(n163), .C1(
        n162), .Y(n171) );
  NOR2XLM U246 ( .A(B[4]), .B(n164), .Y(n169) );
  NAND2XLM U247 ( .A(B[4]), .B(n164), .Y(n165) );
  NAND2XLM U248 ( .A(n175), .B(n165), .Y(n167) );
  OAI21XLM U249 ( .A0(n169), .A1(n167), .B0(n168), .Y(n166) );
  OAI31XLM U250 ( .A0(n169), .A1(n168), .A2(n167), .B0(n166), .Y(n170) );
  AOI222XLM U251 ( .A0(B[5]), .A1(n171), .B0(B[5]), .B1(n170), .C0(n171), .C1(
        n170), .Y(n172) );
  AOI222XLM U252 ( .A0(n173), .A1(n318), .B0(n173), .B1(n172), .C0(n318), .C1(
        n172), .Y(n174) );
  OAI31XLM U253 ( .A0(B[7]), .A1(n177), .A2(n175), .B0(n174), .Y(n176) );
  OAI2BB1XLM U254 ( .A0N(n177), .A1N(B[7]), .B0(n176), .Y(n223) );
  AOI221XLM U255 ( .A0(n226), .A1(B[0]), .B0(n178), .B1(n372), .C0(n231), .Y(
        n180) );
  AOI22XLM U256 ( .A0(\C7M/DATA15_0 ), .A1(n259), .B0(n354), .B1(A[1]), .Y(
        n179) );
  OAI21XLM U257 ( .A0(n180), .A1(A[0]), .B0(n179), .Y(n181) );
  AOI221XLM U258 ( .A0(n346), .A1(B[0]), .B0(n231), .B1(n372), .C0(n181), .Y(
        n222) );
  NAND2XLM U259 ( .A(n323), .B(A[7]), .Y(n214) );
  INVXLM U260 ( .A(n214), .Y(n197) );
  NOR2XLM U261 ( .A(n370), .B(B[6]), .Y(n207) );
  INVXLM U262 ( .A(n207), .Y(n188) );
  NAND2XLM U263 ( .A(B[1]), .B(n360), .Y(n182) );
  OAI22XLM U264 ( .A0(B[1]), .A1(n360), .B0(B[2]), .B1(n358), .Y(n200) );
  AOI31XLM U265 ( .A0(A[0]), .A1(n182), .A2(n372), .B0(n200), .Y(n185) );
  NOR2XLM U266 ( .A(n366), .B(B[3]), .Y(n199) );
  INVXLM U267 ( .A(n199), .Y(n184) );
  AOI22XLM U268 ( .A0(n366), .A1(B[3]), .B0(n358), .B1(B[2]), .Y(n201) );
  NOR2XLM U269 ( .A(A[4]), .B(n310), .Y(n204) );
  AOI221XLM U270 ( .A0(n185), .A1(n184), .B0(n183), .B1(n184), .C0(n204), .Y(
        n186) );
  AOI22XLM U271 ( .A0(n310), .A1(A[4]), .B0(n311), .B1(A[5]), .Y(n205) );
  INVXLM U272 ( .A(n205), .Y(n194) );
  NAND2XLM U273 ( .A(B[6]), .B(n370), .Y(n208) );
  NAND2XLM U274 ( .A(B[5]), .B(n319), .Y(n209) );
  OAI211XLM U275 ( .A0(n186), .A1(n194), .B0(n208), .C0(n209), .Y(n187) );
  AOI22XLM U276 ( .A0(B[7]), .A1(n321), .B0(n188), .B1(n187), .Y(n196) );
  AOI22XLM U277 ( .A0(n360), .A1(B[1]), .B0(n364), .B1(B[0]), .Y(n202) );
  NAND4BXLM U278 ( .AN(n204), .B(n209), .C(n190), .D(n189), .Y(n193) );
  AOI22XLM U279 ( .A0(A[7]), .A1(n323), .B0(B[7]), .B1(n321), .Y(n254) );
  AOI22XLM U280 ( .A0(B[3]), .A1(n366), .B0(A[3]), .B1(n327), .Y(n328) );
  AOI22XLM U281 ( .A0(B[2]), .A1(n358), .B0(A[2]), .B1(n362), .Y(n341) );
  NAND4XLM U282 ( .A(n254), .B(n191), .C(n328), .D(n341), .Y(n192) );
  NOR4BXLM U283 ( .AN(n202), .B(n194), .C(n193), .D(n192), .Y(n195) );
  OAI32XLM U284 ( .A0(n198), .A1(n197), .A2(n196), .B0(ALU_function[0]), .B1(
        n195), .Y(n216) );
  AOI221XLM U285 ( .A0(n202), .A1(n201), .B0(n200), .B1(n201), .C0(n199), .Y(
        n206) );
  NAND2XLM U286 ( .A(A[5]), .B(n311), .Y(n203) );
  AOI22XLM U287 ( .A0(n206), .A1(n205), .B0(n204), .B1(n203), .Y(n210) );
  NOR2XLM U288 ( .A(A[7]), .B(n323), .Y(n211) );
  AOI32XLM U289 ( .A0(n214), .A1(n213), .A2(n212), .B0(n211), .B1(n213), .Y(
        n215) );
  OAI32XLM U290 ( .A0(n217), .A1(ALU_function[2]), .A2(n216), .B0(
        ALU_function[1]), .B1(n215), .Y(n220) );
  OAI32XLM U291 ( .A0(n372), .A1(n344), .A2(n355), .B0(n226), .B1(B[0]), .Y(
        n218) );
  AOI21XLM U292 ( .A0(n218), .A1(n228), .B0(n364), .Y(n219) );
  AOI31XLM U293 ( .A0(enable), .A1(ALU_function[3]), .A2(n220), .B0(n219), .Y(
        n221) );
  OAI211XLM U294 ( .A0(n223), .A1(n266), .B0(n222), .C0(n221), .Y(N179) );
  NAND2XLM U295 ( .A(B[5]), .B(A[5]), .Y(n283) );
  NAND2XLM U296 ( .A(B[2]), .B(A[1]), .Y(n338) );
  NOR2XLM U297 ( .A(n327), .B(n364), .Y(n339) );
  NOR3XLM U298 ( .A(n362), .B(n364), .C(n363), .Y(n361) );
  AOI2B1XLM U299 ( .A1N(n338), .A0(n339), .B0(n361), .Y(n296) );
  NAND2XLM U300 ( .A(B[3]), .B(A[1]), .Y(n295) );
  NOR4XLM U301 ( .A(n366), .B(n358), .C(n317), .D(n372), .Y(n365) );
  INVXLM U302 ( .A(n365), .Y(n294) );
  INVXLM U303 ( .A(\intadd_6/SUM[1] ), .Y(n292) );
  AOI22XLM U304 ( .A0(\intadd_6/SUM[1] ), .A1(n291), .B0(\intadd_7/n1 ), .B1(
        n292), .Y(n225) );
  OAI21XLM U305 ( .A0(n293), .A1(n225), .B0(n344), .Y(n224) );
  AOI21XLM U306 ( .A0(n293), .A1(n225), .B0(n224), .Y(n230) );
  OAI21XLM U307 ( .A0(n311), .A1(n319), .B0(n226), .Y(n227) );
  AOI22XLM U308 ( .A0(n311), .A1(n319), .B0(n228), .B1(n227), .Y(n229) );
  AOI211XLM U309 ( .A0(n231), .A1(n283), .B0(n230), .C0(n229), .Y(n238) );
  NAND2XLM U310 ( .A(n311), .B(n319), .Y(n232) );
  OAI22XLM U311 ( .A0(n343), .A1(n232), .B0(n368), .B1(n253), .Y(n235) );
  OAI2B2XLM U312 ( .A1N(n355), .A0(n283), .B0(n370), .B1(n233), .Y(n234) );
  AOI211XLM U313 ( .A0(n236), .A1(n353), .B0(n235), .C0(n234), .Y(n237) );
  OAI2B11XLM U314 ( .A1N(\C7M/DATA15_5 ), .A0(n19), .B0(n238), .C0(n237), .Y(
        N184) );
  NOR3XLM U315 ( .A(B[4]), .B(A[4]), .C(n343), .Y(n244) );
  NOR2XLM U316 ( .A(n310), .B(n368), .Y(n312) );
  AOI2BB2XLM U317 ( .B0(n344), .B1(\intadd_7/SUM[2] ), .A0N(n312), .A1N(n349), 
        .Y(n241) );
  AOI21XLM U318 ( .A0(B[4]), .A1(A[4]), .B0(n340), .Y(n239) );
  OAI22XLM U319 ( .A0(A[4]), .A1(B[4]), .B0(n346), .B1(n239), .Y(n240) );
  OAI211XLM U320 ( .A0(n266), .A1(n242), .B0(n241), .C0(n240), .Y(n243) );
  AOI211XLM U321 ( .A0(n345), .A1(A[3]), .B0(n244), .C0(n243), .Y(n246) );
  AOI22XLM U322 ( .A0(n355), .A1(n312), .B0(n354), .B1(A[5]), .Y(n245) );
  OAI2B11XLM U323 ( .A1N(\C7M/DATA15_4 ), .A0(n19), .B0(n246), .C0(n245), .Y(
        N183) );
  XNOR2XLM U324 ( .A(\DP_OP_29J1_122_2578/n9 ), .B(n247), .Y(n251) );
  AOI21XLM U325 ( .A0(\intadd_1/SUM[3] ), .A1(n344), .B0(n249), .Y(n250) );
  OAI211XLM U326 ( .A0(A[7]), .A1(n372), .B0(n252), .C0(n317), .Y(n265) );
  NAND2XLM U327 ( .A(n321), .B(n323), .Y(n262) );
  AOI2BB2XLM U328 ( .B0(n355), .B1(n256), .A0N(n262), .A1N(n343), .Y(n264) );
  OAI22XLM U329 ( .A0(n254), .A1(n340), .B0(n370), .B1(n253), .Y(n261) );
  INVXLM U330 ( .A(\intadd_6/n1 ), .Y(n290) );
  INVXLM U331 ( .A(\intadd_1/SUM[2] ), .Y(n289) );
  AOI22XLM U332 ( .A0(\intadd_1/SUM[2] ), .A1(\intadd_6/n1 ), .B0(n290), .B1(
        n289), .Y(n255) );
  AOI2BB2XLM U333 ( .B0(n287), .B1(n255), .A0N(n287), .A1N(n255), .Y(n257) );
  AOI2BB2XLM U334 ( .B0(n257), .B1(n344), .A0N(n256), .A1N(n349), .Y(n258) );
  OAI2BB1XLM U335 ( .A0N(n259), .A1N(\C7M/DATA15_7 ), .B0(n258), .Y(n260) );
  AOI211XLM U336 ( .A0(n346), .A1(n262), .B0(n261), .C0(n260), .Y(n263) );
  OAI211XLM U337 ( .A0(n266), .A1(n265), .B0(n264), .C0(n263), .Y(N186) );
  OAI21XLM U339 ( .A0(\intadd_2/SUM[2] ), .A1(\intadd_0/n1 ), .B0(
        \intadd_5/n1 ), .Y(n270) );
  OAI21XLM U340 ( .A0(n272), .A1(n271), .B0(n270), .Y(\intadd_2/A[3] ) );
  NOR2XLM U342 ( .A(n318), .B(n319), .Y(\intadd_2/B[1] ) );
  NOR2XLM U343 ( .A(n321), .B(n310), .Y(n278) );
  NOR2XLM U344 ( .A(n370), .B(n311), .Y(n277) );
  NOR2XLM U345 ( .A(n323), .B(n368), .Y(n276) );
  ADDFX1M U346 ( .A(n278), .B(n277), .CI(n276), .CO(\intadd_2/A[2] ), .S(
        \intadd_2/A[1] ) );
  NAND2XLM U347 ( .A(A[7]), .B(B[2]), .Y(n303) );
  NOR4XLM U348 ( .A(n321), .B(n370), .C(n362), .D(n317), .Y(n305) );
  AOI2B1XLM U349 ( .A1N(n303), .A0(n304), .B0(n305), .Y(n285) );
  NAND2XLM U350 ( .A(B[6]), .B(A[4]), .Y(n284) );
  INVXLM U351 ( .A(n279), .Y(\intadd_5/A[2] ) );
  OAI21XLM U352 ( .A0(\intadd_0/SUM[3] ), .A1(\intadd_1/n1 ), .B0(
        \intadd_3/n1 ), .Y(n280) );
  OAI21XLM U353 ( .A0(n282), .A1(n281), .B0(n280), .Y(\intadd_0/A[4] ) );
  ADDFX1M U354 ( .A(n285), .B(n284), .CI(n283), .CO(n279), .S(n286) );
  INVXLM U355 ( .A(n286), .Y(\intadd_5/B[1] ) );
  NOR2XLM U356 ( .A(n323), .B(n366), .Y(\intadd_2/CI ) );
  NOR2XLM U357 ( .A(n370), .B(n310), .Y(\intadd_2/B[0] ) );
  NOR2XLM U358 ( .A(n321), .B(n327), .Y(\intadd_2/A[0] ) );
  OAI21XLM U359 ( .A0(\intadd_1/SUM[2] ), .A1(\intadd_6/n1 ), .B0(n287), .Y(
        n288) );
  OAI21XLM U360 ( .A0(n290), .A1(n289), .B0(n288), .Y(\intadd_1/A[3] ) );
  NOR2XLM U361 ( .A(n310), .B(n358), .Y(\intadd_1/B[1] ) );
  AOI222XLM U362 ( .A0(n293), .A1(n292), .B0(n293), .B1(n291), .C0(n292), .C1(
        n291), .Y(\intadd_6/A[2] ) );
  INVXLM U364 ( .A(n297), .Y(\intadd_7/B[2] ) );
  NOR2XLM U365 ( .A(n310), .B(n364), .Y(\intadd_6/CI ) );
  NOR4XLM U366 ( .A(n319), .B(n368), .C(n317), .D(n372), .Y(\intadd_4/A[0] )
         );
  NOR2XLM U367 ( .A(n366), .B(n362), .Y(n301) );
  NAND2XLM U368 ( .A(A[4]), .B(B[1]), .Y(n298) );
  AOI221XLM U369 ( .A0(n372), .A1(n298), .B0(n319), .B1(n298), .C0(
        \intadd_4/A[0] ), .Y(n300) );
  NOR2XLM U370 ( .A(n311), .B(n364), .Y(n299) );
  ADDFX1M U371 ( .A(n301), .B(n300), .CI(n299), .CO(\intadd_1/A[1] ), .S(
        \intadd_6/B[1] ) );
  NOR2XLM U372 ( .A(n327), .B(n358), .Y(\intadd_1/CI ) );
  NOR2XLM U373 ( .A(n310), .B(n360), .Y(\intadd_1/B[0] ) );
  OAI21XLM U374 ( .A0(n305), .A1(n303), .B0(n304), .Y(n302) );
  NOR2XLM U375 ( .A(n318), .B(n366), .Y(\intadd_5/CI ) );
  NOR2XLM U376 ( .A(n319), .B(n310), .Y(\intadd_5/B[0] ) );
  NOR2XLM U377 ( .A(n370), .B(n327), .Y(\intadd_5/A[0] ) );
  NOR2XLM U378 ( .A(n319), .B(n327), .Y(n314) );
  NAND2XLM U379 ( .A(A[6]), .B(B[2]), .Y(n306) );
  AOI221XLM U380 ( .A0(n317), .A1(n306), .B0(n321), .B1(n306), .C0(n305), .Y(
        n313) );
  NOR4XLM U381 ( .A(n321), .B(n370), .C(n317), .D(n372), .Y(n320) );
  NOR2XLM U382 ( .A(n323), .B(n360), .Y(n316) );
  NOR2XLM U383 ( .A(n311), .B(n366), .Y(n315) );
  NOR2XLM U384 ( .A(n311), .B(n368), .Y(n307) );
  ADDFX1M U385 ( .A(n309), .B(n308), .CI(n307), .CO(\intadd_0/A[3] ), .S(
        \intadd_3/A[3] ) );
  NOR2XLM U386 ( .A(n311), .B(n360), .Y(\intadd_4/B[0] ) );
  NOR2XLM U387 ( .A(n318), .B(n364), .Y(\intadd_3/CI ) );
  NOR2XLM U388 ( .A(n368), .B(n362), .Y(\intadd_3/A[0] ) );
  NOR2XLM U389 ( .A(n310), .B(n366), .Y(\intadd_3/B[1] ) );
  NOR2XLM U390 ( .A(n311), .B(n358), .Y(\intadd_3/A[1] ) );
  ADDFX1M U391 ( .A(n314), .B(n313), .CI(n312), .CO(n309), .S(\intadd_3/B[2] )
         );
  NOR2XLM U393 ( .A(n368), .B(n327), .Y(\intadd_0/CI ) );
  NOR2XLM U394 ( .A(n318), .B(n360), .Y(\intadd_0/B[0] ) );
  NOR4XLM U395 ( .A(n370), .B(n319), .C(n317), .D(n372), .Y(\intadd_0/A[0] )
         );
  NOR2XLM U396 ( .A(n318), .B(n358), .Y(\intadd_0/B[1] ) );
  NOR2XLM U397 ( .A(n319), .B(n362), .Y(n326) );
  NAND2XLM U398 ( .A(A[6]), .B(B[1]), .Y(n322) );
  AOI221XLM U399 ( .A0(n372), .A1(n322), .B0(n321), .B1(n322), .C0(n320), .Y(
        n325) );
  NOR2XLM U400 ( .A(n323), .B(n364), .Y(n324) );
  ADDFX1M U401 ( .A(n326), .B(n325), .CI(n324), .CO(\intadd_0/A[1] ), .S(
        \intadd_4/B[1] ) );
  NOR2XLM U402 ( .A(n327), .B(n366), .Y(\intadd_4/CI ) );
  NAND2XLM U403 ( .A(n327), .B(n366), .Y(n329) );
  OAI22XLM U404 ( .A0(n343), .A1(n329), .B0(n328), .B1(n340), .Y(n333) );
  AOI22XLM U405 ( .A0(A[2]), .A1(n345), .B0(n344), .B1(\intadd_7/SUM[1] ), .Y(
        n331) );
  OAI21XLM U406 ( .A0(B[3]), .A1(A[3]), .B0(n346), .Y(n330) );
  OAI211XLM U407 ( .A0(\intadd_4/CI ), .A1(n349), .B0(n331), .C0(n330), .Y(
        n332) );
  AOI211XLM U408 ( .A0(n353), .A1(n334), .B0(n333), .C0(n332), .Y(n336) );
  AOI22XLM U409 ( .A0(n355), .A1(\intadd_4/CI ), .B0(n354), .B1(A[4]), .Y(n335) );
  OAI2B11XLM U410 ( .A1N(\C7M/DATA15_3 ), .A0(n19), .B0(n336), .C0(n335), .Y(
        N182) );
  OAI21XLM U411 ( .A0(n361), .A1(n338), .B0(n339), .Y(n337) );
  OAI31XLM U412 ( .A0(n361), .A1(n339), .A2(n338), .B0(n337), .Y(
        \intadd_7/B[1] ) );
  NOR2XLM U413 ( .A(n362), .B(n358), .Y(\intadd_6/A[0] ) );
  NAND2XLM U414 ( .A(n362), .B(n358), .Y(n342) );
  OAI22XLM U415 ( .A0(n343), .A1(n342), .B0(n341), .B1(n340), .Y(n351) );
  AOI22XLM U416 ( .A0(A[1]), .A1(n345), .B0(n344), .B1(\intadd_7/SUM[0] ), .Y(
        n348) );
  OAI21XLM U417 ( .A0(B[2]), .A1(A[2]), .B0(n346), .Y(n347) );
  OAI211XLM U418 ( .A0(\intadd_6/A[0] ), .A1(n349), .B0(n348), .C0(n347), .Y(
        n350) );
  AOI211XLM U419 ( .A0(n353), .A1(n352), .B0(n351), .C0(n350), .Y(n357) );
  AOI22XLM U420 ( .A0(n355), .A1(\intadd_6/A[0] ), .B0(A[3]), .B1(n354), .Y(
        n356) );
  OAI2B11XLM U421 ( .A1N(\C7M/DATA15_2 ), .A0(n19), .B0(n357), .C0(n356), .Y(
        N181) );
  NOR2XLM U422 ( .A(n358), .B(n372), .Y(\intadd_7/CI ) );
  NOR3XLM U423 ( .A(n360), .B(n372), .C(n359), .Y(\intadd_7/A[0] ) );
  XOR2XLM U424 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[2]), .Y(
        \DP_OP_29J1_122_2578/n27 ) );
  XOR2XLM U425 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[1]), .Y(
        \DP_OP_29J1_122_2578/n28 ) );
  XOR2XLM U426 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[4]), .Y(
        \DP_OP_29J1_122_2578/n25 ) );
  XOR2XLM U427 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[3]), .Y(
        \DP_OP_29J1_122_2578/n26 ) );
  XOR2XLM U428 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[0]), .Y(
        \DP_OP_29J1_122_2578/n29 ) );
  XOR2XLM U429 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[7]), .Y(
        \DP_OP_29J1_122_2578/n22 ) );
  XOR2XLM U430 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[6]), .Y(
        \DP_OP_29J1_122_2578/n23 ) );
  XOR2XLM U431 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[5]), .Y(
        \DP_OP_29J1_122_2578/n24 ) );
  AOI221XLM U432 ( .A0(n364), .A1(n363), .B0(n362), .B1(n363), .C0(n361), .Y(
        \intadd_7/B[0] ) );
  NAND2XLM U433 ( .A(A[2]), .B(B[1]), .Y(n367) );
  AOI221XLM U434 ( .A0(n372), .A1(n367), .B0(n366), .B1(n367), .C0(n365), .Y(
        \intadd_7/A[1] ) );
  NAND2XLM U435 ( .A(A[3]), .B(B[1]), .Y(n369) );
  AOI221XLM U436 ( .A0(n372), .A1(n369), .B0(n368), .B1(n369), .C0(
        \intadd_1/A[0] ), .Y(\intadd_6/B[0] ) );
  NAND2XLM U437 ( .A(A[5]), .B(B[1]), .Y(n371) );
  AOI221XLM U438 ( .A0(n372), .A1(n371), .B0(n370), .B1(n371), .C0(
        \intadd_0/A[0] ), .Y(\intadd_3/B[0] ) );
  ADDFX1M U439 ( .A(\intadd_3/SUM[0] ), .B(\intadd_1/SUM[1] ), .CI(
        \intadd_4/SUM[0] ), .CO(n287), .S(\intadd_6/B[2] ) );
  ADDFXLM \intadd_2/U2  ( .A(\intadd_2/A[3] ), .B(\intadd_2/B[3] ), .CI(
        \intadd_2/n2 ), .CO(\intadd_2/n1 ), .S(\intadd_2/SUM[3] ) );
  ADDFXLM \DP_OP_29J1_122_2578/U16  ( .A(\DP_OP_29J1_122_2578/n24 ), .B(A[5]), 
        .CI(\DP_OP_29J1_122_2578/n12 ), .CO(\DP_OP_29J1_122_2578/n11 ), .S(
        \C7M/DATA15_5 ) );
  ADDFXLM \DP_OP_29J1_122_2578/U19  ( .A(\DP_OP_29J1_122_2578/n27 ), .B(A[2]), 
        .CI(\DP_OP_29J1_122_2578/n15 ), .CO(\DP_OP_29J1_122_2578/n14 ), .S(
        \C7M/DATA15_2 ) );
  ADDFXLM \intadd_1/U3  ( .A(\intadd_1/A[3] ), .B(\intadd_1/B[3] ), .CI(
        \intadd_1/n3 ), .CO(\intadd_1/n2 ), .S(\intadd_1/SUM[3] ) );
  ADDFXLM \DP_OP_29J1_122_2578/U15  ( .A(\DP_OP_29J1_122_2578/n23 ), .B(A[6]), 
        .CI(\DP_OP_29J1_122_2578/n11 ), .CO(\DP_OP_29J1_122_2578/n10 ), .S(
        \C7M/DATA15_6 ) );
  ADDFXLM \DP_OP_29J1_122_2578/U20  ( .A(\DP_OP_29J1_122_2578/n28 ), .B(A[1]), 
        .CI(\DP_OP_29J1_122_2578/n16 ), .CO(\DP_OP_29J1_122_2578/n15 ), .S(
        \C7M/DATA15_1 ) );
  ADDFXLM \intadd_1/U4  ( .A(\intadd_1/A[2] ), .B(\intadd_1/B[2] ), .CI(
        \intadd_1/n4 ), .CO(\intadd_1/n3 ), .S(\intadd_1/SUM[2] ) );
  ADDFXLM \intadd_6/U3  ( .A(\intadd_1/SUM[0] ), .B(\intadd_6/B[1] ), .CI(
        \intadd_6/n3 ), .CO(\intadd_6/n2 ), .S(\intadd_6/SUM[1] ) );
  ADDFXLM \DP_OP_29J1_122_2578/U21  ( .A(A[0]), .B(\DP_OP_29J1_122_2578/n43 ), 
        .CI(\DP_OP_29J1_122_2578/n29 ), .CO(\DP_OP_29J1_122_2578/n16 ), .S(
        \C7M/DATA15_0 ) );
  ADDFXLM \intadd_1/U6  ( .A(\intadd_1/A[0] ), .B(\intadd_1/B[0] ), .CI(
        \intadd_1/CI ), .CO(\intadd_1/n5 ), .S(\intadd_1/SUM[0] ) );
  ADDFXLM \intadd_7/U3  ( .A(\intadd_7/A[1] ), .B(\intadd_7/B[1] ), .CI(
        \intadd_7/n3 ), .CO(\intadd_7/n2 ), .S(\intadd_7/SUM[1] ) );
  ADDFXLM \intadd_7/U4  ( .A(\intadd_7/A[0] ), .B(\intadd_7/B[0] ), .CI(
        \intadd_7/CI ), .CO(\intadd_7/n3 ), .S(\intadd_7/SUM[0] ) );
  ADDFXLM \intadd_0/U6  ( .A(\intadd_0/A[0] ), .B(\intadd_0/B[0] ), .CI(
        \intadd_0/CI ), .CO(\intadd_0/n5 ), .S(\intadd_0/SUM[0] ) );
  INVXLM U167 ( .A(n334), .Y(n85) );
  ADDFXLM U171 ( .A(B[2]), .B(n77), .CI(n76), .CO(n73), .S(n78) );
  ADDFXLM U338 ( .A(n320), .B(n316), .CI(n315), .CO(n308), .S(\intadd_3/A[2] )
         );
  ADDFXLM U341 ( .A(n296), .B(n295), .CI(n294), .CO(n293), .S(n297) );
  ADDFXLM U363 ( .A(n275), .B(n274), .CI(n273), .CO(n269), .S(\intadd_2/B[2] )
         );
  ADDFXLM U392 ( .A(n269), .B(n268), .CI(n267), .CO(n10), .S(\intadd_2/B[3] )
         );
endmodule


module register_file_test_1 ( clk, reset, address, write_enable, write_data, 
        read_enable, read_data, read_data_valid, register0, register1, 
        register2, register3, test_si2, test_si1, test_so1, test_se );
  input [3:0] address;
  input [7:0] write_data;
  output [7:0] read_data;
  output [7:0] register0;
  output [7:0] register1;
  output [7:0] register2;
  output [7:0] register3;
  input clk, reset, write_enable, read_enable, test_si2, test_si1, test_se;
  output read_data_valid, test_so1;
  wire   n154, n155, n156, n157, n158, n159, n160, n161, \memory[4][7] ,
         \memory[4][6] , \memory[4][5] , \memory[4][4] , \memory[4][3] ,
         \memory[4][2] , \memory[4][1] , \memory[4][0] , \memory[5][7] ,
         \memory[5][6] , \memory[5][5] , \memory[5][4] , \memory[5][3] ,
         \memory[5][2] , \memory[5][1] , \memory[5][0] , \memory[6][7] ,
         \memory[6][6] , \memory[6][5] , \memory[6][4] , \memory[6][3] ,
         \memory[6][2] , \memory[6][1] , \memory[6][0] , \memory[7][7] ,
         \memory[7][6] , \memory[7][5] , \memory[7][4] , \memory[7][3] ,
         \memory[7][2] , \memory[7][1] , \memory[7][0] , \memory[8][7] ,
         \memory[8][6] , \memory[8][5] , \memory[8][4] , \memory[8][3] ,
         \memory[8][2] , \memory[8][1] , \memory[8][0] , \memory[9][7] ,
         \memory[9][6] , \memory[9][5] , \memory[9][4] , \memory[9][3] ,
         \memory[9][2] , \memory[9][1] , \memory[9][0] , \memory[10][7] ,
         \memory[10][6] , \memory[10][5] , \memory[10][4] , \memory[10][3] ,
         \memory[10][2] , \memory[10][1] , \memory[10][0] , \memory[11][7] ,
         \memory[11][6] , \memory[11][5] , \memory[11][4] , \memory[11][3] ,
         \memory[11][2] , \memory[11][1] , \memory[11][0] , \memory[12][7] ,
         \memory[12][6] , \memory[12][5] , \memory[12][4] , \memory[12][3] ,
         \memory[12][2] , \memory[12][1] , \memory[12][0] , \memory[13][7] ,
         \memory[13][6] , \memory[13][5] , \memory[13][4] , \memory[13][3] ,
         \memory[13][2] , \memory[13][1] , \memory[13][0] , \memory[14][7] ,
         \memory[14][6] , \memory[14][5] , \memory[14][4] , \memory[14][3] ,
         \memory[14][2] , \memory[14][1] , \memory[14][0] , \memory[15][7] ,
         \memory[15][6] , \memory[15][5] , \memory[15][4] , \memory[15][3] ,
         \memory[15][2] , \memory[15][1] , \memory[15][0] , N61, n288, n289,
         n290, n291, n292, n293, n294, n295, n296, n297, n298, n299, n300,
         n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, n311,
         n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322,
         n323, n324, n325, n326, n327, n328, n329, n330, n331, n332, n333,
         n334, n335, n336, n337, n338, n339, n340, n341, n342, n343, n344,
         n345, n346, n347, n348, n349, n350, n351, n352, n353, n354, n355,
         n356, n357, n358, n359, n360, n361, n362, n363, n364, n365, n366,
         n367, n368, n369, n370, n371, n372, n373, n374, n375, n376, n377,
         n378, n379, n380, n381, n382, n383, n384, n385, n386, n387, n388,
         n389, n390, n391, n392, n393, n394, n395, n396, n397, n398, n399,
         n400, n401, n402, n403, n404, n405, n406, n407, n408, n409, n410,
         n411, n412, n413, n414, n415, n416, n417, n418, n419, n420, n421,
         n422, n423, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55,
         n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69,
         n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83,
         n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97,
         n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109,
         n110, n111, n112, n113, n114, n115, n116, n117, n118, n119, n120,
         n121, n122, n123, n124, n125, n126, n127, n128, n129, n130, n131,
         n132, n133, n134, n135, n136, n137, n138, n139, n140, n141, n142,
         n143, n144, n145, n146, n147, n148, n149, n150, n152, n153;
  assign test_so1 = \memory[10][1] ;

  SDFFRQX1M \memory_reg[0][7]  ( .D(n423), .SI(register0[6]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(register0[7]) );
  SDFFRQX1M \memory_reg[0][6]  ( .D(n422), .SI(register0[5]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(register0[6]) );
  SDFFRQX1M \memory_reg[0][5]  ( .D(n421), .SI(register0[4]), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(register0[5]) );
  SDFFRQX1M \memory_reg[0][4]  ( .D(n420), .SI(register0[3]), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(register0[4]) );
  SDFFRQX1M \memory_reg[0][3]  ( .D(n419), .SI(register0[2]), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(register0[3]) );
  SDFFRQX1M \memory_reg[0][2]  ( .D(n418), .SI(register0[1]), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(register0[2]) );
  SDFFRQX1M \memory_reg[0][1]  ( .D(n417), .SI(register0[0]), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(register0[1]) );
  SDFFRQX1M \memory_reg[0][0]  ( .D(n416), .SI(test_si1), .SE(test_se), .CK(
        clk), .RN(n149), .Q(register0[0]) );
  SDFFRQX1M \memory_reg[1][7]  ( .D(n415), .SI(register1[6]), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(register1[7]) );
  SDFFRQX1M \memory_reg[1][6]  ( .D(n414), .SI(register1[5]), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(register1[6]) );
  SDFFRQX1M \memory_reg[1][5]  ( .D(n413), .SI(register1[4]), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(register1[5]) );
  SDFFRQX1M \memory_reg[1][4]  ( .D(n412), .SI(register1[3]), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(register1[4]) );
  SDFFRQX1M \memory_reg[1][3]  ( .D(n411), .SI(register1[2]), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(register1[3]) );
  SDFFRQX1M \memory_reg[1][2]  ( .D(n410), .SI(register1[1]), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(register1[2]) );
  SDFFRQX1M \memory_reg[1][1]  ( .D(n409), .SI(register1[0]), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(register1[1]) );
  SDFFRQX1M \memory_reg[1][0]  ( .D(n408), .SI(register0[7]), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(register1[0]) );
  SDFFRQX1M \memory_reg[2][7]  ( .D(n407), .SI(n155), .SE(test_se), .CK(clk), 
        .RN(n152), .Q(n154) );
  SDFFRQX1M \memory_reg[2][6]  ( .D(n406), .SI(n156), .SE(test_se), .CK(clk), 
        .RN(n153), .Q(n155) );
  SDFFRQX1M \memory_reg[2][5]  ( .D(n405), .SI(n157), .SE(test_se), .CK(clk), 
        .RN(n152), .Q(n156) );
  SDFFRQX1M \memory_reg[2][4]  ( .D(n404), .SI(n158), .SE(test_se), .CK(clk), 
        .RN(n153), .Q(n157) );
  SDFFRQX1M \memory_reg[2][3]  ( .D(n403), .SI(n159), .SE(test_se), .CK(clk), 
        .RN(n152), .Q(n158) );
  SDFFRQX1M \memory_reg[2][2]  ( .D(n402), .SI(register2[1]), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(n159) );
  SDFFRQX1M \memory_reg[2][1]  ( .D(n401), .SI(register2[0]), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(register2[1]) );
  SDFFRQX1M \memory_reg[3][7]  ( .D(n399), .SI(n161), .SE(test_se), .CK(clk), 
        .RN(n153), .Q(n160) );
  SDFFRQX1M \memory_reg[3][6]  ( .D(n398), .SI(register3[5]), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(n161) );
  SDFFRQX1M \memory_reg[3][5]  ( .D(n397), .SI(register3[4]), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(register3[5]) );
  SDFFRQX1M \memory_reg[3][4]  ( .D(n396), .SI(register3[3]), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(register3[4]) );
  SDFFRQX1M \memory_reg[3][2]  ( .D(n394), .SI(register3[1]), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(register3[2]) );
  SDFFRQX1M \memory_reg[3][1]  ( .D(n393), .SI(register3[0]), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(register3[1]) );
  SDFFRQX1M \memory_reg[3][0]  ( .D(n392), .SI(n154), .SE(test_se), .CK(clk), 
        .RN(n153), .Q(register3[0]) );
  SDFFRQX1M \memory_reg[4][7]  ( .D(n391), .SI(\memory[4][6] ), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(\memory[4][7] ) );
  SDFFRQX1M \memory_reg[4][6]  ( .D(n390), .SI(\memory[4][5] ), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(\memory[4][6] ) );
  SDFFRQX1M \memory_reg[4][5]  ( .D(n389), .SI(\memory[4][4] ), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(\memory[4][5] ) );
  SDFFRQX1M \memory_reg[4][4]  ( .D(n388), .SI(\memory[4][3] ), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(\memory[4][4] ) );
  SDFFRQX1M \memory_reg[4][3]  ( .D(n387), .SI(\memory[4][2] ), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(\memory[4][3] ) );
  SDFFRQX1M \memory_reg[4][2]  ( .D(n386), .SI(\memory[4][1] ), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(\memory[4][2] ) );
  SDFFRQX1M \memory_reg[4][1]  ( .D(n385), .SI(\memory[4][0] ), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(\memory[4][1] ) );
  SDFFRQX1M \memory_reg[4][0]  ( .D(n384), .SI(n160), .SE(test_se), .CK(clk), 
        .RN(n148), .Q(\memory[4][0] ) );
  SDFFRQX1M \memory_reg[5][7]  ( .D(n383), .SI(\memory[5][6] ), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(\memory[5][7] ) );
  SDFFRQX1M \memory_reg[5][6]  ( .D(n382), .SI(\memory[5][5] ), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(\memory[5][6] ) );
  SDFFRQX1M \memory_reg[5][5]  ( .D(n381), .SI(\memory[5][4] ), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(\memory[5][5] ) );
  SDFFRQX1M \memory_reg[5][4]  ( .D(n380), .SI(\memory[5][3] ), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(\memory[5][4] ) );
  SDFFRQX1M \memory_reg[5][3]  ( .D(n379), .SI(\memory[5][2] ), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(\memory[5][3] ) );
  SDFFRQX1M \memory_reg[5][2]  ( .D(n378), .SI(\memory[5][1] ), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(\memory[5][2] ) );
  SDFFRQX1M \memory_reg[5][1]  ( .D(n377), .SI(\memory[5][0] ), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(\memory[5][1] ) );
  SDFFRQX1M \memory_reg[5][0]  ( .D(n376), .SI(\memory[4][7] ), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(\memory[5][0] ) );
  SDFFRQX1M \memory_reg[6][7]  ( .D(n375), .SI(\memory[6][6] ), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(\memory[6][7] ) );
  SDFFRQX1M \memory_reg[6][6]  ( .D(n374), .SI(\memory[6][5] ), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(\memory[6][6] ) );
  SDFFRQX1M \memory_reg[6][5]  ( .D(n373), .SI(\memory[6][4] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[6][5] ) );
  SDFFRQX1M \memory_reg[6][4]  ( .D(n372), .SI(\memory[6][3] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[6][4] ) );
  SDFFRQX1M \memory_reg[6][3]  ( .D(n371), .SI(\memory[6][2] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[6][3] ) );
  SDFFRQX1M \memory_reg[6][2]  ( .D(n370), .SI(\memory[6][1] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[6][2] ) );
  SDFFRQX1M \memory_reg[6][1]  ( .D(n369), .SI(\memory[6][0] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[6][1] ) );
  SDFFRQX1M \memory_reg[6][0]  ( .D(n368), .SI(\memory[5][7] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[6][0] ) );
  SDFFRQX1M \memory_reg[7][7]  ( .D(n367), .SI(\memory[7][6] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[7][7] ) );
  SDFFRQX1M \memory_reg[7][6]  ( .D(n366), .SI(\memory[7][5] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[7][6] ) );
  SDFFRQX1M \memory_reg[7][5]  ( .D(n365), .SI(\memory[7][4] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[7][5] ) );
  SDFFRQX1M \memory_reg[7][4]  ( .D(n364), .SI(\memory[7][3] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[7][4] ) );
  SDFFRQX1M \memory_reg[7][3]  ( .D(n363), .SI(\memory[7][2] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[7][3] ) );
  SDFFRQX1M \memory_reg[7][2]  ( .D(n362), .SI(\memory[7][1] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[7][2] ) );
  SDFFRQX1M \memory_reg[7][1]  ( .D(n361), .SI(\memory[7][0] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[7][1] ) );
  SDFFRQX1M \memory_reg[7][0]  ( .D(n360), .SI(\memory[6][7] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[7][0] ) );
  SDFFRQX1M \memory_reg[8][7]  ( .D(n359), .SI(\memory[8][6] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[8][7] ) );
  SDFFRQX1M \memory_reg[8][6]  ( .D(n358), .SI(\memory[8][5] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[8][6] ) );
  SDFFRQX1M \memory_reg[8][5]  ( .D(n357), .SI(\memory[8][4] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[8][5] ) );
  SDFFRQX1M \memory_reg[8][4]  ( .D(n356), .SI(\memory[8][3] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[8][4] ) );
  SDFFRQX1M \memory_reg[8][3]  ( .D(n355), .SI(\memory[8][2] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[8][3] ) );
  SDFFRQX1M \memory_reg[8][2]  ( .D(n354), .SI(\memory[8][1] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[8][2] ) );
  SDFFRQX1M \memory_reg[8][1]  ( .D(n353), .SI(\memory[8][0] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[8][1] ) );
  SDFFRQX1M \memory_reg[8][0]  ( .D(n352), .SI(\memory[7][7] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[8][0] ) );
  SDFFRQX1M \memory_reg[9][7]  ( .D(n351), .SI(\memory[9][6] ), .SE(test_se), 
        .CK(clk), .RN(n153), .Q(\memory[9][7] ) );
  SDFFRQX1M \memory_reg[9][6]  ( .D(n350), .SI(\memory[9][5] ), .SE(test_se), 
        .CK(clk), .RN(n148), .Q(\memory[9][6] ) );
  SDFFRQX1M \memory_reg[9][5]  ( .D(n349), .SI(\memory[9][4] ), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(\memory[9][5] ) );
  SDFFRQX1M \memory_reg[9][4]  ( .D(n348), .SI(\memory[9][3] ), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(\memory[9][4] ) );
  SDFFRQX1M \memory_reg[9][3]  ( .D(n347), .SI(\memory[9][2] ), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(\memory[9][3] ) );
  SDFFRQX1M \memory_reg[9][2]  ( .D(n346), .SI(\memory[9][1] ), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(\memory[9][2] ) );
  SDFFRQX1M \memory_reg[9][1]  ( .D(n345), .SI(\memory[9][0] ), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(\memory[9][1] ) );
  SDFFRQX1M \memory_reg[9][0]  ( .D(n344), .SI(\memory[8][7] ), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(\memory[9][0] ) );
  SDFFRQX1M \memory_reg[10][7]  ( .D(n343), .SI(\memory[10][6] ), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(\memory[10][7] ) );
  SDFFRQX1M \memory_reg[10][6]  ( .D(n342), .SI(\memory[10][5] ), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(\memory[10][6] ) );
  SDFFRQX1M \memory_reg[10][5]  ( .D(n341), .SI(\memory[10][4] ), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(\memory[10][5] ) );
  SDFFRQX1M \memory_reg[10][4]  ( .D(n340), .SI(\memory[10][3] ), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(\memory[10][4] ) );
  SDFFRQX1M \memory_reg[10][3]  ( .D(n339), .SI(\memory[10][2] ), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(\memory[10][3] ) );
  SDFFRQX1M \memory_reg[10][2]  ( .D(n338), .SI(test_si2), .SE(test_se), .CK(
        clk), .RN(n149), .Q(\memory[10][2] ) );
  SDFFRQX1M \memory_reg[10][1]  ( .D(n337), .SI(\memory[10][0] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[10][1] ) );
  SDFFRQX1M \memory_reg[10][0]  ( .D(n336), .SI(\memory[9][7] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[10][0] ) );
  SDFFRQX1M \memory_reg[11][7]  ( .D(n335), .SI(\memory[11][6] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[11][7] ) );
  SDFFRQX1M \memory_reg[11][6]  ( .D(n334), .SI(\memory[11][5] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[11][6] ) );
  SDFFRQX1M \memory_reg[11][5]  ( .D(n333), .SI(\memory[11][4] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[11][5] ) );
  SDFFRQX1M \memory_reg[11][4]  ( .D(n332), .SI(\memory[11][3] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[11][4] ) );
  SDFFRQX1M \memory_reg[11][3]  ( .D(n331), .SI(\memory[11][2] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[11][3] ) );
  SDFFRQX1M \memory_reg[11][2]  ( .D(n330), .SI(\memory[11][1] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[11][2] ) );
  SDFFRQX1M \memory_reg[11][1]  ( .D(n329), .SI(\memory[11][0] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[11][1] ) );
  SDFFRQX1M \memory_reg[11][0]  ( .D(n328), .SI(\memory[10][7] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[11][0] ) );
  SDFFRQX1M \memory_reg[12][7]  ( .D(n327), .SI(\memory[12][6] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[12][7] ) );
  SDFFRQX1M \memory_reg[12][6]  ( .D(n326), .SI(\memory[12][5] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[12][6] ) );
  SDFFRQX1M \memory_reg[12][5]  ( .D(n325), .SI(\memory[12][4] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[12][5] ) );
  SDFFRQX1M \memory_reg[12][4]  ( .D(n324), .SI(\memory[12][3] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[12][4] ) );
  SDFFRQX1M \memory_reg[12][3]  ( .D(n323), .SI(\memory[12][2] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[12][3] ) );
  SDFFRQX1M \memory_reg[12][2]  ( .D(n322), .SI(\memory[12][1] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[12][2] ) );
  SDFFRQX1M \memory_reg[12][1]  ( .D(n321), .SI(\memory[12][0] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[12][1] ) );
  SDFFRQX1M \memory_reg[12][0]  ( .D(n320), .SI(\memory[11][7] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[12][0] ) );
  SDFFRQX1M \memory_reg[13][7]  ( .D(n319), .SI(\memory[13][6] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[13][7] ) );
  SDFFRQX1M \memory_reg[13][6]  ( .D(n318), .SI(\memory[13][5] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[13][6] ) );
  SDFFRQX1M \memory_reg[13][5]  ( .D(n317), .SI(\memory[13][4] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[13][5] ) );
  SDFFRQX1M \memory_reg[13][4]  ( .D(n316), .SI(\memory[13][3] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[13][4] ) );
  SDFFRQX1M \memory_reg[13][3]  ( .D(n315), .SI(\memory[13][2] ), .SE(test_se), 
        .CK(clk), .RN(n152), .Q(\memory[13][3] ) );
  SDFFRQX1M \memory_reg[13][2]  ( .D(n314), .SI(\memory[13][1] ), .SE(test_se), 
        .CK(clk), .RN(n149), .Q(\memory[13][2] ) );
  SDFFRQX1M \memory_reg[13][1]  ( .D(n313), .SI(\memory[13][0] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[13][1] ) );
  SDFFRQX1M \memory_reg[13][0]  ( .D(n312), .SI(\memory[12][7] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[13][0] ) );
  SDFFRQX1M \memory_reg[14][7]  ( .D(n311), .SI(\memory[14][6] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[14][7] ) );
  SDFFRQX1M \memory_reg[14][6]  ( .D(n310), .SI(\memory[14][5] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[14][6] ) );
  SDFFRQX1M \memory_reg[14][5]  ( .D(n309), .SI(\memory[14][4] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[14][5] ) );
  SDFFRQX1M \memory_reg[14][4]  ( .D(n308), .SI(\memory[14][3] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[14][4] ) );
  SDFFRQX1M \memory_reg[14][3]  ( .D(n307), .SI(\memory[14][2] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[14][3] ) );
  SDFFRQX1M \memory_reg[14][2]  ( .D(n306), .SI(\memory[14][1] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[14][2] ) );
  SDFFRQX1M \memory_reg[14][1]  ( .D(n305), .SI(\memory[14][0] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[14][1] ) );
  SDFFRQX1M \memory_reg[14][0]  ( .D(n304), .SI(\memory[13][7] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[14][0] ) );
  SDFFRQX1M \memory_reg[15][7]  ( .D(n303), .SI(\memory[15][6] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[15][7] ) );
  SDFFRQX1M \memory_reg[15][6]  ( .D(n302), .SI(\memory[15][5] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[15][6] ) );
  SDFFRQX1M \memory_reg[15][5]  ( .D(n301), .SI(\memory[15][4] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[15][5] ) );
  SDFFRQX1M \memory_reg[15][4]  ( .D(n300), .SI(\memory[15][3] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[15][4] ) );
  SDFFRQX1M \memory_reg[15][3]  ( .D(n299), .SI(\memory[15][2] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[15][3] ) );
  SDFFRQX1M \memory_reg[15][2]  ( .D(n298), .SI(\memory[15][1] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[15][2] ) );
  SDFFRQX1M \memory_reg[15][1]  ( .D(n297), .SI(\memory[15][0] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[15][1] ) );
  SDFFRQX1M \memory_reg[15][0]  ( .D(n296), .SI(\memory[14][7] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(\memory[15][0] ) );
  SDFFRQX1M \read_data_reg[7]  ( .D(n295), .SI(read_data[6]), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(read_data[7]) );
  SDFFRQX1M \read_data_reg[6]  ( .D(n294), .SI(read_data[5]), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(read_data[6]) );
  SDFFRQX1M \read_data_reg[5]  ( .D(n293), .SI(read_data[4]), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(read_data[5]) );
  SDFFRQX1M \read_data_reg[4]  ( .D(n292), .SI(read_data[3]), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(read_data[4]) );
  SDFFRQX1M \read_data_reg[3]  ( .D(n291), .SI(read_data[2]), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(read_data[3]) );
  SDFFRQX1M \read_data_reg[2]  ( .D(n290), .SI(read_data[1]), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(read_data[2]) );
  SDFFRQX1M \read_data_reg[1]  ( .D(n289), .SI(read_data[0]), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(read_data[1]) );
  SDFFRQX1M \read_data_reg[0]  ( .D(n288), .SI(\memory[15][7] ), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(read_data[0]) );
  SDFFRQX1M read_data_valid_reg ( .D(N61), .SI(read_data[7]), .SE(test_se), 
        .CK(clk), .RN(n150), .Q(read_data_valid) );
  INVXLM U3 ( .A(n113), .Y(n4) );
  NOR2XLM U4 ( .A(n126), .B(n127), .Y(n95) );
  AOI22XLM U5 ( .A0(n100), .A1(\memory[12][1] ), .B0(n99), .B1(\memory[13][1] ), .Y(n55) );
  AOI22XLM U6 ( .A0(n102), .A1(\memory[14][3] ), .B0(n101), .B1(
        \memory[15][3] ), .Y(n21) );
  AOI22XLM U7 ( .A0(n102), .A1(\memory[14][5] ), .B0(n101), .B1(
        \memory[15][5] ), .Y(n76) );
  AOI22XLM U8 ( .A0(n86), .A1(n155), .B0(n85), .B1(n161), .Y(n93) );
  NAND4XLM U9 ( .A(n64), .B(n63), .C(n62), .D(n61), .Y(n70) );
  NOR2XLM U10 ( .A(n138), .B(n137), .Y(n147) );
  INVXLM U11 ( .A(write_data[0]), .Y(n146) );
  INVXLM U12 ( .A(n38), .Y(n288) );
  CLKBUFX2M U13 ( .A(reset), .Y(n150) );
  CLKBUFX2M U14 ( .A(reset), .Y(n153) );
  CLKBUFX2M U15 ( .A(n153), .Y(n148) );
  CLKBUFX2M U16 ( .A(reset), .Y(n152) );
  CLKBUFX2M U17 ( .A(n152), .Y(n149) );
  NAND2BXLM U18 ( .AN(write_enable), .B(read_enable), .Y(n109) );
  INVXLM U19 ( .A(n109), .Y(N61) );
  INVXLM U20 ( .A(address[2]), .Y(n1) );
  INVXLM U21 ( .A(address[1]), .Y(n2) );
  NAND2XLM U22 ( .A(n1), .B(n2), .Y(n127) );
  NOR2XLM U23 ( .A(address[0]), .B(address[3]), .Y(n111) );
  INVXLM U24 ( .A(n111), .Y(n3) );
  NOR2XLM U25 ( .A(n127), .B(n3), .Y(n84) );
  INVXLM U26 ( .A(address[0]), .Y(n9) );
  NOR2XLM U27 ( .A(n9), .B(address[3]), .Y(n113) );
  NOR2XLM U28 ( .A(n127), .B(n4), .Y(n83) );
  AOI22XLM U29 ( .A0(n84), .A1(register0[2]), .B0(n83), .B1(register1[2]), .Y(
        n8) );
  NAND2XLM U30 ( .A(address[1]), .B(n1), .Y(n130) );
  NOR2XLM U31 ( .A(n130), .B(n3), .Y(n86) );
  NOR2XLM U32 ( .A(n130), .B(n4), .Y(n85) );
  AOI22XLM U33 ( .A0(n86), .A1(n159), .B0(n85), .B1(register3[2]), .Y(n7) );
  NAND2XLM U34 ( .A(address[2]), .B(n2), .Y(n133) );
  NOR2XLM U35 ( .A(n133), .B(n3), .Y(n88) );
  NOR2XLM U36 ( .A(n133), .B(n4), .Y(n87) );
  AOI22XLM U37 ( .A0(n88), .A1(\memory[4][2] ), .B0(n87), .B1(\memory[5][2] ), 
        .Y(n6) );
  NAND2XLM U38 ( .A(address[2]), .B(address[1]), .Y(n138) );
  NOR2XLM U39 ( .A(n138), .B(n3), .Y(n90) );
  NOR2XLM U40 ( .A(n138), .B(n4), .Y(n89) );
  AOI22XLM U41 ( .A0(n90), .A1(\memory[6][2] ), .B0(n89), .B1(\memory[7][2] ), 
        .Y(n5) );
  NAND4XLM U42 ( .A(n8), .B(n7), .C(n6), .D(n5), .Y(n15) );
  NAND2XLM U43 ( .A(address[3]), .B(n9), .Y(n123) );
  NOR2XLM U44 ( .A(n123), .B(n127), .Y(n96) );
  NAND2XLM U45 ( .A(address[0]), .B(address[3]), .Y(n126) );
  AOI22XLM U46 ( .A0(n96), .A1(\memory[8][2] ), .B0(n95), .B1(\memory[9][2] ), 
        .Y(n13) );
  NOR2XLM U47 ( .A(n123), .B(n130), .Y(n98) );
  NOR2XLM U48 ( .A(n130), .B(n126), .Y(n97) );
  AOI22XLM U49 ( .A0(n98), .A1(\memory[10][2] ), .B0(n97), .B1(\memory[11][2] ), .Y(n12) );
  NOR2XLM U50 ( .A(n123), .B(n133), .Y(n100) );
  NOR2XLM U51 ( .A(n126), .B(n133), .Y(n99) );
  AOI22XLM U52 ( .A0(n100), .A1(\memory[12][2] ), .B0(n99), .B1(
        \memory[13][2] ), .Y(n11) );
  NOR2XLM U53 ( .A(n123), .B(n138), .Y(n102) );
  NOR2XLM U54 ( .A(n126), .B(n138), .Y(n101) );
  AOI22XLM U55 ( .A0(n102), .A1(\memory[14][2] ), .B0(n101), .B1(
        \memory[15][2] ), .Y(n10) );
  NAND4XLM U56 ( .A(n13), .B(n12), .C(n11), .D(n10), .Y(n14) );
  OAI32XLM U57 ( .A0(n109), .A1(n15), .A2(n14), .B0(read_data[2]), .B1(N61), 
        .Y(n16) );
  INVXLM U58 ( .A(n16), .Y(n290) );
  AOI22XLM U59 ( .A0(n84), .A1(register0[3]), .B0(n83), .B1(register1[3]), .Y(
        n20) );
  AOI22XLM U60 ( .A0(n86), .A1(n158), .B0(n85), .B1(register3[3]), .Y(n19) );
  AOI22XLM U61 ( .A0(n88), .A1(\memory[4][3] ), .B0(n87), .B1(\memory[5][3] ), 
        .Y(n18) );
  AOI22XLM U62 ( .A0(n90), .A1(\memory[6][3] ), .B0(n89), .B1(\memory[7][3] ), 
        .Y(n17) );
  NAND4XLM U63 ( .A(n20), .B(n19), .C(n18), .D(n17), .Y(n26) );
  AOI22XLM U64 ( .A0(n96), .A1(\memory[8][3] ), .B0(n95), .B1(\memory[9][3] ), 
        .Y(n24) );
  AOI22XLM U65 ( .A0(n98), .A1(\memory[10][3] ), .B0(n97), .B1(\memory[11][3] ), .Y(n23) );
  AOI22XLM U66 ( .A0(n100), .A1(\memory[12][3] ), .B0(n99), .B1(
        \memory[13][3] ), .Y(n22) );
  NAND4XLM U67 ( .A(n24), .B(n23), .C(n22), .D(n21), .Y(n25) );
  OAI32XLM U68 ( .A0(n109), .A1(n26), .A2(n25), .B0(read_data[3]), .B1(N61), 
        .Y(n27) );
  INVXLM U69 ( .A(n27), .Y(n291) );
  AOI22XLM U70 ( .A0(n84), .A1(register0[0]), .B0(n83), .B1(register1[0]), .Y(
        n31) );
  AOI22XLM U71 ( .A0(n86), .A1(register2[0]), .B0(n85), .B1(register3[0]), .Y(
        n30) );
  AOI22XLM U72 ( .A0(n88), .A1(\memory[4][0] ), .B0(n87), .B1(\memory[5][0] ), 
        .Y(n29) );
  AOI22XLM U73 ( .A0(n90), .A1(\memory[6][0] ), .B0(n89), .B1(\memory[7][0] ), 
        .Y(n28) );
  NAND4XLM U74 ( .A(n31), .B(n30), .C(n29), .D(n28), .Y(n37) );
  AOI22XLM U75 ( .A0(n96), .A1(\memory[8][0] ), .B0(n95), .B1(\memory[9][0] ), 
        .Y(n35) );
  AOI22XLM U76 ( .A0(n98), .A1(\memory[10][0] ), .B0(n97), .B1(\memory[11][0] ), .Y(n34) );
  AOI22XLM U77 ( .A0(n100), .A1(\memory[12][0] ), .B0(n99), .B1(
        \memory[13][0] ), .Y(n33) );
  AOI22XLM U78 ( .A0(n102), .A1(\memory[14][0] ), .B0(n101), .B1(
        \memory[15][0] ), .Y(n32) );
  NAND4XLM U79 ( .A(n35), .B(n34), .C(n33), .D(n32), .Y(n36) );
  OAI32XLM U80 ( .A0(n109), .A1(n37), .A2(n36), .B0(read_data[0]), .B1(N61), 
        .Y(n38) );
  AOI22XLM U81 ( .A0(n84), .A1(register0[7]), .B0(n83), .B1(register1[7]), .Y(
        n42) );
  AOI22XLM U82 ( .A0(n86), .A1(n154), .B0(n85), .B1(n160), .Y(n41) );
  AOI22XLM U83 ( .A0(n88), .A1(\memory[4][7] ), .B0(n87), .B1(\memory[5][7] ), 
        .Y(n40) );
  AOI22XLM U84 ( .A0(n90), .A1(\memory[6][7] ), .B0(n89), .B1(\memory[7][7] ), 
        .Y(n39) );
  NAND4XLM U85 ( .A(n42), .B(n41), .C(n40), .D(n39), .Y(n48) );
  AOI22XLM U86 ( .A0(n96), .A1(\memory[8][7] ), .B0(n95), .B1(\memory[9][7] ), 
        .Y(n46) );
  AOI22XLM U87 ( .A0(n98), .A1(\memory[10][7] ), .B0(n97), .B1(\memory[11][7] ), .Y(n45) );
  AOI22XLM U88 ( .A0(n100), .A1(\memory[12][7] ), .B0(n99), .B1(
        \memory[13][7] ), .Y(n44) );
  AOI22XLM U89 ( .A0(n102), .A1(\memory[14][7] ), .B0(n101), .B1(
        \memory[15][7] ), .Y(n43) );
  NAND4XLM U90 ( .A(n46), .B(n45), .C(n44), .D(n43), .Y(n47) );
  OAI32XLM U91 ( .A0(n109), .A1(n48), .A2(n47), .B0(read_data[7]), .B1(N61), 
        .Y(n49) );
  INVXLM U92 ( .A(n49), .Y(n295) );
  AOI22XLM U93 ( .A0(n84), .A1(register0[1]), .B0(n83), .B1(register1[1]), .Y(
        n53) );
  AOI22XLM U94 ( .A0(n86), .A1(register2[1]), .B0(n85), .B1(register3[1]), .Y(
        n52) );
  AOI22XLM U95 ( .A0(n88), .A1(\memory[4][1] ), .B0(n87), .B1(\memory[5][1] ), 
        .Y(n51) );
  AOI22XLM U96 ( .A0(n90), .A1(\memory[6][1] ), .B0(n89), .B1(\memory[7][1] ), 
        .Y(n50) );
  NAND4XLM U97 ( .A(n53), .B(n52), .C(n51), .D(n50), .Y(n59) );
  AOI22XLM U98 ( .A0(n96), .A1(\memory[8][1] ), .B0(n95), .B1(\memory[9][1] ), 
        .Y(n57) );
  AOI22XLM U99 ( .A0(n98), .A1(\memory[10][1] ), .B0(n97), .B1(\memory[11][1] ), .Y(n56) );
  AOI22XLM U100 ( .A0(n102), .A1(\memory[14][1] ), .B0(n101), .B1(
        \memory[15][1] ), .Y(n54) );
  NAND4XLM U101 ( .A(n57), .B(n56), .C(n55), .D(n54), .Y(n58) );
  OAI32XLM U102 ( .A0(n109), .A1(n59), .A2(n58), .B0(read_data[1]), .B1(N61), 
        .Y(n60) );
  INVXLM U103 ( .A(n60), .Y(n289) );
  AOI22XLM U104 ( .A0(n84), .A1(register0[4]), .B0(n83), .B1(register1[4]), 
        .Y(n64) );
  AOI22XLM U105 ( .A0(n86), .A1(n157), .B0(n85), .B1(register3[4]), .Y(n63) );
  AOI22XLM U106 ( .A0(n88), .A1(\memory[4][4] ), .B0(n87), .B1(\memory[5][4] ), 
        .Y(n62) );
  AOI22XLM U107 ( .A0(n90), .A1(\memory[6][4] ), .B0(n89), .B1(\memory[7][4] ), 
        .Y(n61) );
  AOI22XLM U108 ( .A0(n96), .A1(\memory[8][4] ), .B0(n95), .B1(\memory[9][4] ), 
        .Y(n68) );
  AOI22XLM U109 ( .A0(n98), .A1(\memory[10][4] ), .B0(n97), .B1(
        \memory[11][4] ), .Y(n67) );
  AOI22XLM U110 ( .A0(n100), .A1(\memory[12][4] ), .B0(n99), .B1(
        \memory[13][4] ), .Y(n66) );
  AOI22XLM U111 ( .A0(n102), .A1(\memory[14][4] ), .B0(n101), .B1(
        \memory[15][4] ), .Y(n65) );
  NAND4XLM U112 ( .A(n68), .B(n67), .C(n66), .D(n65), .Y(n69) );
  OAI32XLM U113 ( .A0(n109), .A1(n70), .A2(n69), .B0(read_data[4]), .B1(N61), 
        .Y(n71) );
  INVXLM U114 ( .A(n71), .Y(n292) );
  AOI22XLM U115 ( .A0(n84), .A1(register0[5]), .B0(n83), .B1(register1[5]), 
        .Y(n75) );
  AOI22XLM U116 ( .A0(n86), .A1(n156), .B0(n85), .B1(register3[5]), .Y(n74) );
  AOI22XLM U117 ( .A0(n88), .A1(\memory[4][5] ), .B0(n87), .B1(\memory[5][5] ), 
        .Y(n73) );
  AOI22XLM U118 ( .A0(n90), .A1(\memory[6][5] ), .B0(n89), .B1(\memory[7][5] ), 
        .Y(n72) );
  NAND4XLM U119 ( .A(n75), .B(n74), .C(n73), .D(n72), .Y(n81) );
  AOI22XLM U120 ( .A0(n96), .A1(\memory[8][5] ), .B0(n95), .B1(\memory[9][5] ), 
        .Y(n79) );
  AOI22XLM U121 ( .A0(n98), .A1(\memory[10][5] ), .B0(n97), .B1(
        \memory[11][5] ), .Y(n78) );
  AOI22XLM U122 ( .A0(n100), .A1(\memory[12][5] ), .B0(n99), .B1(
        \memory[13][5] ), .Y(n77) );
  NAND4XLM U123 ( .A(n79), .B(n78), .C(n77), .D(n76), .Y(n80) );
  OAI32XLM U124 ( .A0(n109), .A1(n81), .A2(n80), .B0(read_data[5]), .B1(N61), 
        .Y(n82) );
  INVXLM U125 ( .A(n82), .Y(n293) );
  AOI22XLM U126 ( .A0(n84), .A1(register0[6]), .B0(n83), .B1(register1[6]), 
        .Y(n94) );
  AOI22XLM U127 ( .A0(n88), .A1(\memory[4][6] ), .B0(n87), .B1(\memory[5][6] ), 
        .Y(n92) );
  AOI22XLM U128 ( .A0(n90), .A1(\memory[6][6] ), .B0(n89), .B1(\memory[7][6] ), 
        .Y(n91) );
  NAND4XLM U129 ( .A(n94), .B(n93), .C(n92), .D(n91), .Y(n108) );
  AOI22XLM U130 ( .A0(n96), .A1(\memory[8][6] ), .B0(n95), .B1(\memory[9][6] ), 
        .Y(n106) );
  AOI22XLM U131 ( .A0(n98), .A1(\memory[10][6] ), .B0(n97), .B1(
        \memory[11][6] ), .Y(n105) );
  AOI22XLM U132 ( .A0(n100), .A1(\memory[12][6] ), .B0(n99), .B1(
        \memory[13][6] ), .Y(n104) );
  AOI22XLM U133 ( .A0(n102), .A1(\memory[14][6] ), .B0(n101), .B1(
        \memory[15][6] ), .Y(n103) );
  NAND4XLM U134 ( .A(n106), .B(n105), .C(n104), .D(n103), .Y(n107) );
  OAI32XLM U135 ( .A0(n109), .A1(n108), .A2(n107), .B0(read_data[6]), .B1(N61), 
        .Y(n110) );
  INVXLM U136 ( .A(n110), .Y(n294) );
  NOR2BXLM U137 ( .AN(write_enable), .B(read_enable), .Y(n125) );
  NAND2XLM U138 ( .A(n111), .B(n125), .Y(n119) );
  NOR2XLM U139 ( .A(n127), .B(n119), .Y(n112) );
  INVXLM U140 ( .A(write_data[7]), .Y(n139) );
  AOI2BB2XLM U141 ( .B0(n112), .B1(n139), .A0N(register0[7]), .A1N(n112), .Y(
        n423) );
  INVXLM U142 ( .A(write_data[6]), .Y(n140) );
  AOI2BB2XLM U143 ( .B0(n112), .B1(n140), .A0N(register0[6]), .A1N(n112), .Y(
        n422) );
  INVXLM U144 ( .A(write_data[5]), .Y(n141) );
  AOI2BB2XLM U145 ( .B0(n112), .B1(n141), .A0N(register0[5]), .A1N(n112), .Y(
        n421) );
  INVXLM U146 ( .A(write_data[4]), .Y(n142) );
  AOI2BB2XLM U147 ( .B0(n112), .B1(n142), .A0N(register0[4]), .A1N(n112), .Y(
        n420) );
  INVXLM U148 ( .A(write_data[3]), .Y(n143) );
  AOI2BB2XLM U149 ( .B0(n112), .B1(n143), .A0N(register0[3]), .A1N(n112), .Y(
        n419) );
  INVXLM U150 ( .A(write_data[2]), .Y(n144) );
  AOI2BB2XLM U151 ( .B0(n112), .B1(n144), .A0N(register0[2]), .A1N(n112), .Y(
        n418) );
  INVXLM U152 ( .A(write_data[1]), .Y(n145) );
  AOI2BB2XLM U153 ( .B0(n112), .B1(n145), .A0N(register0[1]), .A1N(n112), .Y(
        n417) );
  AOI2BB2XLM U154 ( .B0(n112), .B1(n146), .A0N(register0[0]), .A1N(n112), .Y(
        n416) );
  NAND2XLM U155 ( .A(n113), .B(n125), .Y(n121) );
  NOR2XLM U156 ( .A(n127), .B(n121), .Y(n114) );
  AOI2BB2XLM U157 ( .B0(n114), .B1(n139), .A0N(register1[7]), .A1N(n114), .Y(
        n415) );
  AOI2BB2XLM U158 ( .B0(n114), .B1(n140), .A0N(register1[6]), .A1N(n114), .Y(
        n414) );
  AOI2BB2XLM U159 ( .B0(n114), .B1(n141), .A0N(register1[5]), .A1N(n114), .Y(
        n413) );
  AOI2BB2XLM U160 ( .B0(n114), .B1(n142), .A0N(register1[4]), .A1N(n114), .Y(
        n412) );
  AOI2BB2XLM U161 ( .B0(n114), .B1(n143), .A0N(register1[3]), .A1N(n114), .Y(
        n411) );
  AOI2BB2XLM U162 ( .B0(n114), .B1(n144), .A0N(register1[2]), .A1N(n114), .Y(
        n410) );
  AOI2BB2XLM U163 ( .B0(n114), .B1(n145), .A0N(register1[1]), .A1N(n114), .Y(
        n409) );
  AOI2BB2XLM U164 ( .B0(n114), .B1(n146), .A0N(register1[0]), .A1N(n114), .Y(
        n408) );
  NOR2XLM U165 ( .A(n130), .B(n119), .Y(n115) );
  AOI2BB2XLM U166 ( .B0(n115), .B1(n139), .A0N(n154), .A1N(n115), .Y(n407) );
  AOI2BB2XLM U167 ( .B0(n115), .B1(n140), .A0N(n155), .A1N(n115), .Y(n406) );
  AOI2BB2XLM U168 ( .B0(n115), .B1(n141), .A0N(n156), .A1N(n115), .Y(n405) );
  AOI2BB2XLM U169 ( .B0(n115), .B1(n142), .A0N(n157), .A1N(n115), .Y(n404) );
  AOI2BB2XLM U170 ( .B0(n115), .B1(n143), .A0N(n158), .A1N(n115), .Y(n403) );
  AOI2BB2XLM U171 ( .B0(n115), .B1(n144), .A0N(n159), .A1N(n115), .Y(n402) );
  AOI2BB2XLM U172 ( .B0(n115), .B1(n145), .A0N(register2[1]), .A1N(n115), .Y(
        n401) );
  AOI2BB2XLM U173 ( .B0(n115), .B1(n146), .A0N(register2[0]), .A1N(n115), .Y(
        n400) );
  NOR2XLM U174 ( .A(n130), .B(n121), .Y(n116) );
  AOI2BB2XLM U175 ( .B0(n116), .B1(n139), .A0N(n160), .A1N(n116), .Y(n399) );
  AOI2BB2XLM U176 ( .B0(n116), .B1(n140), .A0N(n161), .A1N(n116), .Y(n398) );
  AOI2BB2XLM U177 ( .B0(n116), .B1(n141), .A0N(register3[5]), .A1N(n116), .Y(
        n397) );
  AOI2BB2XLM U178 ( .B0(n116), .B1(n142), .A0N(register3[4]), .A1N(n116), .Y(
        n396) );
  AOI2BB2XLM U179 ( .B0(n116), .B1(n143), .A0N(register3[3]), .A1N(n116), .Y(
        n395) );
  AOI2BB2XLM U180 ( .B0(n116), .B1(n144), .A0N(register3[2]), .A1N(n116), .Y(
        n394) );
  AOI2BB2XLM U181 ( .B0(n116), .B1(n145), .A0N(register3[1]), .A1N(n116), .Y(
        n393) );
  AOI2BB2XLM U182 ( .B0(n116), .B1(n146), .A0N(register3[0]), .A1N(n116), .Y(
        n392) );
  NOR2XLM U183 ( .A(n133), .B(n119), .Y(n117) );
  AOI2BB2XLM U184 ( .B0(n117), .B1(n139), .A0N(\memory[4][7] ), .A1N(n117), 
        .Y(n391) );
  AOI2BB2XLM U185 ( .B0(n117), .B1(n140), .A0N(\memory[4][6] ), .A1N(n117), 
        .Y(n390) );
  AOI2BB2XLM U186 ( .B0(n117), .B1(n141), .A0N(\memory[4][5] ), .A1N(n117), 
        .Y(n389) );
  AOI2BB2XLM U187 ( .B0(n117), .B1(n142), .A0N(\memory[4][4] ), .A1N(n117), 
        .Y(n388) );
  AOI2BB2XLM U188 ( .B0(n117), .B1(n143), .A0N(\memory[4][3] ), .A1N(n117), 
        .Y(n387) );
  AOI2BB2XLM U189 ( .B0(n117), .B1(n144), .A0N(\memory[4][2] ), .A1N(n117), 
        .Y(n386) );
  AOI2BB2XLM U190 ( .B0(n117), .B1(n145), .A0N(\memory[4][1] ), .A1N(n117), 
        .Y(n385) );
  AOI2BB2XLM U191 ( .B0(n117), .B1(n146), .A0N(\memory[4][0] ), .A1N(n117), 
        .Y(n384) );
  NOR2XLM U192 ( .A(n133), .B(n121), .Y(n118) );
  AOI2BB2XLM U193 ( .B0(n118), .B1(n139), .A0N(\memory[5][7] ), .A1N(n118), 
        .Y(n383) );
  AOI2BB2XLM U194 ( .B0(n118), .B1(n140), .A0N(\memory[5][6] ), .A1N(n118), 
        .Y(n382) );
  AOI2BB2XLM U195 ( .B0(n118), .B1(n141), .A0N(\memory[5][5] ), .A1N(n118), 
        .Y(n381) );
  AOI2BB2XLM U196 ( .B0(n118), .B1(n142), .A0N(\memory[5][4] ), .A1N(n118), 
        .Y(n380) );
  AOI2BB2XLM U197 ( .B0(n118), .B1(n143), .A0N(\memory[5][3] ), .A1N(n118), 
        .Y(n379) );
  AOI2BB2XLM U198 ( .B0(n118), .B1(n144), .A0N(\memory[5][2] ), .A1N(n118), 
        .Y(n378) );
  AOI2BB2XLM U199 ( .B0(n118), .B1(n145), .A0N(\memory[5][1] ), .A1N(n118), 
        .Y(n377) );
  AOI2BB2XLM U200 ( .B0(n118), .B1(n146), .A0N(\memory[5][0] ), .A1N(n118), 
        .Y(n376) );
  NOR2XLM U201 ( .A(n138), .B(n119), .Y(n120) );
  AOI2BB2XLM U202 ( .B0(n120), .B1(n139), .A0N(\memory[6][7] ), .A1N(n120), 
        .Y(n375) );
  AOI2BB2XLM U203 ( .B0(n120), .B1(n140), .A0N(\memory[6][6] ), .A1N(n120), 
        .Y(n374) );
  AOI2BB2XLM U204 ( .B0(n120), .B1(n141), .A0N(\memory[6][5] ), .A1N(n120), 
        .Y(n373) );
  AOI2BB2XLM U205 ( .B0(n120), .B1(n142), .A0N(\memory[6][4] ), .A1N(n120), 
        .Y(n372) );
  AOI2BB2XLM U206 ( .B0(n120), .B1(n143), .A0N(\memory[6][3] ), .A1N(n120), 
        .Y(n371) );
  AOI2BB2XLM U207 ( .B0(n120), .B1(n144), .A0N(\memory[6][2] ), .A1N(n120), 
        .Y(n370) );
  AOI2BB2XLM U208 ( .B0(n120), .B1(n145), .A0N(\memory[6][1] ), .A1N(n120), 
        .Y(n369) );
  AOI2BB2XLM U209 ( .B0(n120), .B1(n146), .A0N(\memory[6][0] ), .A1N(n120), 
        .Y(n368) );
  NOR2XLM U210 ( .A(n138), .B(n121), .Y(n122) );
  AOI2BB2XLM U211 ( .B0(n122), .B1(n139), .A0N(\memory[7][7] ), .A1N(n122), 
        .Y(n367) );
  AOI2BB2XLM U212 ( .B0(n122), .B1(n140), .A0N(\memory[7][6] ), .A1N(n122), 
        .Y(n366) );
  AOI2BB2XLM U213 ( .B0(n122), .B1(n141), .A0N(\memory[7][5] ), .A1N(n122), 
        .Y(n365) );
  AOI2BB2XLM U214 ( .B0(n122), .B1(n142), .A0N(\memory[7][4] ), .A1N(n122), 
        .Y(n364) );
  AOI2BB2XLM U215 ( .B0(n122), .B1(n143), .A0N(\memory[7][3] ), .A1N(n122), 
        .Y(n363) );
  AOI2BB2XLM U216 ( .B0(n122), .B1(n144), .A0N(\memory[7][2] ), .A1N(n122), 
        .Y(n362) );
  AOI2BB2XLM U217 ( .B0(n122), .B1(n145), .A0N(\memory[7][1] ), .A1N(n122), 
        .Y(n361) );
  AOI2BB2XLM U218 ( .B0(n122), .B1(n146), .A0N(\memory[7][0] ), .A1N(n122), 
        .Y(n360) );
  NAND2BXLM U219 ( .AN(n123), .B(n125), .Y(n135) );
  NOR2XLM U220 ( .A(n127), .B(n135), .Y(n124) );
  AOI2BB2XLM U221 ( .B0(n124), .B1(n139), .A0N(\memory[8][7] ), .A1N(n124), 
        .Y(n359) );
  AOI2BB2XLM U222 ( .B0(n124), .B1(n140), .A0N(\memory[8][6] ), .A1N(n124), 
        .Y(n358) );
  AOI2BB2XLM U223 ( .B0(n124), .B1(n141), .A0N(\memory[8][5] ), .A1N(n124), 
        .Y(n357) );
  AOI2BB2XLM U224 ( .B0(n124), .B1(n142), .A0N(\memory[8][4] ), .A1N(n124), 
        .Y(n356) );
  AOI2BB2XLM U225 ( .B0(n124), .B1(n143), .A0N(\memory[8][3] ), .A1N(n124), 
        .Y(n355) );
  AOI2BB2XLM U226 ( .B0(n124), .B1(n144), .A0N(\memory[8][2] ), .A1N(n124), 
        .Y(n354) );
  AOI2BB2XLM U227 ( .B0(n124), .B1(n145), .A0N(\memory[8][1] ), .A1N(n124), 
        .Y(n353) );
  AOI2BB2XLM U228 ( .B0(n124), .B1(n146), .A0N(\memory[8][0] ), .A1N(n124), 
        .Y(n352) );
  NAND2BXLM U229 ( .AN(n126), .B(n125), .Y(n137) );
  NOR2XLM U230 ( .A(n127), .B(n137), .Y(n128) );
  AOI2BB2XLM U231 ( .B0(n128), .B1(n139), .A0N(\memory[9][7] ), .A1N(n128), 
        .Y(n351) );
  AOI2BB2XLM U232 ( .B0(n128), .B1(n140), .A0N(\memory[9][6] ), .A1N(n128), 
        .Y(n350) );
  AOI2BB2XLM U233 ( .B0(n128), .B1(n141), .A0N(\memory[9][5] ), .A1N(n128), 
        .Y(n349) );
  AOI2BB2XLM U234 ( .B0(n128), .B1(n142), .A0N(\memory[9][4] ), .A1N(n128), 
        .Y(n348) );
  AOI2BB2XLM U235 ( .B0(n128), .B1(n143), .A0N(\memory[9][3] ), .A1N(n128), 
        .Y(n347) );
  AOI2BB2XLM U236 ( .B0(n128), .B1(n144), .A0N(\memory[9][2] ), .A1N(n128), 
        .Y(n346) );
  AOI2BB2XLM U237 ( .B0(n128), .B1(n145), .A0N(\memory[9][1] ), .A1N(n128), 
        .Y(n345) );
  AOI2BB2XLM U238 ( .B0(n128), .B1(n146), .A0N(\memory[9][0] ), .A1N(n128), 
        .Y(n344) );
  NOR2XLM U239 ( .A(n130), .B(n135), .Y(n129) );
  AOI2BB2XLM U240 ( .B0(n129), .B1(n139), .A0N(\memory[10][7] ), .A1N(n129), 
        .Y(n343) );
  AOI2BB2XLM U241 ( .B0(n129), .B1(n140), .A0N(\memory[10][6] ), .A1N(n129), 
        .Y(n342) );
  AOI2BB2XLM U242 ( .B0(n129), .B1(n141), .A0N(\memory[10][5] ), .A1N(n129), 
        .Y(n341) );
  AOI2BB2XLM U243 ( .B0(n129), .B1(n142), .A0N(\memory[10][4] ), .A1N(n129), 
        .Y(n340) );
  AOI2BB2XLM U244 ( .B0(n129), .B1(n143), .A0N(\memory[10][3] ), .A1N(n129), 
        .Y(n339) );
  AOI2BB2XLM U245 ( .B0(n129), .B1(n144), .A0N(\memory[10][2] ), .A1N(n129), 
        .Y(n338) );
  AOI2BB2XLM U246 ( .B0(n129), .B1(n145), .A0N(\memory[10][1] ), .A1N(n129), 
        .Y(n337) );
  AOI2BB2XLM U247 ( .B0(n129), .B1(n146), .A0N(\memory[10][0] ), .A1N(n129), 
        .Y(n336) );
  NOR2XLM U248 ( .A(n130), .B(n137), .Y(n131) );
  AOI2BB2XLM U249 ( .B0(n131), .B1(n139), .A0N(\memory[11][7] ), .A1N(n131), 
        .Y(n335) );
  AOI2BB2XLM U250 ( .B0(n131), .B1(n140), .A0N(\memory[11][6] ), .A1N(n131), 
        .Y(n334) );
  AOI2BB2XLM U251 ( .B0(n131), .B1(n141), .A0N(\memory[11][5] ), .A1N(n131), 
        .Y(n333) );
  AOI2BB2XLM U252 ( .B0(n131), .B1(n142), .A0N(\memory[11][4] ), .A1N(n131), 
        .Y(n332) );
  AOI2BB2XLM U253 ( .B0(n131), .B1(n143), .A0N(\memory[11][3] ), .A1N(n131), 
        .Y(n331) );
  AOI2BB2XLM U254 ( .B0(n131), .B1(n144), .A0N(\memory[11][2] ), .A1N(n131), 
        .Y(n330) );
  AOI2BB2XLM U255 ( .B0(n131), .B1(n145), .A0N(\memory[11][1] ), .A1N(n131), 
        .Y(n329) );
  AOI2BB2XLM U256 ( .B0(n131), .B1(n146), .A0N(\memory[11][0] ), .A1N(n131), 
        .Y(n328) );
  NOR2XLM U257 ( .A(n133), .B(n135), .Y(n132) );
  AOI2BB2XLM U258 ( .B0(n132), .B1(n139), .A0N(\memory[12][7] ), .A1N(n132), 
        .Y(n327) );
  AOI2BB2XLM U259 ( .B0(n132), .B1(n140), .A0N(\memory[12][6] ), .A1N(n132), 
        .Y(n326) );
  AOI2BB2XLM U260 ( .B0(n132), .B1(n141), .A0N(\memory[12][5] ), .A1N(n132), 
        .Y(n325) );
  AOI2BB2XLM U261 ( .B0(n132), .B1(n142), .A0N(\memory[12][4] ), .A1N(n132), 
        .Y(n324) );
  AOI2BB2XLM U262 ( .B0(n132), .B1(n143), .A0N(\memory[12][3] ), .A1N(n132), 
        .Y(n323) );
  AOI2BB2XLM U263 ( .B0(n132), .B1(n144), .A0N(\memory[12][2] ), .A1N(n132), 
        .Y(n322) );
  AOI2BB2XLM U264 ( .B0(n132), .B1(n145), .A0N(\memory[12][1] ), .A1N(n132), 
        .Y(n321) );
  AOI2BB2XLM U265 ( .B0(n132), .B1(n146), .A0N(\memory[12][0] ), .A1N(n132), 
        .Y(n320) );
  NOR2XLM U266 ( .A(n133), .B(n137), .Y(n134) );
  AOI2BB2XLM U267 ( .B0(n134), .B1(n139), .A0N(\memory[13][7] ), .A1N(n134), 
        .Y(n319) );
  AOI2BB2XLM U268 ( .B0(n134), .B1(n140), .A0N(\memory[13][6] ), .A1N(n134), 
        .Y(n318) );
  AOI2BB2XLM U269 ( .B0(n134), .B1(n141), .A0N(\memory[13][5] ), .A1N(n134), 
        .Y(n317) );
  AOI2BB2XLM U270 ( .B0(n134), .B1(n142), .A0N(\memory[13][4] ), .A1N(n134), 
        .Y(n316) );
  AOI2BB2XLM U271 ( .B0(n134), .B1(n143), .A0N(\memory[13][3] ), .A1N(n134), 
        .Y(n315) );
  AOI2BB2XLM U272 ( .B0(n134), .B1(n144), .A0N(\memory[13][2] ), .A1N(n134), 
        .Y(n314) );
  AOI2BB2XLM U273 ( .B0(n134), .B1(n145), .A0N(\memory[13][1] ), .A1N(n134), 
        .Y(n313) );
  AOI2BB2XLM U274 ( .B0(n134), .B1(n146), .A0N(\memory[13][0] ), .A1N(n134), 
        .Y(n312) );
  NOR2XLM U275 ( .A(n138), .B(n135), .Y(n136) );
  AOI2BB2XLM U276 ( .B0(n136), .B1(n139), .A0N(\memory[14][7] ), .A1N(n136), 
        .Y(n311) );
  AOI2BB2XLM U277 ( .B0(n136), .B1(n140), .A0N(\memory[14][6] ), .A1N(n136), 
        .Y(n310) );
  AOI2BB2XLM U278 ( .B0(n136), .B1(n141), .A0N(\memory[14][5] ), .A1N(n136), 
        .Y(n309) );
  AOI2BB2XLM U279 ( .B0(n136), .B1(n142), .A0N(\memory[14][4] ), .A1N(n136), 
        .Y(n308) );
  AOI2BB2XLM U280 ( .B0(n136), .B1(n143), .A0N(\memory[14][3] ), .A1N(n136), 
        .Y(n307) );
  AOI2BB2XLM U281 ( .B0(n136), .B1(n144), .A0N(\memory[14][2] ), .A1N(n136), 
        .Y(n306) );
  AOI2BB2XLM U282 ( .B0(n136), .B1(n145), .A0N(\memory[14][1] ), .A1N(n136), 
        .Y(n305) );
  AOI2BB2XLM U283 ( .B0(n136), .B1(n146), .A0N(\memory[14][0] ), .A1N(n136), 
        .Y(n304) );
  AOI2BB2XLM U284 ( .B0(n147), .B1(n139), .A0N(\memory[15][7] ), .A1N(n147), 
        .Y(n303) );
  AOI2BB2XLM U285 ( .B0(n147), .B1(n140), .A0N(\memory[15][6] ), .A1N(n147), 
        .Y(n302) );
  AOI2BB2XLM U286 ( .B0(n147), .B1(n141), .A0N(\memory[15][5] ), .A1N(n147), 
        .Y(n301) );
  AOI2BB2XLM U287 ( .B0(n147), .B1(n142), .A0N(\memory[15][4] ), .A1N(n147), 
        .Y(n300) );
  AOI2BB2XLM U288 ( .B0(n147), .B1(n143), .A0N(\memory[15][3] ), .A1N(n147), 
        .Y(n299) );
  AOI2BB2XLM U289 ( .B0(n147), .B1(n144), .A0N(\memory[15][2] ), .A1N(n147), 
        .Y(n298) );
  AOI2BB2XLM U290 ( .B0(n147), .B1(n145), .A0N(\memory[15][1] ), .A1N(n147), 
        .Y(n297) );
  AOI2BB2XLM U291 ( .B0(n147), .B1(n146), .A0N(\memory[15][0] ), .A1N(n147), 
        .Y(n296) );
  SDFFSQX1M \memory_reg[3][3]  ( .D(n395), .SI(register3[2]), .SE(test_se), 
        .CK(clk), .SN(n150), .Q(register3[3]) );
  SDFFSQX1M \memory_reg[2][0]  ( .D(n400), .SI(register1[7]), .SE(test_se), 
        .CK(clk), .SN(n150), .Q(register2[0]) );
endmodule


module register_test_1 ( clk, reset, D, Q, test_si, test_se );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset, test_si, test_se;


  SDFFRQX1M \Q_reg[0]  ( .D(D[0]), .SI(test_si), .SE(test_se), .CK(clk), .RN(
        reset), .Q(Q[0]) );
endmodule


module register_test_2 ( clk, reset, D, Q, test_se );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset, test_se;


  SDFFRQX2M \Q_reg[0]  ( .D(D[0]), .SI(D[0]), .SE(test_se), .CK(clk), .RN(
        reset), .Q(Q[0]) );
endmodule


module bus_synchronizer_test_1 ( clk, reset, asynchronous_data, 
        synchronous_data, test_si, test_se );
  input [0:0] asynchronous_data;
  output [0:0] synchronous_data;
  input clk, reset, test_si, test_se;
  wire   \output_ports[0][0] ;

  register_test_1 U0_register ( .clk(clk), .reset(reset), .D(
        asynchronous_data[0]), .Q(\output_ports[0][0] ), .test_si(test_si), 
        .test_se(test_se) );
  register_test_2 \register_instance[1].U_register  ( .clk(clk), .reset(reset), 
        .D(\output_ports[0][0] ), .Q(synchronous_data[0]), .test_se(test_se)
         );
endmodule


module register_6 ( clk, reset, D, Q );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset;


  DFFRQX1M \Q_reg[0]  ( .D(D[0]), .CK(clk), .RN(reset), .Q(Q[0]) );
endmodule


module register_5 ( clk, reset, D, Q );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset;


  DFFRQX1M \Q_reg[0]  ( .D(D[0]), .CK(clk), .RN(reset), .Q(Q[0]) );
endmodule


module bus_synchronizer_3 ( clk, reset, asynchronous_data, synchronous_data );
  input [0:0] asynchronous_data;
  output [0:0] synchronous_data;
  input clk, reset;
  wire   \output_ports[0][0] ;

  register_6 U0_register ( .clk(clk), .reset(reset), .D(asynchronous_data[0]), 
        .Q(\output_ports[0][0] ) );
  register_5 \register_instance[1].U_register  ( .clk(clk), .reset(reset), .D(
        \output_ports[0][0] ), .Q(synchronous_data[0]) );
endmodule


module register_test_0 ( clk, reset, D, Q, test_si, test_se );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset, test_si, test_se;


  SDFFRQX1M \Q_reg[0]  ( .D(D[0]), .SI(test_si), .SE(test_se), .CK(clk), .RN(
        reset), .Q(Q[0]) );
endmodule


module register_3 ( clk, reset, D, Q );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset;


  DFFRQX1M \Q_reg[0]  ( .D(D[0]), .CK(clk), .RN(reset), .Q(Q[0]) );
endmodule


module bus_synchronizer_test_0 ( clk, reset, asynchronous_data, 
        synchronous_data, test_si, test_se );
  input [0:0] asynchronous_data;
  output [0:0] synchronous_data;
  input clk, reset, test_si, test_se;
  wire   \output_ports[0][0] ;

  register_test_0 U0_register ( .clk(clk), .reset(reset), .D(
        asynchronous_data[0]), .Q(\output_ports[0][0] ), .test_si(test_si), 
        .test_se(test_se) );
  register_3 \register_instance[1].U_register  ( .clk(clk), .reset(reset), .D(
        \output_ports[0][0] ), .Q(synchronous_data[0]) );
endmodule


module data_synchronizer_test_0 ( clk, reset, asynchronous_data_valid, 
        asynchronous_data, Q_pulse_generator, synchronous_data_valid, 
        synchronous_data, test_si2, test_si1, test_so1, test_se );
  input [7:0] asynchronous_data;
  output [7:0] synchronous_data;
  input clk, reset, asynchronous_data_valid, test_si2, test_si1, test_se;
  output Q_pulse_generator, synchronous_data_valid, test_so1;
  wire   n2, synchronized_enable, pulse_generator_output, n4, n6, n8, n10, n12,
         n14, n16, n18, n1;
  assign test_so1 = n2;

  SDFFRQX1M synchronous_data_valid_reg ( .D(pulse_generator_output), .SI(
        synchronous_data[7]), .SE(test_se), .CK(clk), .RN(reset), .Q(
        synchronous_data_valid) );
  SDFFRQX1M \synchronous_data_reg[7]  ( .D(n18), .SI(synchronous_data[6]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(synchronous_data[7]) );
  SDFFRQX1M \synchronous_data_reg[6]  ( .D(n16), .SI(synchronous_data[5]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(synchronous_data[6]) );
  SDFFRQX1M \synchronous_data_reg[5]  ( .D(n14), .SI(synchronous_data[4]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(synchronous_data[5]) );
  SDFFRQX1M \synchronous_data_reg[4]  ( .D(n12), .SI(synchronous_data[3]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(synchronous_data[4]) );
  SDFFRQX1M \synchronous_data_reg[3]  ( .D(n10), .SI(synchronous_data[2]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(synchronous_data[3]) );
  SDFFRQX1M \synchronous_data_reg[2]  ( .D(n8), .SI(synchronous_data[1]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(synchronous_data[2]) );
  SDFFRQX1M \synchronous_data_reg[1]  ( .D(n6), .SI(synchronous_data[0]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(synchronous_data[1]) );
  SDFFRQX1M \synchronous_data_reg[0]  ( .D(n4), .SI(test_si2), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(synchronous_data[0]) );
  DFFRQX1M Q_pulse_generator_reg ( .D(synchronized_enable), .CK(clk), .RN(
        reset), .Q(n2) );
  NOR2BXLM U3 ( .AN(synchronized_enable), .B(n2), .Y(pulse_generator_output)
         );
  INVXLM U4 ( .A(pulse_generator_output), .Y(n1) );
  AO22XLM U5 ( .A0(pulse_generator_output), .A1(asynchronous_data[7]), .B0(n1), 
        .B1(synchronous_data[7]), .Y(n18) );
  AO22XLM U6 ( .A0(pulse_generator_output), .A1(asynchronous_data[6]), .B0(n1), 
        .B1(synchronous_data[6]), .Y(n16) );
  AO22XLM U7 ( .A0(pulse_generator_output), .A1(asynchronous_data[5]), .B0(n1), 
        .B1(synchronous_data[5]), .Y(n14) );
  AO22XLM U8 ( .A0(pulse_generator_output), .A1(asynchronous_data[4]), .B0(n1), 
        .B1(synchronous_data[4]), .Y(n12) );
  AO22XLM U9 ( .A0(pulse_generator_output), .A1(asynchronous_data[3]), .B0(n1), 
        .B1(synchronous_data[3]), .Y(n10) );
  AO22XLM U10 ( .A0(pulse_generator_output), .A1(asynchronous_data[2]), .B0(n1), .B1(synchronous_data[2]), .Y(n8) );
  AO22XLM U11 ( .A0(pulse_generator_output), .A1(asynchronous_data[1]), .B0(n1), .B1(synchronous_data[1]), .Y(n6) );
  AO22XLM U13 ( .A0(pulse_generator_output), .A1(asynchronous_data[0]), .B0(n1), .B1(synchronous_data[0]), .Y(n4) );
  bus_synchronizer_test_0 U_bus_synchronizer ( .clk(clk), .reset(reset), 
        .asynchronous_data(asynchronous_data_valid), .synchronous_data(
        synchronized_enable), .test_si(test_si1), .test_se(test_se) );
endmodule


module multiplexer_2x1_5 ( IN0, IN1, select, OUT );
  input IN0, IN1, select;
  output OUT;


  CLKMX2X2M U1 ( .A(IN0), .B(IN1), .S0(select), .Y(OUT) );
endmodule


module multiplexer_2x1_4 ( IN0, IN1, select, OUT );
  input IN0, IN1, select;
  output OUT;


  MX2XLM U1 ( .A(IN0), .B(IN1), .S0(select), .Y(OUT) );
endmodule


module reset_synchronizer_test_0 ( clk, reset, reset_synchronized, test_si, 
        test_se );
  input clk, reset, test_si, test_se;
  output reset_synchronized;
  wire   \Q[0] ;

  SDFFRQX1M \Q_reg[0]  ( .D(1'b1), .SI(test_si), .SE(test_se), .CK(clk), .RN(
        reset), .Q(\Q[0] ) );
  SDFFRQX1M \Q_reg[1]  ( .D(\Q[0] ), .SI(\Q[0] ), .SE(test_se), .CK(clk), .RN(
        reset), .Q(reset_synchronized) );
endmodule


module multiplexer_2x1_2 ( IN0, IN1, select, OUT );
  input IN0, IN1, select;
  output OUT;


  MX2X1M U1 ( .A(IN0), .B(IN1), .S0(select), .Y(OUT) );
endmodule


module UART_transmitter_FSM_test_1 ( clk, reset, parity_enable, data_valid, 
        serial_enable, bit_select, serial_data_index, busy, test_si, test_so, 
        test_se );
  output [1:0] bit_select;
  output [2:0] serial_data_index;
  input clk, reset, parity_enable, data_valid, test_si, test_se;
  output serial_enable, busy, test_so;
  wire   \serial_data_transmission_state[3] , N22, N23, N24, N25, n1, n2, n3,
         n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n18;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  assign test_so = n13;

  SDFFRQX1M \serial_data_transmission_state_reg[0]  ( .D(N22), .SI(n18), .SE(
        test_se), .CK(clk), .RN(reset), .Q(serial_data_index[0]) );
  SDFFRQX1M \serial_data_transmission_state_reg[1]  ( .D(N23), .SI(
        serial_data_index[0]), .SE(test_se), .CK(clk), .RN(reset), .Q(
        serial_data_index[1]) );
  SDFFRQX1M \serial_data_transmission_state_reg[2]  ( .D(N24), .SI(
        serial_data_index[1]), .SE(test_se), .CK(clk), .RN(reset), .Q(
        serial_data_index[2]) );
  SDFFRQX1M \serial_data_transmission_state_reg[3]  ( .D(N25), .SI(
        serial_data_index[2]), .SE(test_se), .CK(clk), .RN(reset), .Q(
        \serial_data_transmission_state[3] ) );
  SDFFRQX1M \current_state_reg[1]  ( .D(next_state[1]), .SI(n3), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(current_state[1]) );
  NAND2XLM U3 ( .A(data_valid), .B(n18), .Y(n4) );
  INVXLM U5 ( .A(\serial_data_transmission_state[3] ), .Y(n13) );
  NAND2XLM U6 ( .A(n18), .B(current_state[1]), .Y(n2) );
  AOI221XLM U7 ( .A0(parity_enable), .A1(n3), .B0(n13), .B1(n3), .C0(n2), .Y(
        n1) );
  INVXLM U8 ( .A(n1), .Y(n15) );
  OAI21XLM U10 ( .A0(current_state[0]), .A1(current_state[1]), .B0(n18), .Y(n8) );
  OAI31XLM U11 ( .A0(current_state[0]), .A1(current_state[1]), .A2(n18), .B0(
        n8), .Y(busy) );
  INVXLM U12 ( .A(n2), .Y(bit_select[1]) );
  NAND4XLM U13 ( .A(\serial_data_transmission_state[3] ), .B(parity_enable), 
        .C(bit_select[1]), .D(n3), .Y(n5) );
  OAI31XLM U14 ( .A0(current_state[0]), .A1(current_state[1]), .A2(n4), .B0(n5), .Y(next_state[0]) );
  AOI221XLM U15 ( .A0(\serial_data_transmission_state[3] ), .A1(
        current_state[1]), .B0(current_state[0]), .B1(current_state[1]), .C0(
        n8), .Y(serial_enable) );
  INVXLM U16 ( .A(serial_enable), .Y(n11) );
  NAND2XLM U17 ( .A(n11), .B(n5), .Y(next_state[1]) );
  NAND2XLM U18 ( .A(serial_data_index[1]), .B(serial_data_index[0]), .Y(n7) );
  INVXLM U19 ( .A(serial_data_index[2]), .Y(n6) );
  INVXLM U20 ( .A(serial_data_index[1]), .Y(n10) );
  INVXLM U21 ( .A(serial_data_index[0]), .Y(n9) );
  NOR3XLM U22 ( .A(n10), .B(n9), .C(n6), .Y(n14) );
  AOI211XLM U23 ( .A0(n7), .A1(n6), .B0(n14), .C0(n11), .Y(N24) );
  AO21XLM U24 ( .A0(current_state[0]), .A1(current_state[1]), .B0(n8), .Y(
        bit_select[0]) );
  AOI221XLM U25 ( .A0(serial_data_index[1]), .A1(serial_data_index[0]), .B0(
        n10), .B1(n9), .C0(n11), .Y(N23) );
  NOR2XLM U26 ( .A(serial_data_index[0]), .B(n11), .Y(N22) );
  INVXLM U27 ( .A(n14), .Y(n12) );
  AOI221XLM U28 ( .A0(\serial_data_transmission_state[3] ), .A1(n14), .B0(n13), 
        .B1(n12), .C0(n11), .Y(N25) );
  SDFFSQX1M \current_state_reg[2]  ( .D(n15), .SI(current_state[1]), .SE(
        test_se), .CK(clk), .SN(reset), .Q(n18) );
  SDFFRX1M \current_state_reg[0]  ( .D(next_state[0]), .SI(test_si), .SE(
        test_se), .CK(clk), .RN(reset), .Q(current_state[0]), .QN(n3) );
endmodule


module serializer_test_1 ( clk, reset, parallel_data, serial_enable, 
        serial_data_index, serial_data, test_si, test_se );
  input [7:0] parallel_data;
  input [2:0] serial_data_index;
  input clk, reset, serial_enable, test_si, test_se;
  output serial_data;
  wire   n10, n1, n2, n3, n4, n5, n6, n7, n8, n11;

  SDFFRQX1M serial_data_reg ( .D(n10), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(reset), .Q(serial_data) );
  AOI22XLM U2 ( .A0(serial_data_index[2]), .A1(parallel_data[4]), .B0(
        parallel_data[0]), .B1(n3), .Y(n5) );
  AOI22XLM U3 ( .A0(serial_data_index[1]), .A1(n2), .B0(n1), .B1(n4), .Y(n8)
         );
  OAI2B1XLM U4 ( .A1N(serial_data), .A0(serial_enable), .B0(n11), .Y(n10) );
  INVXLM U5 ( .A(serial_data_index[2]), .Y(n3) );
  AOI22XLM U6 ( .A0(serial_data_index[2]), .A1(parallel_data[7]), .B0(
        parallel_data[3]), .B1(n3), .Y(n2) );
  AOI22XLM U7 ( .A0(serial_data_index[2]), .A1(parallel_data[5]), .B0(
        parallel_data[1]), .B1(n3), .Y(n1) );
  INVXLM U8 ( .A(serial_data_index[1]), .Y(n4) );
  AOI22XLM U9 ( .A0(serial_data_index[2]), .A1(parallel_data[6]), .B0(
        parallel_data[2]), .B1(n3), .Y(n6) );
  AOI221XLM U10 ( .A0(n6), .A1(serial_data_index[1]), .B0(n5), .B1(n4), .C0(
        serial_data_index[0]), .Y(n7) );
  AOI32XLM U11 ( .A0(serial_data_index[0]), .A1(serial_enable), .A2(n8), .B0(
        n7), .B1(serial_enable), .Y(n11) );
endmodule


module parity_calculator_test_1 ( clk, reset, parity_type, parity_enable, 
        data_valid, parallel_data, parity_bit, test_si, test_se );
  input [7:0] parallel_data;
  input clk, reset, parity_type, parity_enable, data_valid, test_si, test_se;
  output parity_bit;
  wire   n10, n1, n2, n3, n4, n5, n6, n7;

  SDFFRQX1M parity_bit_reg ( .D(n10), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(reset), .Q(parity_bit) );
  NAND2XLM U2 ( .A(data_valid), .B(parity_enable), .Y(n7) );
  XOR3XLM U3 ( .A(parity_type), .B(parallel_data[4]), .C(parallel_data[2]), 
        .Y(n5) );
  XOR2XLM U4 ( .A(parallel_data[0]), .B(parallel_data[5]), .Y(n1) );
  XOR3XLM U5 ( .A(parallel_data[1]), .B(parallel_data[6]), .C(n1), .Y(n2) );
  XOR3XLM U6 ( .A(parallel_data[7]), .B(parallel_data[3]), .C(n2), .Y(n4) );
  NOR2XLM U7 ( .A(n5), .B(n4), .Y(n3) );
  AOI211XLM U8 ( .A0(n5), .A1(n4), .B0(n7), .C0(n3), .Y(n6) );
  AO21XLM U9 ( .A0(n7), .A1(parity_bit), .B0(n6), .Y(n10) );
endmodule


module output_multiplexer ( bit_select, serial_data, parity_bit, mux_out );
  input [1:0] bit_select;
  input serial_data, parity_bit;
  output mux_out;
  wire   n5, n1, n3, n4;

  INVXLM U3 ( .A(n5), .Y(n1) );
  CLKINVX8M U4 ( .A(n1), .Y(mux_out) );
  AOI31XLM U5 ( .A0(n4), .A1(bit_select[0]), .A2(bit_select[1]), .B0(n3), .Y(
        n5) );
  INVXLM U6 ( .A(parity_bit), .Y(n4) );
  AOI21XLM U7 ( .A0(bit_select[1]), .A1(serial_data), .B0(bit_select[0]), .Y(
        n3) );
endmodule


module UART_transmitter_test_1 ( clk, reset, parity_type, parity_enable, 
        data_valid, parallel_data, TX_out, busy, test_si, test_so, test_se );
  input [7:0] parallel_data;
  input clk, reset, parity_type, parity_enable, data_valid, test_si, test_se;
  output TX_out, busy, test_so;
  wire   serial_enable, serial_data, parity_bit, n1;
  wire   [1:0] bit_select;
  wire   [2:0] serial_data_index;
  assign test_so = serial_data;

  UART_transmitter_FSM_test_1 U_UART_transmitter_FSM ( .clk(clk), .reset(reset), .parity_enable(parity_enable), .data_valid(data_valid), .serial_enable(
        serial_enable), .bit_select(bit_select), .serial_data_index(
        serial_data_index), .busy(busy), .test_si(test_si), .test_so(n1), 
        .test_se(test_se) );
  serializer_test_1 U_serializer ( .clk(clk), .reset(reset), .parallel_data(
        parallel_data), .serial_enable(serial_enable), .serial_data_index(
        serial_data_index), .serial_data(serial_data), .test_si(parity_bit), 
        .test_se(test_se) );
  parity_calculator_test_1 U_parity_calculator ( .clk(clk), .reset(reset), 
        .parity_type(parity_type), .parity_enable(parity_enable), .data_valid(
        data_valid), .parallel_data(parallel_data), .parity_bit(parity_bit), 
        .test_si(n1), .test_se(test_se) );
  output_multiplexer U_output_multiplexer ( .bit_select(bit_select), 
        .serial_data(serial_data), .parity_bit(parity_bit), .mux_out(TX_out)
         );
endmodule


module UART_receiver_FSM_test_1 ( clk, reset, parity_enable, prescale, 
        serial_data, start_bit_error, parity_bit_error, stop_bit_error, 
        edge_count, edge_count_done, start_bit_check_enable, 
        parity_bit_check_enable, stop_bit_check_enable, 
        edge_counter_and_data_sampler_enable, deserializer_enable, data_index, 
        data_valid, test_si, test_so, test_se );
  input [5:0] prescale;
  input [4:0] edge_count;
  output [2:0] data_index;
  input clk, reset, parity_enable, serial_data, start_bit_error,
         parity_bit_error, stop_bit_error, edge_count_done, test_si, test_se;
  output start_bit_check_enable, parity_bit_check_enable,
         stop_bit_check_enable, edge_counter_and_data_sampler_enable,
         deserializer_enable, data_valid, test_so;
  wire   \data_transmission_state[3] , n32, n33, n34, n35, n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n36, n37, n38, n39,
         n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53,
         n54, n55, n56, n57;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  assign test_so = \data_transmission_state[3] ;

  SDFFRQX1M \current_state_reg[0]  ( .D(next_state[0]), .SI(test_si), .SE(
        test_se), .CK(clk), .RN(reset), .Q(current_state[0]) );
  SDFFRQX1M \current_state_reg[2]  ( .D(next_state[2]), .SI(current_state[1]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(current_state[2]) );
  SDFFRQX1M \current_state_reg[1]  ( .D(next_state[1]), .SI(n50), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(current_state[1]) );
  SDFFRQX1M \data_transmission_state_reg[2]  ( .D(n32), .SI(data_index[1]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(data_index[2]) );
  SDFFRQX1M \data_transmission_state_reg[3]  ( .D(n35), .SI(n29), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(\data_transmission_state[3] ) );
  SDFFRQX1M \data_transmission_state_reg[0]  ( .D(n34), .SI(n49), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(data_index[0]) );
  SDFFRQX1M \data_transmission_state_reg[1]  ( .D(n33), .SI(data_index[0]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(data_index[1]) );
  AOI32XLM U3 ( .A0(n14), .A1(n13), .A2(n12), .B0(prescale[5]), .B1(n11), .Y(
        n20) );
  NOR2BXLM U4 ( .AN(n45), .B(n38), .Y(deserializer_enable) );
  NOR3XLM U5 ( .A(n50), .B(n56), .C(n38), .Y(parity_bit_check_enable) );
  INVXLM U6 ( .A(n36), .Y(n56) );
  NAND3XLM U7 ( .A(prescale[3]), .B(prescale[2]), .C(prescale[4]), .Y(n10) );
  INVXLM U8 ( .A(edge_count[4]), .Y(n15) );
  NOR2XLM U9 ( .A(n15), .B(prescale[5]), .Y(n9) );
  AOI32XLM U10 ( .A0(prescale[2]), .A1(n10), .A2(prescale[3]), .B0(prescale[4]), .B1(n10), .Y(n6) );
  INVXLM U11 ( .A(prescale[2]), .Y(n1) );
  MXI2XLM U12 ( .A(prescale[2]), .B(n1), .S0(edge_count[2]), .Y(n18) );
  OAI22XLM U13 ( .A0(prescale[3]), .A1(n18), .B0(prescale[2]), .B1(
        edge_count[1]), .Y(n2) );
  AOI221XLM U14 ( .A0(n18), .A1(prescale[3]), .B0(prescale[2]), .B1(
        edge_count[1]), .C0(n2), .Y(n5) );
  AOI2BB2XLM U15 ( .B0(prescale[1]), .B1(edge_count[0]), .A0N(edge_count[0]), 
        .A1N(prescale[1]), .Y(n3) );
  AOI21XLM U16 ( .A0(n6), .A1(edge_count[3]), .B0(n3), .Y(n4) );
  OAI211XLM U17 ( .A0(n6), .A1(edge_count[3]), .B0(n5), .C0(n4), .Y(n7) );
  AOI221XLM U18 ( .A0(prescale[5]), .A1(n15), .B0(n9), .B1(n10), .C0(n7), .Y(
        n8) );
  OAI21XLM U19 ( .A0(n10), .A1(n9), .B0(n8), .Y(n38) );
  INVXLM U20 ( .A(current_state[0]), .Y(n50) );
  INVXLM U21 ( .A(current_state[1]), .Y(n48) );
  NAND3XLM U22 ( .A(current_state[2]), .B(n50), .C(n48), .Y(n47) );
  NOR2XLM U23 ( .A(n38), .B(n47), .Y(stop_bit_check_enable) );
  NOR2XLM U24 ( .A(n48), .B(current_state[2]), .Y(n36) );
  INVXLM U25 ( .A(\data_transmission_state[3] ), .Y(n41) );
  NOR3XLM U26 ( .A(prescale[3]), .B(prescale[2]), .C(prescale[1]), .Y(n14) );
  AOI221XLM U27 ( .A0(prescale[2]), .A1(prescale[3]), .B0(prescale[1]), .B1(
        prescale[3]), .C0(n14), .Y(n26) );
  NOR2XLM U28 ( .A(current_state[0]), .B(n56), .Y(n45) );
  AOI32XLM U29 ( .A0(prescale[1]), .A1(n45), .A2(n18), .B0(edge_count[1]), 
        .B1(n45), .Y(n25) );
  INVXLM U30 ( .A(edge_count[0]), .Y(n22) );
  INVXLM U31 ( .A(prescale[5]), .Y(n13) );
  NAND2XLM U32 ( .A(prescale[4]), .B(n15), .Y(n12) );
  INVXLM U33 ( .A(prescale[4]), .Y(n16) );
  NAND2XLM U34 ( .A(edge_count[4]), .B(n16), .Y(n11) );
  AOI221XLM U35 ( .A0(prescale[4]), .A1(edge_count[4]), .B0(n16), .B1(n15), 
        .C0(n14), .Y(n17) );
  AOI221XLM U36 ( .A0(prescale[1]), .A1(edge_count[1]), .B0(n18), .B1(
        edge_count[1]), .C0(n17), .Y(n19) );
  OAI211XLM U37 ( .A0(n22), .A1(prescale[0]), .B0(n20), .C0(n19), .Y(n21) );
  AOI21XLM U38 ( .A0(n22), .A1(prescale[0]), .B0(n21), .Y(n23) );
  OAI21XLM U39 ( .A0(n26), .A1(edge_count[3]), .B0(n23), .Y(n24) );
  AOI211XLM U40 ( .A0(n26), .A1(edge_count[3]), .B0(n25), .C0(n24), .Y(n42) );
  NAND2XLM U41 ( .A(n42), .B(data_index[0]), .Y(n40) );
  OAI221XLM U42 ( .A0(n41), .A1(n42), .B0(data_index[0]), .B1(n42), .C0(n40), 
        .Y(n27) );
  INVXLM U43 ( .A(n27), .Y(n34) );
  INVXLM U44 ( .A(current_state[2]), .Y(n49) );
  NOR3XLM U45 ( .A(current_state[1]), .B(n49), .C(n50), .Y(data_valid) );
  NAND2BXLM U46 ( .AN(n40), .B(data_index[1]), .Y(n44) );
  INVXLM U47 ( .A(data_index[2]), .Y(n29) );
  OAI211XLM U48 ( .A0(n44), .A1(n29), .B0(\data_transmission_state[3] ), .C0(
        n42), .Y(n28) );
  OAI31XLM U49 ( .A0(n44), .A1(n29), .A2(\data_transmission_state[3] ), .B0(
        n28), .Y(n35) );
  INVXLM U50 ( .A(edge_count_done), .Y(n30) );
  AOI221XLM U51 ( .A0(parity_enable), .A1(n50), .B0(n41), .B1(n50), .C0(n30), 
        .Y(n57) );
  OAI2B11XLM U52 ( .A1N(parity_bit_error), .A0(n50), .B0(n36), .C0(n57), .Y(
        n37) );
  AOI32XLM U53 ( .A0(edge_count_done), .A1(n37), .A2(stop_bit_error), .B0(n47), 
        .B1(n37), .Y(next_state[2]) );
  NAND2XLM U54 ( .A(current_state[0]), .B(n49), .Y(n54) );
  NAND3XLM U55 ( .A(n56), .B(n54), .C(n47), .Y(
        edge_counter_and_data_sampler_enable) );
  NOR3XLM U56 ( .A(current_state[1]), .B(n38), .C(n54), .Y(
        start_bit_check_enable) );
  OAI211XLM U57 ( .A0(n41), .A1(n42), .B0(n40), .C0(data_index[1]), .Y(n39) );
  OAI21XLM U58 ( .A0(n40), .A1(data_index[1]), .B0(n39), .Y(n33) );
  OAI211XLM U59 ( .A0(n42), .A1(n41), .B0(data_index[2]), .C0(n44), .Y(n43) );
  OAI21XLM U60 ( .A0(data_index[2]), .A1(n44), .B0(n43), .Y(n32) );
  NAND3XLM U61 ( .A(\data_transmission_state[3] ), .B(n45), .C(parity_enable), 
        .Y(n46) );
  OAI21XLM U62 ( .A0(stop_bit_error), .A1(n47), .B0(n46), .Y(n53) );
  AOI31XLM U63 ( .A0(n50), .A1(n49), .A2(n48), .B0(data_valid), .Y(n51) );
  OAI22XLM U64 ( .A0(edge_count_done), .A1(n54), .B0(serial_data), .B1(n51), 
        .Y(n52) );
  AO21XLM U65 ( .A0(edge_count_done), .A1(n53), .B0(n52), .Y(next_state[0]) );
  NOR3XLM U66 ( .A(current_state[1]), .B(start_bit_error), .C(n54), .Y(n55) );
  OAI2BB2XLM U67 ( .B0(n57), .B1(n56), .A0N(edge_count_done), .A1N(n55), .Y(
        next_state[1]) );
endmodule


module data_sampler_test_1 ( clk, reset, serial_data, prescale, enable, 
        edge_count, sampled_bit, test_si, test_so, test_se );
  input [4:0] prescale;
  input [4:0] edge_count;
  input clk, reset, serial_data, enable, test_si, test_se;
  output sampled_bit, test_so;
  wire   sample_enable, n13, n14, n15, n16, n1, n2, n3, n4, n5, n6, n7, n8, n9,
         n10, n11, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47;
  wire   [2:0] samples;
  assign test_so = samples[2];

  SDFFRQX1M sample_enable_reg ( .D(n13), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(reset), .Q(sample_enable) );
  SDFFRQX1M \samples_reg[2]  ( .D(n16), .SI(samples[1]), .SE(test_se), .CK(clk), .RN(reset), .Q(samples[2]) );
  SDFFRQX1M \samples_reg[1]  ( .D(n15), .SI(samples[0]), .SE(test_se), .CK(clk), .RN(reset), .Q(samples[1]) );
  SDFFRQX1M \samples_reg[0]  ( .D(n14), .SI(sample_enable), .SE(test_se), .CK(
        clk), .RN(reset), .Q(samples[0]) );
  OAI21XLM U3 ( .A0(n34), .A1(n33), .B0(n32), .Y(n44) );
  XOR2XLM U4 ( .A(prescale[4]), .B(edge_count[4]), .Y(n11) );
  INVXLM U5 ( .A(prescale[1]), .Y(n38) );
  MXI2XLM U6 ( .A(n38), .B(prescale[1]), .S0(edge_count[1]), .Y(n24) );
  INVXLM U7 ( .A(prescale[0]), .Y(n29) );
  MXI2XLM U8 ( .A(n29), .B(prescale[0]), .S0(edge_count[0]), .Y(n26) );
  INVXLM U9 ( .A(enable), .Y(n47) );
  NOR4XLM U10 ( .A(n11), .B(n24), .C(n26), .D(n47), .Y(n5) );
  INVXLM U11 ( .A(edge_count[3]), .Y(n3) );
  INVXLM U12 ( .A(prescale[2]), .Y(n2) );
  OAI22XLM U13 ( .A0(prescale[3]), .A1(n3), .B0(n2), .B1(edge_count[2]), .Y(n1) );
  AOI221XLM U14 ( .A0(n3), .A1(prescale[3]), .B0(n2), .B1(edge_count[2]), .C0(
        n1), .Y(n4) );
  NAND2XLM U15 ( .A(n5), .B(n4), .Y(n6) );
  MX2XLM U16 ( .A(serial_data), .B(samples[2]), .S0(n6), .Y(n16) );
  NOR3XLM U17 ( .A(prescale[3]), .B(prescale[2]), .C(prescale[1]), .Y(n10) );
  NOR2XLM U18 ( .A(n10), .B(n11), .Y(n22) );
  NOR2XLM U19 ( .A(prescale[2]), .B(prescale[1]), .Y(n7) );
  AOI2B1XLM U20 ( .A1N(n7), .A0(prescale[3]), .B0(n10), .Y(n36) );
  INVXLM U21 ( .A(n36), .Y(n21) );
  NOR2XLM U22 ( .A(prescale[1]), .B(n29), .Y(n9) );
  AOI21XLM U23 ( .A0(prescale[1]), .A1(prescale[2]), .B0(n7), .Y(n37) );
  XOR2XLM U24 ( .A(edge_count[2]), .B(n37), .Y(n34) );
  NAND2XLM U25 ( .A(n26), .B(enable), .Y(n31) );
  MXI2XLM U26 ( .A(n29), .B(prescale[0]), .S0(n24), .Y(n30) );
  OAI21XLM U27 ( .A0(n9), .A1(n34), .B0(n30), .Y(n8) );
  AOI211XLM U28 ( .A0(n9), .A1(n34), .B0(n31), .C0(n8), .Y(n20) );
  AOI21XLM U29 ( .A0(n11), .A1(n10), .B0(n22), .Y(n45) );
  NOR3XLM U30 ( .A(prescale[2]), .B(prescale[1]), .C(n29), .Y(n18) );
  NOR2XLM U31 ( .A(edge_count[3]), .B(n21), .Y(n35) );
  AOI21XLM U32 ( .A0(edge_count[3]), .A1(n21), .B0(n35), .Y(n39) );
  OAI211XLM U33 ( .A0(n45), .A1(n36), .B0(n18), .C0(n39), .Y(n17) );
  OAI31XLM U34 ( .A0(n45), .A1(n18), .A2(n39), .B0(n17), .Y(n19) );
  OAI211XLM U35 ( .A0(n22), .A1(n21), .B0(n20), .C0(n19), .Y(n23) );
  MX2XLM U36 ( .A(serial_data), .B(samples[1]), .S0(n23), .Y(n15) );
  NAND3XLM U37 ( .A(n24), .B(enable), .C(n34), .Y(n25) );
  NOR4XLM U38 ( .A(n45), .B(n39), .C(n26), .D(n25), .Y(n27) );
  MX2XLM U39 ( .A(samples[0]), .B(serial_data), .S0(n27), .Y(n14) );
  AOI222XLM U40 ( .A0(samples[1]), .A1(samples[0]), .B0(samples[1]), .B1(
        samples[2]), .C0(samples[0]), .C1(samples[2]), .Y(n28) );
  NOR2BXLM U41 ( .AN(sample_enable), .B(n28), .Y(sampled_bit) );
  NAND2XLM U42 ( .A(prescale[1]), .B(n29), .Y(n33) );
  AOI211XLM U43 ( .A0(n34), .A1(n33), .B0(n31), .C0(n30), .Y(n32) );
  AOI2BB1XLM U44 ( .A0N(n45), .A1N(n36), .B0(n35), .Y(n42) );
  OAI21BXLM U45 ( .A0(n38), .A1(prescale[0]), .B0N(n37), .Y(n41) );
  OAI21XLM U46 ( .A0(n45), .A1(n39), .B0(n41), .Y(n40) );
  OAI21XLM U47 ( .A0(n42), .A1(n41), .B0(n40), .Y(n43) );
  AOI211XLM U48 ( .A0(n45), .A1(edge_count[3]), .B0(n44), .C0(n43), .Y(n46) );
  AO21XLM U49 ( .A0(sample_enable), .A1(n47), .B0(n46), .Y(n13) );
endmodule


module deserializer_test_1 ( clk, reset, enable, data_index, sampled_bit, 
        parallel_data, test_si, test_se );
  input [2:0] data_index;
  output [7:0] parallel_data;
  input clk, reset, enable, sampled_bit, test_si, test_se;
  wire   n26, n27, n28, n29, n30, n31, n32, n33, n1, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n19;

  SDFFRQX1M \parallel_data_reg[7]  ( .D(n33), .SI(parallel_data[6]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(parallel_data[7]) );
  SDFFRQX1M \parallel_data_reg[6]  ( .D(n32), .SI(parallel_data[5]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(parallel_data[6]) );
  SDFFRQX1M \parallel_data_reg[5]  ( .D(n31), .SI(parallel_data[4]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(parallel_data[5]) );
  SDFFRQX1M \parallel_data_reg[4]  ( .D(n30), .SI(parallel_data[3]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(parallel_data[4]) );
  SDFFRQX1M \parallel_data_reg[3]  ( .D(n29), .SI(parallel_data[2]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(parallel_data[3]) );
  SDFFRQX1M \parallel_data_reg[2]  ( .D(n28), .SI(parallel_data[1]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(parallel_data[2]) );
  SDFFRQX1M \parallel_data_reg[1]  ( .D(n27), .SI(parallel_data[0]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(parallel_data[1]) );
  SDFFRQX1M \parallel_data_reg[0]  ( .D(n26), .SI(test_si), .SE(test_se), .CK(
        clk), .RN(reset), .Q(parallel_data[0]) );
  NAND2BXLM U2 ( .AN(data_index[0]), .B(enable), .Y(n15) );
  NAND2BXLM U3 ( .AN(n15), .B(sampled_bit), .Y(n19) );
  OAI21XLM U4 ( .A0(n19), .A1(n12), .B0(n11), .Y(n32) );
  NAND2XLM U5 ( .A(data_index[0]), .B(enable), .Y(n6) );
  NAND2BXLM U6 ( .AN(n6), .B(sampled_bit), .Y(n8) );
  NAND2XLM U7 ( .A(data_index[1]), .B(data_index[2]), .Y(n12) );
  OAI21XLM U8 ( .A0(n6), .A1(n12), .B0(parallel_data[7]), .Y(n1) );
  OAI21XLM U9 ( .A0(n8), .A1(n12), .B0(n1), .Y(n33) );
  INVXLM U10 ( .A(data_index[2]), .Y(n3) );
  NAND2XLM U11 ( .A(data_index[1]), .B(n3), .Y(n17) );
  OAI21XLM U12 ( .A0(n6), .A1(n17), .B0(parallel_data[3]), .Y(n2) );
  OAI21XLM U13 ( .A0(n8), .A1(n17), .B0(n2), .Y(n29) );
  INVXLM U14 ( .A(data_index[1]), .Y(n5) );
  NAND2XLM U15 ( .A(n5), .B(n3), .Y(n10) );
  OAI21XLM U16 ( .A0(n6), .A1(n10), .B0(parallel_data[1]), .Y(n4) );
  OAI21XLM U17 ( .A0(n8), .A1(n10), .B0(n4), .Y(n27) );
  NAND2XLM U18 ( .A(data_index[2]), .B(n5), .Y(n14) );
  OAI21XLM U19 ( .A0(n6), .A1(n14), .B0(parallel_data[5]), .Y(n7) );
  OAI21XLM U20 ( .A0(n8), .A1(n14), .B0(n7), .Y(n31) );
  OAI21XLM U21 ( .A0(n15), .A1(n10), .B0(parallel_data[0]), .Y(n9) );
  OAI21XLM U22 ( .A0(n19), .A1(n10), .B0(n9), .Y(n26) );
  OAI21XLM U23 ( .A0(n15), .A1(n12), .B0(parallel_data[6]), .Y(n11) );
  OAI21XLM U24 ( .A0(n15), .A1(n14), .B0(parallel_data[4]), .Y(n13) );
  OAI21XLM U25 ( .A0(n19), .A1(n14), .B0(n13), .Y(n30) );
  OAI21XLM U26 ( .A0(n15), .A1(n17), .B0(parallel_data[2]), .Y(n16) );
  OAI21XLM U27 ( .A0(n19), .A1(n17), .B0(n16), .Y(n28) );
endmodule


module edge_counter_test_1 ( clk, reset, prescale, enable, edge_count, 
        edge_count_done, test_si, test_so, test_se );
  input [5:0] prescale;
  output [4:0] edge_count;
  input clk, reset, enable, test_si, test_se;
  output edge_count_done, test_so;
  wire   N14, N15, N16, N17, N18, n1, n2, n3, n4, n5, n6, n7, n8, n10, n11,
         n12, n13, n14, n15, n16;
  assign test_so = n15;

  SDFFRQX1M \edge_count_reg[4]  ( .D(N18), .SI(edge_count[3]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(edge_count[4]) );
  SDFFRQX1M \edge_count_reg[3]  ( .D(N17), .SI(n5), .SE(test_se), .CK(clk), 
        .RN(reset), .Q(edge_count[3]) );
  SDFFRQX1M \edge_count_reg[2]  ( .D(N16), .SI(n7), .SE(test_se), .CK(clk), 
        .RN(reset), .Q(edge_count[2]) );
  SDFFRQX1M \edge_count_reg[1]  ( .D(N15), .SI(edge_count[0]), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(edge_count[1]) );
  SDFFRQX1M \edge_count_reg[0]  ( .D(N14), .SI(test_si), .SE(test_se), .CK(clk), .RN(reset), .Q(edge_count[0]) );
  NOR3XLM U3 ( .A(n8), .B(n7), .C(n5), .Y(n12) );
  AOI21XLM U4 ( .A0(prescale[5]), .A1(edge_count[4]), .B0(prescale[4]), .Y(n1)
         );
  INVXLM U5 ( .A(edge_count[3]), .Y(n11) );
  AOI211XLM U6 ( .A0(prescale[4]), .A1(prescale[5]), .B0(n1), .C0(n11), .Y(n3)
         );
  INVXLM U7 ( .A(edge_count[0]), .Y(n8) );
  INVXLM U8 ( .A(edge_count[1]), .Y(n7) );
  INVXLM U9 ( .A(edge_count[2]), .Y(n5) );
  OAI21XLM U10 ( .A0(prescale[5]), .A1(prescale[4]), .B0(prescale[3]), .Y(n2)
         );
  OAI211XLM U11 ( .A0(prescale[3]), .A1(n3), .B0(n12), .C0(n2), .Y(n4) );
  NOR4XLM U12 ( .A(prescale[2]), .B(prescale[1]), .C(prescale[0]), .D(n4), .Y(
        edge_count_done) );
  NAND2BXLM U13 ( .AN(edge_count_done), .B(enable), .Y(n13) );
  NOR2XLM U14 ( .A(edge_count[0]), .B(n13), .Y(N14) );
  NAND2XLM U15 ( .A(edge_count[0]), .B(edge_count[1]), .Y(n6) );
  AOI211XLM U16 ( .A0(n6), .A1(n5), .B0(n12), .C0(n13), .Y(N16) );
  AOI221XLM U17 ( .A0(edge_count[0]), .A1(edge_count[1]), .B0(n8), .B1(n7), 
        .C0(n13), .Y(N15) );
  INVXLM U18 ( .A(n12), .Y(n10) );
  AOI221XLM U19 ( .A0(edge_count[3]), .A1(n12), .B0(n11), .B1(n10), .C0(n13), 
        .Y(N17) );
  NAND2XLM U20 ( .A(edge_count[3]), .B(n12), .Y(n14) );
  INVXLM U21 ( .A(n14), .Y(n16) );
  INVXLM U22 ( .A(edge_count[4]), .Y(n15) );
  AOI221XLM U23 ( .A0(edge_count[4]), .A1(n16), .B0(n15), .B1(n14), .C0(n13), 
        .Y(N18) );
endmodule


module start_bit_checker_test_1 ( clk, reset, enable, sampled_bit, 
        start_bit_error, test_si, test_se );
  input clk, reset, enable, sampled_bit, test_si, test_se;
  output start_bit_error;
  wire   N4;

  SDFFRQX1M start_bit_error_reg ( .D(N4), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(reset), .Q(start_bit_error) );
  AND2X1M U3 ( .A(sampled_bit), .B(enable), .Y(N4) );
endmodule


module parity_bit_checker_test_1 ( clk, reset, parity_type, enable, 
        sampled_bit, parallel_data, parity_bit_error, test_si, test_so, 
        test_se );
  input [7:0] parallel_data;
  input clk, reset, parity_type, enable, sampled_bit, test_si, test_se;
  output parity_bit_error, test_so;
  wire   N10, n3, n4, n5, n6, n7, n8;

  AOI21XLM U4 ( .A0(n8), .A1(n7), .B0(n6), .Y(N10) );
  XOR2XLM U6 ( .A(parallel_data[3]), .B(parallel_data[1]), .Y(n3) );
  XOR3XLM U7 ( .A(parity_type), .B(parallel_data[0]), .C(n3), .Y(n8) );
  XOR2XLM U8 ( .A(parallel_data[4]), .B(parallel_data[2]), .Y(n4) );
  XOR3XLM U9 ( .A(parallel_data[7]), .B(parallel_data[6]), .C(n4), .Y(n5) );
  XOR3XLM U10 ( .A(parallel_data[5]), .B(sampled_bit), .C(n5), .Y(n7) );
  OAI21XLM U11 ( .A0(n8), .A1(n7), .B0(enable), .Y(n6) );
  SDFFRHQX8M parity_bit_error_reg ( .D(N10), .SI(test_si), .SE(test_se), .CK(
        clk), .RN(reset), .Q(parity_bit_error) );
  CLKBUFX1M U3 ( .A(parity_bit_error), .Y(test_so) );
endmodule


module stop_bit_checker_test_1 ( clk, reset, enable, sampled_bit, 
        stop_bit_error, test_si, test_se );
  input clk, reset, enable, sampled_bit, test_si, test_se;
  output stop_bit_error;
  wire   N5;

  SDFFRQX1M stop_bit_error_reg ( .D(N5), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(reset), .Q(stop_bit_error) );
  NOR2BXLM U3 ( .AN(enable), .B(sampled_bit), .Y(N5) );
endmodule


module UART_receiver_test_1 ( clk, reset, parity_type, parity_enable, prescale, 
        serial_data, data_valid, parallel_data, parity_error, frame_error, 
        test_si, test_so, test_se );
  input [5:0] prescale;
  output [7:0] parallel_data;
  input clk, reset, parity_type, parity_enable, serial_data, test_si, test_se;
  output data_valid, parity_error, frame_error, test_so;
  wire   start_bit_error, stop_bit_error, edge_count_done,
         start_bit_check_enable, parity_bit_check_enable,
         stop_bit_check_enable, edge_counter_and_data_sampler_enable,
         deserializer_enable, sampled_bit, n1, n2, n3, n4;
  wire   [4:0] edge_count;
  wire   [2:0] data_index;
  assign test_so = stop_bit_error;

  OR2X8M U1 ( .A(start_bit_error), .B(stop_bit_error), .Y(frame_error) );
  UART_receiver_FSM_test_1 U_UART_receiver_FSM ( .clk(clk), .reset(reset), 
        .parity_enable(parity_enable), .prescale(prescale), .serial_data(
        serial_data), .start_bit_error(start_bit_error), .parity_bit_error(
        parity_error), .stop_bit_error(stop_bit_error), .edge_count(edge_count), .edge_count_done(edge_count_done), .start_bit_check_enable(
        start_bit_check_enable), .parity_bit_check_enable(
        parity_bit_check_enable), .stop_bit_check_enable(stop_bit_check_enable), .edge_counter_and_data_sampler_enable(edge_counter_and_data_sampler_enable), 
        .deserializer_enable(deserializer_enable), .data_index(data_index), 
        .data_valid(data_valid), .test_si(test_si), .test_so(n4), .test_se(
        test_se) );
  data_sampler_test_1 U_data_sampler ( .clk(clk), .reset(reset), .serial_data(
        serial_data), .prescale(prescale[5:1]), .enable(
        edge_counter_and_data_sampler_enable), .edge_count(edge_count), 
        .sampled_bit(sampled_bit), .test_si(n4), .test_so(n3), .test_se(
        test_se) );
  deserializer_test_1 U_deserializer ( .clk(clk), .reset(reset), .enable(
        deserializer_enable), .data_index(data_index), .sampled_bit(
        sampled_bit), .parallel_data(parallel_data), .test_si(n3), .test_se(
        test_se) );
  edge_counter_test_1 U_edge_counter ( .clk(clk), .reset(reset), .prescale(
        prescale), .enable(edge_counter_and_data_sampler_enable), .edge_count(
        edge_count), .edge_count_done(edge_count_done), .test_si(
        parallel_data[7]), .test_so(n2), .test_se(test_se) );
  start_bit_checker_test_1 U_start_bit_checker ( .clk(clk), .reset(reset), 
        .enable(start_bit_check_enable), .sampled_bit(sampled_bit), 
        .start_bit_error(start_bit_error), .test_si(n1), .test_se(test_se) );
  parity_bit_checker_test_1 U_parity_bit_checker ( .clk(clk), .reset(reset), 
        .parity_type(parity_type), .enable(parity_bit_check_enable), 
        .sampled_bit(sampled_bit), .parallel_data(parallel_data), 
        .parity_bit_error(parity_error), .test_si(n2), .test_so(n1), .test_se(
        test_se) );
  stop_bit_checker_test_1 U_stop_bit_checker ( .clk(clk), .reset(reset), 
        .enable(stop_bit_check_enable), .sampled_bit(sampled_bit), 
        .stop_bit_error(stop_bit_error), .test_si(start_bit_error), .test_se(
        test_se) );
endmodule


module UART_test_1 ( transmitter_clk, receiver_clk, reset, parity_type, 
        parity_enable, prescale, transmitter_parallel_data_valid, 
        transmitter_parallel_data, serial_data_receiver, 
        serial_data_transmitter, transmitter_busy, 
        receiver_parallel_data_valid, receiver_parallel_data, 
        parity_error_receiver, frame_error_receiver, test_si, test_so, test_se
 );
  input [5:0] prescale;
  input [7:0] transmitter_parallel_data;
  output [7:0] receiver_parallel_data;
  input transmitter_clk, receiver_clk, reset, parity_type, parity_enable,
         transmitter_parallel_data_valid, serial_data_receiver, test_si,
         test_se;
  output serial_data_transmitter, transmitter_busy,
         receiver_parallel_data_valid, parity_error_receiver,
         frame_error_receiver, test_so;
  wire   n1, n3;

  CLKBUFX3M U1 ( .A(reset), .Y(n1) );
  UART_transmitter_test_1 U_UART_transmitter ( .clk(transmitter_clk), .reset(
        n1), .parity_type(parity_type), .parity_enable(parity_enable), 
        .data_valid(transmitter_parallel_data_valid), .parallel_data(
        transmitter_parallel_data), .TX_out(serial_data_transmitter), .busy(
        transmitter_busy), .test_si(n3), .test_so(test_so), .test_se(test_se)
         );
  UART_receiver_test_1 U_UART_receiver ( .clk(receiver_clk), .reset(n1), 
        .parity_type(parity_type), .parity_enable(parity_enable), .prescale(
        prescale), .serial_data(serial_data_receiver), .data_valid(
        receiver_parallel_data_valid), .parallel_data(receiver_parallel_data), 
        .parity_error(parity_error_receiver), .frame_error(
        frame_error_receiver), .test_si(test_si), .test_so(n3), .test_se(
        test_se) );
endmodule


module clock_divider_test_1 ( reference_clk, reset, clk_divider_enable, 
        division_ratio, output_clk, test_si2, test_si1, test_so2, test_so1, 
        test_se );
  input [5:0] division_ratio;
  input reference_clk, reset, clk_divider_enable, test_si2, test_si1, test_se;
  output output_clk, test_so2, test_so1;
  wire   divided_clk, odd_toggle, n17, n18, n19, n20, n21, n22, n23, n1, n2,
         n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n24, n25,
         n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39;
  wire   [4:0] counter;
  assign test_so1 = counter[3];
  assign test_so2 = odd_toggle;

  SDFFRQX1M \counter_reg[0]  ( .D(n22), .SI(test_si1), .SE(test_se), .CK(
        reference_clk), .RN(reset), .Q(counter[0]) );
  SDFFRQX1M \counter_reg[1]  ( .D(n21), .SI(counter[0]), .SE(test_se), .CK(
        reference_clk), .RN(reset), .Q(counter[1]) );
  SDFFRQX1M \counter_reg[2]  ( .D(n20), .SI(n31), .SE(test_se), .CK(
        reference_clk), .RN(reset), .Q(counter[2]) );
  SDFFRQX1M \counter_reg[3]  ( .D(n19), .SI(n26), .SE(test_se), .CK(
        reference_clk), .RN(reset), .Q(counter[3]) );
  SDFFRQX1M \counter_reg[4]  ( .D(n18), .SI(test_si2), .SE(test_se), .CK(
        reference_clk), .RN(reset), .Q(counter[4]) );
  SDFFRQX1M divided_clk_reg ( .D(n17), .SI(counter[4]), .SE(test_se), .CK(
        reference_clk), .RN(reset), .Q(divided_clk) );
  MX2XLM U26 ( .A(reference_clk), .B(divided_clk), .S0(1'b1), .Y(output_clk)
         );
  INVXLM U3 ( .A(n10), .Y(n11) );
  OAI211XLM U4 ( .A0(n9), .A1(n15), .B0(n8), .C0(n7), .Y(n27) );
  INVXLM U5 ( .A(n38), .Y(n36) );
  OAI21XLM U6 ( .A0(n30), .A1(n27), .B0(odd_toggle), .Y(n28) );
  OAI31XLM U7 ( .A0(n30), .A1(n29), .A2(odd_toggle), .B0(n28), .Y(n23) );
  INVXLM U8 ( .A(counter[2]), .Y(n26) );
  NAND2XLM U9 ( .A(counter[0]), .B(counter[1]), .Y(n25) );
  NAND3XLM U10 ( .A(counter[0]), .B(counter[1]), .C(counter[2]), .Y(n34) );
  INVXLM U11 ( .A(n34), .Y(n33) );
  NOR3XLM U12 ( .A(division_ratio[3]), .B(division_ratio[1]), .C(
        division_ratio[2]), .Y(n9) );
  INVXLM U13 ( .A(counter[3]), .Y(n35) );
  NOR2XLM U14 ( .A(division_ratio[4]), .B(n35), .Y(n2) );
  AOI21XLM U15 ( .A0(division_ratio[4]), .A1(n35), .B0(n2), .Y(n15) );
  NAND2XLM U16 ( .A(division_ratio[4]), .B(n35), .Y(n1) );
  INVXLM U17 ( .A(counter[4]), .Y(n37) );
  XOR2XLM U18 ( .A(n37), .B(division_ratio[5]), .Y(n10) );
  INVXLM U19 ( .A(counter[0]), .Y(n32) );
  AOI2BB2XLM U20 ( .B0(division_ratio[2]), .B1(counter[1]), .A0N(counter[1]), 
        .A1N(division_ratio[2]), .Y(n6) );
  AOI21XLM U21 ( .A0(division_ratio[1]), .A1(n32), .B0(n6), .Y(n24) );
  AOI31XLM U22 ( .A0(n9), .A1(n1), .A2(n10), .B0(n24), .Y(n8) );
  AOI2BB2XLM U23 ( .B0(division_ratio[3]), .B1(counter[2]), .A0N(counter[2]), 
        .A1N(division_ratio[3]), .Y(n12) );
  INVXLM U24 ( .A(division_ratio[1]), .Y(n13) );
  OAI211XLM U25 ( .A0(division_ratio[2]), .A1(n12), .B0(counter[0]), .C0(n13), 
        .Y(n5) );
  NOR2XLM U27 ( .A(division_ratio[1]), .B(division_ratio[2]), .Y(n3) );
  OAI2B2XLM U28 ( .A1N(n12), .A0(n3), .B0(n2), .B1(n10), .Y(n4) );
  AOI21XLM U29 ( .A0(n6), .A1(n5), .B0(n4), .Y(n7) );
  INVXLM U30 ( .A(division_ratio[0]), .Y(n30) );
  AOI211XLM U31 ( .A0(counter[0]), .A1(n13), .B0(n12), .C0(n11), .Y(n14) );
  AOI31XLM U32 ( .A0(n24), .A1(n15), .A2(n14), .B0(odd_toggle), .Y(n29) );
  AOI222XLM U33 ( .A0(n27), .A1(n30), .B0(n27), .B1(odd_toggle), .C0(
        division_ratio[0]), .C1(n29), .Y(n39) );
  AOI211XLM U34 ( .A0(n26), .A1(n25), .B0(n33), .C0(n39), .Y(n20) );
  NOR2XLM U36 ( .A(counter[0]), .B(n39), .Y(n22) );
  INVXLM U37 ( .A(counter[1]), .Y(n31) );
  AOI221XLM U38 ( .A0(counter[0]), .A1(counter[1]), .B0(n32), .B1(n31), .C0(
        n39), .Y(n21) );
  AOI221XLM U39 ( .A0(counter[3]), .A1(n33), .B0(n35), .B1(n34), .C0(n39), .Y(
        n19) );
  NOR2XLM U40 ( .A(n35), .B(n34), .Y(n38) );
  AOI221XLM U41 ( .A0(counter[4]), .A1(n38), .B0(n37), .B1(n36), .C0(n39), .Y(
        n18) );
  AOI2BB2XLM U42 ( .B0(divided_clk), .B1(n39), .A0N(n39), .A1N(divided_clk), 
        .Y(n17) );
  SDFFSQX1M odd_toggle_reg ( .D(n23), .SI(divided_clk), .SE(test_se), .CK(
        reference_clk), .SN(reset), .Q(odd_toggle) );
endmodule


module register_test_3 ( clk, reset, D, Q, test_si, test_se );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset, test_si, test_se;


  SDFFRQX1M \Q_reg[0]  ( .D(D[0]), .SI(test_si), .SE(test_se), .CK(clk), .RN(
        reset), .Q(Q[0]) );
endmodule


module register_1 ( clk, reset, D, Q );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset;


  DFFSRX1M \Q_reg[0]  ( .D(D[0]), .CK(clk), .SN(1'b1), .RN(reset), .Q(Q[0]) );
endmodule


module bus_synchronizer_test_2 ( clk, reset, asynchronous_data, 
        synchronous_data, test_si, test_se );
  input [0:0] asynchronous_data;
  output [0:0] synchronous_data;
  input clk, reset, test_si, test_se;
  wire   \output_ports[0][0] ;

  register_test_3 U0_register ( .clk(clk), .reset(reset), .D(
        asynchronous_data[0]), .Q(\output_ports[0][0] ), .test_si(test_si), 
        .test_se(test_se) );
  register_1 \register_instance[1].U_register  ( .clk(clk), .reset(reset), .D(
        \output_ports[0][0] ), .Q(synchronous_data[0]) );
endmodule


module data_synchronizer_test_1 ( clk, reset, asynchronous_data_valid, 
        asynchronous_data, Q_pulse_generator, synchronous_data_valid, 
        synchronous_data, test_si2, test_si1, test_se );
  input [7:0] asynchronous_data;
  output [7:0] synchronous_data;
  input clk, reset, asynchronous_data_valid, test_si2, test_si1, test_se;
  output Q_pulse_generator, synchronous_data_valid;
  wire   synchronized_enable, pulse_generator_output, n1, n2, n5, n7, n9, n11,
         n12, n13, n14;

  SDFFRQX1M synchronous_data_valid_reg ( .D(pulse_generator_output), .SI(
        synchronous_data[7]), .SE(test_se), .CK(clk), .RN(reset), .Q(
        synchronous_data_valid) );
  SDFFRQX1M \synchronous_data_reg[7]  ( .D(n2), .SI(synchronous_data[6]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(synchronous_data[7]) );
  SDFFRQX1M \synchronous_data_reg[6]  ( .D(n5), .SI(synchronous_data[5]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(synchronous_data[6]) );
  SDFFRQX1M \synchronous_data_reg[5]  ( .D(n7), .SI(synchronous_data[4]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(synchronous_data[5]) );
  SDFFRQX1M \synchronous_data_reg[4]  ( .D(n9), .SI(synchronous_data[3]), .SE(
        test_se), .CK(clk), .RN(reset), .Q(synchronous_data[4]) );
  SDFFRQX1M \synchronous_data_reg[3]  ( .D(n11), .SI(synchronous_data[2]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(synchronous_data[3]) );
  SDFFRQX1M \synchronous_data_reg[2]  ( .D(n12), .SI(synchronous_data[1]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(synchronous_data[2]) );
  SDFFRQX1M \synchronous_data_reg[1]  ( .D(n13), .SI(synchronous_data[0]), 
        .SE(test_se), .CK(clk), .RN(reset), .Q(synchronous_data[1]) );
  SDFFRQX1M \synchronous_data_reg[0]  ( .D(n14), .SI(test_si2), .SE(test_se), 
        .CK(clk), .RN(reset), .Q(synchronous_data[0]) );
  DFFRQX1M Q_pulse_generator_reg ( .D(synchronized_enable), .CK(clk), .RN(
        reset), .Q(Q_pulse_generator) );
  NOR2BXLM U3 ( .AN(synchronized_enable), .B(Q_pulse_generator), .Y(
        pulse_generator_output) );
  INVXLM U4 ( .A(pulse_generator_output), .Y(n1) );
  AO22XLM U5 ( .A0(pulse_generator_output), .A1(asynchronous_data[5]), .B0(n1), 
        .B1(synchronous_data[5]), .Y(n7) );
  AO22XLM U6 ( .A0(pulse_generator_output), .A1(asynchronous_data[6]), .B0(n1), 
        .B1(synchronous_data[6]), .Y(n5) );
  AO22XLM U7 ( .A0(pulse_generator_output), .A1(asynchronous_data[4]), .B0(n1), 
        .B1(synchronous_data[4]), .Y(n9) );
  AO22XLM U8 ( .A0(pulse_generator_output), .A1(asynchronous_data[0]), .B0(n1), 
        .B1(synchronous_data[0]), .Y(n14) );
  AO22XLM U9 ( .A0(pulse_generator_output), .A1(asynchronous_data[3]), .B0(n1), 
        .B1(synchronous_data[3]), .Y(n11) );
  AO22XLM U10 ( .A0(pulse_generator_output), .A1(asynchronous_data[1]), .B0(n1), .B1(synchronous_data[1]), .Y(n13) );
  AO22XLM U11 ( .A0(pulse_generator_output), .A1(asynchronous_data[7]), .B0(n1), .B1(synchronous_data[7]), .Y(n2) );
  AO22XLM U12 ( .A0(pulse_generator_output), .A1(asynchronous_data[2]), .B0(n1), .B1(synchronous_data[2]), .Y(n12) );
  bus_synchronizer_test_2 U_bus_synchronizer ( .clk(clk), .reset(reset), 
        .asynchronous_data(asynchronous_data_valid), .synchronous_data(
        synchronized_enable), .test_si(test_si1), .test_se(test_se) );
endmodule


module system_top ( reference_clk, UART_clk, reset, serial_data_in, scan_clk, 
        scan_reset, test_mode, SE, SI, SO, serial_data_out, parity_error, 
        frame_error );
  input [2:0] SI;
  output [2:0] SO;
  input reference_clk, UART_clk, reset, serial_data_in, scan_clk, scan_reset,
         test_mode, SE;
  output serial_data_out, parity_error, frame_error;
  wire   multiplexed_reference_clk, multiplexed_reset,
         reference_reset_synchronized,
         multiplexed_reference_reset_synchronized, ALU_result_valid,
         register_file_read_data_valid, UART_transmitter_busy_synchronized,
         transmitter_Q_pulse_generator_synchronized,
         receiver_parallel_data_valid_synchronized, ALU_enable, ALU_clk_enable,
         transmitter_parallel_data_valid, register_file_write_enable,
         register_file_read_enable, _0_net_, ALU_clk, UART_transmitter_busy,
         transmitter_Q_pulse_generator, receiver_parallel_data_valid,
         multiplexed_UART_clk, UART_transmitter_clk,
         multiplexed_UART_transmitter_clk, UART_reset_synchronized,
         multiplexed_UART_reset_synchronized,
         transmitter_parallel_data_valid_synchronized, n7, n10, n11, n14;
  wire   [15:0] ALU_result;
  wire   [7:0] register_file_read_data;
  wire   [7:0] receiver_parallel_data_synchronized;
  wire   [3:0] ALU_function;
  wire   [7:0] transmitter_parallel_data;
  wire   [3:0] register_file_address;
  wire   [7:0] register_file_write_data;
  wire   [7:0] ALU_operand_A;
  wire   [7:0] ALU_operand_B;
  wire   [7:0] UART_parity_configuration;
  wire   [7:0] UART_prescale_configuration;
  wire   [7:0] receiver_parallel_data;
  wire   [7:0] transmitter_parallel_data_synchronized;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7;

  OR2X1M U4 ( .A(ALU_clk_enable), .B(test_mode), .Y(_0_net_) );
  CLKBUFX4M U8 ( .A(multiplexed_reference_reset_synchronized), .Y(n14) );
  multiplexer_2x1_1 U_reference_clock_multiplexer ( .IN0(reference_clk), .IN1(
        scan_clk), .select(test_mode), .OUT(multiplexed_reference_clk) );
  multiplexer_2x1_0 U_reset_multiplexer ( .IN0(reset), .IN1(scan_reset), 
        .select(test_mode), .OUT(multiplexed_reset) );
  reset_synchronizer_test_1 U_reference_reset_synchronizer ( .clk(
        multiplexed_reference_clk), .reset(multiplexed_reset), 
        .reset_synchronized(reference_reset_synchronized), .test_si(n7), 
        .test_se(SE) );
  multiplexer_2x1_3 U_reference_reset_multiplexer ( .IN0(
        reference_reset_synchronized), .IN1(scan_reset), .select(test_mode), 
        .OUT(multiplexed_reference_reset_synchronized) );
  system_controller_test_1 U_system_controller ( .clk(
        multiplexed_reference_clk), .reset(n14), .ALU_result_valid(
        ALU_result_valid), .ALU_result(ALU_result), 
        .register_file_read_data_valid(register_file_read_data_valid), 
        .register_file_read_data(register_file_read_data), 
        .transmitter_busy_synchronized(UART_transmitter_busy_synchronized), 
        .transmitter_Q_pulse_generator(
        transmitter_Q_pulse_generator_synchronized), 
        .receiver_parallel_data_valid_synchronized(
        receiver_parallel_data_valid_synchronized), 
        .receiver_parallel_data_synchronized(
        receiver_parallel_data_synchronized), .ALU_function(ALU_function), 
        .ALU_enable(ALU_enable), .ALU_clk_enable(ALU_clk_enable), 
        .transmitter_parallel_data_valid(transmitter_parallel_data_valid), 
        .transmitter_parallel_data(transmitter_parallel_data), 
        .register_file_address(register_file_address), 
        .register_file_write_enable(register_file_write_enable), 
        .register_file_write_data(register_file_write_data), 
        .register_file_read_enable(register_file_read_enable), .test_so(SO[0]), 
        .test_se(SE) );
  clock_gating_cell U_clock_gating_cell ( .clk(multiplexed_reference_clk), 
        .clk_enable(_0_net_), .gated_clock(ALU_clk) );
  ALU_test_1 U_ALU ( .clk(ALU_clk), .reset(n14), .A(ALU_operand_A), .B(
        ALU_operand_B), .ALU_function(ALU_function), .enable(ALU_enable), 
        .ALU_result_valid(ALU_result_valid), .ALU_result(ALU_result), 
        .test_si(n11), .test_se(SE) );
  register_file_test_1 U_register_file ( .clk(multiplexed_reference_clk), 
        .reset(multiplexed_reference_reset_synchronized), .address(
        register_file_address), .write_enable(register_file_write_enable), 
        .write_data(register_file_write_data), .read_enable(
        register_file_read_enable), .read_data(register_file_read_data), 
        .read_data_valid(register_file_read_data_valid), .register0(
        ALU_operand_A), .register1(ALU_operand_B), .register2({
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        UART_parity_configuration[1:0]}), .register3({SYNOPSYS_UNCONNECTED__6, 
        SYNOPSYS_UNCONNECTED__7, UART_prescale_configuration[5:0]}), 
        .test_si2(SI[0]), .test_si1(reference_reset_synchronized), .test_so1(
        SO[1]), .test_se(SE) );
  bus_synchronizer_test_1 U_busy_bit_synchronizer ( .clk(
        multiplexed_reference_clk), .reset(n14), .asynchronous_data(
        UART_transmitter_busy), .synchronous_data(
        UART_transmitter_busy_synchronized), .test_si(
        transmitter_parallel_data_valid_synchronized), .test_se(SE) );
  bus_synchronizer_3 U_Q_pulse_generator_bit_synchronizer ( .clk(
        multiplexed_reference_clk), .reset(n14), .asynchronous_data(
        transmitter_Q_pulse_generator), .synchronous_data(
        transmitter_Q_pulse_generator_synchronized) );
  data_synchronizer_test_0 U_UART_receiver_data_synchronizer ( .clk(
        multiplexed_reference_clk), .reset(n14), .asynchronous_data_valid(
        receiver_parallel_data_valid), .asynchronous_data(
        receiver_parallel_data), .synchronous_data_valid(
        receiver_parallel_data_valid_synchronized), .synchronous_data(
        receiver_parallel_data_synchronized), .test_si2(n10), .test_si1(
        transmitter_Q_pulse_generator_synchronized), .test_so1(n11), .test_se(
        SE) );
  multiplexer_2x1_5 U_UART_clock_multiplexer ( .IN0(UART_clk), .IN1(scan_clk), 
        .select(test_mode), .OUT(multiplexed_UART_clk) );
  multiplexer_2x1_4 U_UART_transmitter_clock_multiplexer ( .IN0(
        UART_transmitter_clk), .IN1(scan_clk), .select(test_mode), .OUT(
        multiplexed_UART_transmitter_clk) );
  reset_synchronizer_test_0 U_UART_reset_synchronizer ( .clk(
        multiplexed_UART_clk), .reset(multiplexed_reset), .reset_synchronized(
        UART_reset_synchronized), .test_si(
        receiver_parallel_data_valid_synchronized), .test_se(SE) );
  multiplexer_2x1_2 U_UART_reset_multiplexer ( .IN0(UART_reset_synchronized), 
        .IN1(scan_reset), .select(test_mode), .OUT(
        multiplexed_UART_reset_synchronized) );
  UART_test_1 U_UART ( .transmitter_clk(multiplexed_UART_transmitter_clk), 
        .receiver_clk(multiplexed_UART_clk), .reset(
        multiplexed_UART_reset_synchronized), .parity_type(
        UART_parity_configuration[1]), .parity_enable(
        UART_parity_configuration[0]), .prescale(
        UART_prescale_configuration[5:0]), .transmitter_parallel_data_valid(
        transmitter_parallel_data_valid_synchronized), 
        .transmitter_parallel_data(transmitter_parallel_data_synchronized), 
        .serial_data_receiver(serial_data_in), .serial_data_transmitter(
        serial_data_out), .transmitter_busy(UART_transmitter_busy), 
        .receiver_parallel_data_valid(receiver_parallel_data_valid), 
        .receiver_parallel_data(receiver_parallel_data), 
        .parity_error_receiver(parity_error), .frame_error_receiver(
        frame_error), .test_si(ALU_result_valid), .test_so(n10), .test_se(SE)
         );
  clock_divider_test_1 U_clock_divider ( .reference_clk(multiplexed_UART_clk), 
        .reset(multiplexed_UART_reset_synchronized), .clk_divider_enable(1'b1), 
        .division_ratio(UART_prescale_configuration[5:0]), .output_clk(
        UART_transmitter_clk), .test_si2(SI[1]), .test_si1(
        UART_transmitter_busy_synchronized), .test_so2(n7), .test_so1(SO[2]), 
        .test_se(SE) );
  data_synchronizer_test_1 U_UART_transmitter_data_synchronizer ( .clk(
        multiplexed_UART_transmitter_clk), .reset(
        multiplexed_UART_reset_synchronized), .asynchronous_data_valid(
        transmitter_parallel_data_valid), .asynchronous_data(
        transmitter_parallel_data), .Q_pulse_generator(
        transmitter_Q_pulse_generator), .synchronous_data_valid(
        transmitter_parallel_data_valid_synchronized), .synchronous_data(
        transmitter_parallel_data_synchronized), .test_si2(
        UART_reset_synchronized), .test_si1(SI[2]), .test_se(SE) );
endmodule

