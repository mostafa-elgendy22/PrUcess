/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Fri Mar 10 02:02:09 2023
/////////////////////////////////////////////////////////////


module UART_receiver_FSM ( clk, reset, parity_enable, serial_data_in, prescale, 
        start_bit_error, parity_bit_error, stop_bit_error, edge_count, 
        edge_count_done, start_bit_check_enable, parity_bit_check_enable, 
        stop_bit_check_enable, edge_counter_and_data_sampler_enable, 
        deserializer_enable, data_index, data_valid );
  input [5:0] prescale;
  input [4:0] edge_count;
  output [2:0] data_index;
  input clk, reset, parity_enable, serial_data_in, start_bit_error,
         parity_bit_error, stop_bit_error, edge_count_done;
  output start_bit_check_enable, parity_bit_check_enable,
         stop_bit_check_enable, edge_counter_and_data_sampler_enable,
         deserializer_enable, data_valid;
  wire   n54, \data_transmission_state[3] , N22, N99, N100, N101, N102, N103,
         N104, N105, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50,
         \sub_48/carry[5] , \sub_48/carry[4] , \sub_48/carry[3] ,
         \add_0_root_r89/carry[3] , \add_0_root_r89/carry[4] , n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n51, n52, n53;
  wire   [5:0] final_edge_number;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  assign final_edge_number[0] = prescale[0];
  assign N99 = prescale[1];

  DFFRQX2M \data_transmission_state_reg[3]  ( .D(n50), .CK(clk), .RN(reset), 
        .Q(\data_transmission_state[3] ) );
  DFFRQX4M \data_transmission_state_reg[1]  ( .D(n48), .CK(clk), .RN(reset), 
        .Q(data_index[1]) );
  DFFRQX4M \current_state_reg[2]  ( .D(next_state[2]), .CK(clk), .RN(reset), 
        .Q(current_state[2]) );
  DFFRQX4M \current_state_reg[1]  ( .D(next_state[1]), .CK(clk), .RN(reset), 
        .Q(current_state[1]) );
  DFFRQX4M \data_transmission_state_reg[2]  ( .D(n19), .CK(clk), .RN(reset), 
        .Q(data_index[2]) );
  DFFRQX4M \data_transmission_state_reg[0]  ( .D(n49), .CK(clk), .RN(reset), 
        .Q(data_index[0]) );
  DFFRQX4M \current_state_reg[0]  ( .D(next_state[0]), .CK(clk), .RN(reset), 
        .Q(current_state[0]) );
  AOI31X2M U3 ( .A0(n23), .A1(n24), .A2(n21), .B0(data_valid), .Y(n36) );
  AOI32X1M U4 ( .A0(data_index[1]), .A1(n51), .A2(n40), .B0(n41), .B1(
        data_index[2]), .Y(n39) );
  INVX2M U5 ( .A(current_state[1]), .Y(n23) );
  OAI33X2M U6 ( .A0(n20), .A1(current_state[2]), .A2(n30), .B0(n24), .B1(
        current_state[1]), .B2(n31), .Y(next_state[2]) );
  NOR4X4M U7 ( .A(n9), .B(n8), .C(n7), .D(n6), .Y(N105) );
  NOR4X2M U8 ( .A(n17), .B(n16), .C(n15), .D(n14), .Y(N22) );
  NAND3BX2M U9 ( .AN(final_edge_number[5]), .B(n13), .C(n12), .Y(n17) );
  OR3X2M U10 ( .A(n24), .B(current_state[0]), .C(n23), .Y(n54) );
  CLKINVX32M U11 ( .A(n54), .Y(data_valid) );
  NOR2BX2M U12 ( .AN(edge_count[0]), .B(final_edge_number[0]), .Y(n11) );
  NOR2BX2M U13 ( .AN(final_edge_number[0]), .B(edge_count[0]), .Y(n10) );
  CLKINVX2M U14 ( .A(N99), .Y(final_edge_number[1]) );
  NOR2BX2M U15 ( .AN(edge_count[0]), .B(N99), .Y(n3) );
  NOR2BX2M U16 ( .AN(N99), .B(edge_count[0]), .Y(n2) );
  NOR2X2M U17 ( .A(n28), .B(current_state[1]), .Y(n47) );
  INVX2M U18 ( .A(\data_transmission_state[3] ), .Y(n52) );
  INVX2M U19 ( .A(edge_count_done), .Y(n20) );
  CLKINVX1M U20 ( .A(N105), .Y(n18) );
  INVX2M U21 ( .A(prescale[2]), .Y(N100) );
  NAND2X2M U22 ( .A(n52), .B(n44), .Y(n43) );
  NOR2X4M U23 ( .A(n25), .B(n44), .Y(n40) );
  AND3XLM U24 ( .A(n29), .B(n24), .C(N105), .Y(parity_bit_check_enable) );
  INVX2M U25 ( .A(n35), .Y(n22) );
  NOR2X2M U26 ( .A(n23), .B(n21), .Y(n29) );
  NOR3X4M U27 ( .A(n22), .B(current_state[0]), .C(n18), .Y(deserializer_enable) );
  INVX4M U28 ( .A(current_state[2]), .Y(n24) );
  NAND3X4M U29 ( .A(n35), .B(n21), .C(N22), .Y(n44) );
  NOR2X2M U30 ( .A(n27), .B(n18), .Y(stop_bit_check_enable) );
  OAI21X2M U31 ( .A0(data_index[1]), .A1(n44), .B0(n42), .Y(n41) );
  OAI21X2M U32 ( .A0(n45), .A1(n52), .B0(n46), .Y(n50) );
  NAND4X2M U33 ( .A(data_index[2]), .B(data_index[1]), .C(n40), .D(n52), .Y(
        n46) );
  AOI2BB1X2M U34 ( .A0N(n44), .A1N(data_index[2]), .B0(n41), .Y(n45) );
  AND3X1M U35 ( .A(n28), .B(n24), .C(N105), .Y(start_bit_check_enable) );
  OA21X2M U36 ( .A0(data_index[0]), .A1(n44), .B0(n43), .Y(n42) );
  INVX2M U37 ( .A(n39), .Y(n19) );
  INVX2M U38 ( .A(data_index[2]), .Y(n51) );
  OAI22X1M U39 ( .A0(n25), .A1(n43), .B0(data_index[0]), .B1(n44), .Y(n49) );
  OAI2BB2X1M U40 ( .B0(n42), .B1(n26), .A0N(n26), .A1N(n40), .Y(n48) );
  INVX2M U41 ( .A(data_index[1]), .Y(n26) );
  AOI2BB1X1M U42 ( .A0N(parity_bit_error), .A1N(stop_bit_error), .B0(n21), .Y(
        n31) );
  AOI31X2M U43 ( .A0(current_state[1]), .A1(n53), .A2(
        \data_transmission_state[3] ), .B0(n29), .Y(n30) );
  OAI21X1M U44 ( .A0(serial_data_in), .A1(n36), .B0(n37), .Y(next_state[0]) );
  AOI33X2M U45 ( .A0(n38), .A1(n21), .A2(edge_count_done), .B0(n24), .B1(n20), 
        .B2(current_state[0]), .Y(n37) );
  OAI32X2M U46 ( .A0(n53), .A1(n52), .A2(n22), .B0(current_state[1]), .B1(n24), 
        .Y(n38) );
  OAI2BB1X2M U47 ( .A0N(n28), .A1N(n32), .B0(n33), .Y(next_state[1]) );
  OAI21X2M U48 ( .A0(n34), .A1(n20), .B0(n35), .Y(n33) );
  OAI33X2M U49 ( .A0(n24), .A1(stop_bit_error), .A2(parity_bit_error), .B0(n20), .B1(start_bit_error), .B2(current_state[2]), .Y(n32) );
  AOI21X2M U50 ( .A0(\data_transmission_state[3] ), .A1(n53), .B0(
        current_state[0]), .Y(n34) );
  INVX2M U51 ( .A(parity_enable), .Y(n53) );
  OAI21X6M U52 ( .A0(current_state[2]), .A1(n47), .B0(n27), .Y(
        edge_counter_and_data_sampler_enable) );
  INVX4M U53 ( .A(current_state[0]), .Y(n21) );
  NOR2X4M U54 ( .A(n21), .B(current_state[1]), .Y(n28) );
  NAND2X2M U55 ( .A(current_state[2]), .B(n47), .Y(n27) );
  NOR2X4M U56 ( .A(n23), .B(current_state[2]), .Y(n35) );
  INVX2M U57 ( .A(data_index[0]), .Y(n25) );
  AND2X1M U58 ( .A(\add_0_root_r89/carry[4] ), .B(prescale[5]), .Y(N104) );
  CLKXOR2X2M U59 ( .A(prescale[5]), .B(\add_0_root_r89/carry[4] ), .Y(N103) );
  AND2X1M U60 ( .A(\add_0_root_r89/carry[3] ), .B(prescale[4]), .Y(
        \add_0_root_r89/carry[4] ) );
  CLKXOR2X2M U61 ( .A(prescale[4]), .B(\add_0_root_r89/carry[3] ), .Y(N102) );
  AND2X1M U62 ( .A(prescale[2]), .B(prescale[3]), .Y(\add_0_root_r89/carry[3] ) );
  CLKXOR2X2M U63 ( .A(prescale[3]), .B(prescale[2]), .Y(N101) );
  XNOR2X1M U64 ( .A(prescale[5]), .B(\sub_48/carry[5] ), .Y(
        final_edge_number[5]) );
  OR2X1M U65 ( .A(prescale[4]), .B(\sub_48/carry[4] ), .Y(\sub_48/carry[5] )
         );
  XNOR2X1M U66 ( .A(\sub_48/carry[4] ), .B(prescale[4]), .Y(
        final_edge_number[4]) );
  OR2X1M U67 ( .A(prescale[3]), .B(\sub_48/carry[3] ), .Y(\sub_48/carry[4] )
         );
  XNOR2X1M U68 ( .A(\sub_48/carry[3] ), .B(prescale[3]), .Y(
        final_edge_number[3]) );
  OR2X1M U69 ( .A(prescale[2]), .B(N99), .Y(\sub_48/carry[3] ) );
  XNOR2X1M U70 ( .A(N99), .B(prescale[2]), .Y(final_edge_number[2]) );
  OAI2B2X1M U71 ( .A1N(edge_count[1]), .A0(n2), .B0(N100), .B1(n2), .Y(n5) );
  OAI2B2X1M U72 ( .A1N(N100), .A0(n3), .B0(edge_count[1]), .B1(n3), .Y(n4) );
  NAND3BX1M U73 ( .AN(N104), .B(n5), .C(n4), .Y(n9) );
  CLKXOR2X2M U74 ( .A(N103), .B(edge_count[4]), .Y(n8) );
  CLKXOR2X2M U75 ( .A(N101), .B(edge_count[2]), .Y(n7) );
  CLKXOR2X2M U76 ( .A(N102), .B(edge_count[3]), .Y(n6) );
  OAI2B2X1M U77 ( .A1N(edge_count[1]), .A0(n10), .B0(final_edge_number[1]), 
        .B1(n10), .Y(n13) );
  OAI2B2X1M U78 ( .A1N(final_edge_number[1]), .A0(n11), .B0(edge_count[1]), 
        .B1(n11), .Y(n12) );
  CLKXOR2X2M U79 ( .A(final_edge_number[4]), .B(edge_count[4]), .Y(n16) );
  CLKXOR2X2M U80 ( .A(final_edge_number[2]), .B(edge_count[2]), .Y(n15) );
  CLKXOR2X2M U81 ( .A(final_edge_number[3]), .B(edge_count[3]), .Y(n14) );
endmodule


module data_sampler ( clk, reset, serial_data_in, prescale, enable, edge_count, 
        sampled_bit );
  input [4:0] prescale;
  input [4:0] edge_count;
  input clk, reset, serial_data_in, enable;
  output sampled_bit;
  wire   sample_enable, N18, N19, N20, N21, N23, N25, N26, N27, N30, N31, N32,
         N33, n25, n26, n27, n28, \add_24_3/carry[2] , \add_24_3/carry[3] ,
         \add_24_3/carry[4] , \add_24_2/carry[4] , \add_24_2/carry[3] ,
         \add_24/carry[4] , \add_24/carry[3] , \add_24/carry[2] ,
         \sub_16/carry[4] , \sub_16/carry[3] , n1, n2, n3, n4, n5, n6, n7, n8,
         n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22,
         n23, n24, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42;
  wire   [4:0] sampling_edge_number;
  wire   [2:0] samples;
  assign N23 = prescale[0];

  DFFRQX2M sample_enable_reg ( .D(n25), .CK(clk), .RN(reset), .Q(sample_enable) );
  DFFRQX2M \samples_reg[2]  ( .D(n28), .CK(clk), .RN(reset), .Q(samples[2]) );
  DFFRQX2M \samples_reg[1]  ( .D(n27), .CK(clk), .RN(reset), .Q(samples[1]) );
  DFFRQX2M \samples_reg[0]  ( .D(n26), .CK(clk), .RN(reset), .Q(samples[0]) );
  XNOR2X4M U3 ( .A(edge_count[4]), .B(N27), .Y(n11) );
  XNOR2X4M U4 ( .A(edge_count[3]), .B(N26), .Y(n9) );
  XNOR2X8M U5 ( .A(prescale[4]), .B(\sub_16/carry[4] ), .Y(
        sampling_edge_number[4]) );
  AOI21X6M U6 ( .A0(n1), .A1(n2), .B0(n3), .Y(sampled_bit) );
  NAND2X2M U7 ( .A(samples[1]), .B(samples[0]), .Y(n1) );
  XNOR2X8M U8 ( .A(\sub_16/carry[3] ), .B(prescale[3]), .Y(
        sampling_edge_number[3]) );
  XNOR2X8M U9 ( .A(prescale[1]), .B(prescale[2]), .Y(sampling_edge_number[2])
         );
  NAND3X2M U10 ( .A(n24), .B(n29), .C(n30), .Y(n10) );
  NOR3X2M U11 ( .A(n31), .B(n32), .C(n33), .Y(n30) );
  XOR2X1M U12 ( .A(sampling_edge_number[4]), .B(\add_24_2/carry[4] ), .Y(N27)
         );
  XOR2X1M U13 ( .A(sampling_edge_number[4]), .B(\add_24_3/carry[4] ), .Y(N33)
         );
  NAND2X2M U14 ( .A(enable), .B(n14), .Y(n7) );
  XNOR2X1M U15 ( .A(n36), .B(N23), .Y(n22) );
  NOR3X2M U16 ( .A(n40), .B(n41), .C(n42), .Y(n39) );
  MX2XLM U17 ( .A(samples[2]), .B(serial_data_in), .S0(n4), .Y(n28) );
  ADDHX1M U18 ( .A(sampling_edge_number[3]), .B(\add_24/carry[3] ), .CO(
        \add_24/carry[4] ), .S(N20) );
  ADDHX1M U19 ( .A(sampling_edge_number[2]), .B(\add_24/carry[2] ), .CO(
        \add_24/carry[3] ), .S(N19) );
  INVX4M U20 ( .A(prescale[1]), .Y(sampling_edge_number[1]) );
  ADDHX1M U21 ( .A(sampling_edge_number[1]), .B(N23), .CO(\add_24/carry[2] ), 
        .S(N18) );
  XNOR2X2M U22 ( .A(n21), .B(sampling_edge_number[1]), .Y(n34) );
  XNOR2X2M U23 ( .A(edge_count[0]), .B(N23), .Y(n31) );
  AND2X1M U24 ( .A(\add_24_3/carry[3] ), .B(sampling_edge_number[3]), .Y(
        \add_24_3/carry[4] ) );
  CLKXOR2X2M U25 ( .A(sampling_edge_number[3]), .B(\add_24_3/carry[3] ), .Y(
        N32) );
  AND2X1M U26 ( .A(\add_24_3/carry[2] ), .B(sampling_edge_number[2]), .Y(
        \add_24_3/carry[3] ) );
  CLKXOR2X2M U27 ( .A(sampling_edge_number[2]), .B(\add_24_3/carry[2] ), .Y(
        N31) );
  OR2X1M U28 ( .A(sampling_edge_number[1]), .B(N23), .Y(\add_24_3/carry[2] )
         );
  XNOR2X1M U29 ( .A(N23), .B(sampling_edge_number[1]), .Y(N30) );
  AND2X1M U30 ( .A(\add_24_2/carry[3] ), .B(sampling_edge_number[3]), .Y(
        \add_24_2/carry[4] ) );
  CLKXOR2X2M U31 ( .A(sampling_edge_number[3]), .B(\add_24_2/carry[3] ), .Y(
        N26) );
  AND2X1M U32 ( .A(sampling_edge_number[1]), .B(sampling_edge_number[2]), .Y(
        \add_24_2/carry[3] ) );
  CLKXOR2X2M U33 ( .A(sampling_edge_number[2]), .B(sampling_edge_number[1]), 
        .Y(N25) );
  OR2X1M U34 ( .A(prescale[3]), .B(\sub_16/carry[3] ), .Y(\sub_16/carry[4] )
         );
  OR2X1M U35 ( .A(prescale[2]), .B(prescale[1]), .Y(\sub_16/carry[3] ) );
  CLKXOR2X2M U36 ( .A(\add_24/carry[4] ), .B(sampling_edge_number[4]), .Y(N21)
         );
  OAI21X1M U37 ( .A0(samples[0]), .A1(samples[1]), .B0(samples[2]), .Y(n2) );
  NOR4X1M U38 ( .A(n5), .B(n6), .C(n7), .D(n8), .Y(n4) );
  NAND3X1M U39 ( .A(n9), .B(n10), .C(n11), .Y(n5) );
  CLKMX2X2M U40 ( .A(samples[1]), .B(serial_data_in), .S0(n12), .Y(n27) );
  NOR2X1M U41 ( .A(n7), .B(n10), .Y(n12) );
  CLKMX2X2M U42 ( .A(samples[0]), .B(serial_data_in), .S0(n13), .Y(n26) );
  NOR2BX1M U43 ( .AN(enable), .B(n14), .Y(n13) );
  OAI22X1M U44 ( .A0(n15), .A1(n16), .B0(enable), .B1(n3), .Y(n25) );
  CLKINVX1M U45 ( .A(sample_enable), .Y(n3) );
  NAND4X1M U46 ( .A(n17), .B(n18), .C(n19), .D(n20), .Y(n16) );
  CLKXOR2X2M U47 ( .A(n21), .B(N30), .Y(n20) );
  XNOR2X1M U48 ( .A(edge_count[2]), .B(N31), .Y(n19) );
  XNOR2X1M U49 ( .A(edge_count[3]), .B(N32), .Y(n18) );
  XNOR2X1M U50 ( .A(edge_count[4]), .B(N33), .Y(n17) );
  NAND4BX1M U51 ( .AN(n7), .B(n22), .C(n23), .D(n10), .Y(n15) );
  CLKXOR2X2M U52 ( .A(edge_count[2]), .B(N19), .Y(n33) );
  CLKXOR2X2M U53 ( .A(edge_count[1]), .B(N18), .Y(n32) );
  XNOR2X1M U54 ( .A(edge_count[3]), .B(N20), .Y(n29) );
  XNOR2X1M U55 ( .A(edge_count[4]), .B(N21), .Y(n24) );
  NAND4BBX1M U56 ( .AN(n8), .BN(n6), .C(n11), .D(n9), .Y(n23) );
  CLKNAND2X2M U57 ( .A(n34), .B(n35), .Y(n6) );
  CLKXOR2X2M U58 ( .A(n36), .B(N23), .Y(n35) );
  CLKINVX1M U59 ( .A(edge_count[1]), .Y(n21) );
  CLKXOR2X2M U60 ( .A(edge_count[2]), .B(N25), .Y(n8) );
  CLKINVX1M U61 ( .A(edge_count[0]), .Y(n36) );
  NAND3X1M U62 ( .A(n37), .B(n38), .C(n39), .Y(n14) );
  CLKXOR2X2M U63 ( .A(sampling_edge_number[2]), .B(edge_count[2]), .Y(n42) );
  CLKXOR2X2M U64 ( .A(sampling_edge_number[1]), .B(edge_count[1]), .Y(n41) );
  CLKXOR2X2M U65 ( .A(N23), .B(edge_count[0]), .Y(n40) );
  XNOR2X1M U66 ( .A(edge_count[3]), .B(sampling_edge_number[3]), .Y(n38) );
  XNOR2X1M U67 ( .A(edge_count[4]), .B(sampling_edge_number[4]), .Y(n37) );
endmodule


module deserializer ( clk, reset, enable, data_index, sampled_bit, 
        parallel_data );
  input [2:0] data_index;
  output [7:0] parallel_data;
  input clk, reset, enable, sampled_bit;
  wire   n43, n44, n45, n46, n47, n48, n49, n50, n3, n4, n5, n6, n7, n8, n9,
         n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n1, n27, n29, n31, n33, n35, n37, n39, n41, n42;

  DFFRQX2M \parallel_data_reg[6]  ( .D(n25), .CK(clk), .RN(reset), .Q(n44) );
  DFFRQX2M \parallel_data_reg[4]  ( .D(n23), .CK(clk), .RN(reset), .Q(n46) );
  DFFRQX2M \parallel_data_reg[7]  ( .D(n26), .CK(clk), .RN(reset), .Q(n43) );
  DFFRQX2M \parallel_data_reg[5]  ( .D(n24), .CK(clk), .RN(reset), .Q(n45) );
  DFFRQX2M \parallel_data_reg[0]  ( .D(n19), .CK(clk), .RN(reset), .Q(n50) );
  DFFRQX2M \parallel_data_reg[3]  ( .D(n22), .CK(clk), .RN(reset), .Q(n47) );
  DFFRQX2M \parallel_data_reg[2]  ( .D(n21), .CK(clk), .RN(reset), .Q(n48) );
  DFFRQX2M \parallel_data_reg[1]  ( .D(n20), .CK(clk), .RN(reset), .Q(n49) );
  NAND2X2M U2 ( .A(data_index[1]), .B(data_index[0]), .Y(n11) );
  CLKNAND2X4M U3 ( .A(data_index[2]), .B(enable), .Y(n15) );
  INVX2M U4 ( .A(n48), .Y(n1) );
  CLKINVX32M U5 ( .A(n1), .Y(parallel_data[2]) );
  INVX2M U6 ( .A(n49), .Y(n27) );
  CLKINVX32M U7 ( .A(n27), .Y(parallel_data[1]) );
  INVX2M U8 ( .A(n45), .Y(n29) );
  CLKINVX32M U9 ( .A(n29), .Y(parallel_data[5]) );
  INVX2M U10 ( .A(n46), .Y(n31) );
  CLKINVX32M U11 ( .A(n31), .Y(parallel_data[4]) );
  INVX2M U12 ( .A(n50), .Y(n33) );
  CLKINVX32M U13 ( .A(n33), .Y(parallel_data[0]) );
  INVX2M U14 ( .A(n47), .Y(n35) );
  CLKINVX32M U15 ( .A(n35), .Y(parallel_data[3]) );
  INVX2M U16 ( .A(n43), .Y(n37) );
  CLKINVX32M U17 ( .A(n37), .Y(parallel_data[7]) );
  INVX2M U18 ( .A(n44), .Y(n39) );
  CLKINVX32M U19 ( .A(n39), .Y(parallel_data[6]) );
  NAND2X2M U20 ( .A(data_index[0]), .B(n42), .Y(n7) );
  NAND2X2M U21 ( .A(data_index[1]), .B(n41), .Y(n9) );
  NAND2BX2M U22 ( .AN(n15), .B(sampled_bit), .Y(n13) );
  NAND2BX2M U23 ( .AN(n6), .B(sampled_bit), .Y(n4) );
  NAND2X2M U24 ( .A(n42), .B(n41), .Y(n3) );
  NAND2BX4M U25 ( .AN(data_index[2]), .B(enable), .Y(n6) );
  OAI21X2M U26 ( .A0(n4), .A1(n7), .B0(n8), .Y(n20) );
  OAI21X1M U27 ( .A0(n6), .A1(n7), .B0(parallel_data[1]), .Y(n8) );
  OAI21X2M U28 ( .A0(n4), .A1(n9), .B0(n10), .Y(n21) );
  OAI21X1M U29 ( .A0(n6), .A1(n9), .B0(parallel_data[2]), .Y(n10) );
  OAI21X2M U30 ( .A0(n4), .A1(n11), .B0(n12), .Y(n22) );
  OAI21X1M U31 ( .A0(n6), .A1(n11), .B0(parallel_data[3]), .Y(n12) );
  OAI21X2M U32 ( .A0(n3), .A1(n13), .B0(n14), .Y(n23) );
  OAI21X1M U33 ( .A0(n3), .A1(n15), .B0(parallel_data[4]), .Y(n14) );
  OAI21X2M U34 ( .A0(n7), .A1(n13), .B0(n16), .Y(n24) );
  OAI21X1M U35 ( .A0(n7), .A1(n15), .B0(parallel_data[5]), .Y(n16) );
  OAI21X2M U36 ( .A0(n9), .A1(n13), .B0(n17), .Y(n25) );
  OAI21X1M U37 ( .A0(n9), .A1(n15), .B0(parallel_data[6]), .Y(n17) );
  OAI21X2M U38 ( .A0(n11), .A1(n13), .B0(n18), .Y(n26) );
  OAI21X1M U39 ( .A0(n11), .A1(n15), .B0(parallel_data[7]), .Y(n18) );
  OAI21X2M U40 ( .A0(n3), .A1(n4), .B0(n5), .Y(n19) );
  OAI21X1M U41 ( .A0(n6), .A1(n3), .B0(parallel_data[0]), .Y(n5) );
  INVX2M U42 ( .A(data_index[1]), .Y(n42) );
  INVX2M U43 ( .A(data_index[0]), .Y(n41) );
endmodule


module edge_counter ( clk, reset, prescale, enable, edge_count, 
        edge_count_done );
  input [5:0] prescale;
  output [4:0] edge_count;
  input clk, reset, enable;
  output edge_count_done;
  wire   N10, N11, N12, N14, N15, N16, N17, N18, n4, n5, n6, n7, n8, n9,
         \add_16/carry[4] , \add_16/carry[3] , \add_16/carry[2] , n1, n3, n10;

  DFFRHQX8M \edge_count_reg[0]  ( .D(N14), .CK(clk), .RN(reset), .Q(
        edge_count[0]) );
  DFFRQX4M \edge_count_reg[1]  ( .D(N15), .CK(clk), .RN(reset), .Q(
        edge_count[1]) );
  DFFRQX4M \edge_count_reg[2]  ( .D(N16), .CK(clk), .RN(reset), .Q(
        edge_count[2]) );
  DFFRQX4M \edge_count_reg[3]  ( .D(N17), .CK(clk), .RN(reset), .Q(
        edge_count[3]) );
  DFFRQX4M \edge_count_reg[4]  ( .D(N18), .CK(clk), .RN(reset), .Q(
        edge_count[4]) );
  NAND2X4M U3 ( .A(enable), .B(n4), .Y(n5) );
  NOR2BX2M U4 ( .AN(N12), .B(n5), .Y(N17) );
  NOR2BX2M U5 ( .AN(N11), .B(n5), .Y(N16) );
  NOR2BX2M U6 ( .AN(N10), .B(n5), .Y(N15) );
  INVX2M U7 ( .A(n4), .Y(edge_count_done) );
  INVX2M U8 ( .A(prescale[4]), .Y(n10) );
  INVX2M U9 ( .A(prescale[5]), .Y(n3) );
  AOI32X1M U10 ( .A0(edge_count[4]), .A1(n10), .A2(prescale[5]), .B0(
        prescale[4]), .B1(n3), .Y(n9) );
  NAND4X2M U11 ( .A(edge_count[1]), .B(edge_count[0]), .C(edge_count[2]), .D(
        n6), .Y(n4) );
  NOR4X2M U12 ( .A(prescale[2]), .B(prescale[1]), .C(prescale[0]), .D(n7), .Y(
        n6) );
  AOI32X1M U13 ( .A0(n10), .A1(n3), .A2(prescale[3]), .B0(n8), .B1(
        edge_count[3]), .Y(n7) );
  NOR2X2M U14 ( .A(prescale[3]), .B(n9), .Y(n8) );
  NOR2X2M U15 ( .A(n1), .B(n5), .Y(N18) );
  XNOR2X2M U16 ( .A(\add_16/carry[4] ), .B(edge_count[4]), .Y(n1) );
  NOR2X2M U17 ( .A(edge_count[0]), .B(n5), .Y(N14) );
  ADDHX1M U18 ( .A(edge_count[1]), .B(edge_count[0]), .CO(\add_16/carry[2] ), 
        .S(N10) );
  ADDHX1M U19 ( .A(edge_count[2]), .B(\add_16/carry[2] ), .CO(
        \add_16/carry[3] ), .S(N11) );
  ADDHX1M U20 ( .A(edge_count[3]), .B(\add_16/carry[3] ), .CO(
        \add_16/carry[4] ), .S(N12) );
endmodule


module start_bit_checker ( clk, reset, enable, sampled_bit, start_bit_error );
  input clk, reset, enable, sampled_bit;
  output start_bit_error;
  wire   n1;

  DFFRQX2M start_bit_error_reg ( .D(n1), .CK(clk), .RN(reset), .Q(
        start_bit_error) );
  AO2B2XLM U2 ( .B0(sampled_bit), .B1(enable), .A0(start_bit_error), .A1N(
        enable), .Y(n1) );
endmodule


module parity_bit_checker ( clk, reset, parity_type, enable, sampled_bit, 
        parallel_data, parity_bit_error );
  input [7:0] parallel_data;
  input clk, reset, parity_type, enable, sampled_bit;
  output parity_bit_error;
  wire   n11, n1, n3, n4, n5, n6, n8, n2, n9, n10;

  DFFRQX2M parity_bit_error_reg ( .D(n8), .CK(clk), .RN(reset), .Q(n11) );
  XNOR2X2M U2 ( .A(parallel_data[7]), .B(parallel_data[6]), .Y(n6) );
  INVX2M U3 ( .A(n11), .Y(n2) );
  CLKINVX32M U4 ( .A(n2), .Y(parity_bit_error) );
  XNOR3XLM U5 ( .A(parallel_data[1]), .B(parallel_data[0]), .C(n9), .Y(n3) );
  XNOR2X1M U6 ( .A(sampled_bit), .B(parity_type), .Y(n5) );
  OAI2BB2X1M U7 ( .B0(n1), .B1(n10), .A0N(parity_bit_error), .A1N(n10), .Y(n8)
         );
  XOR3XLM U8 ( .A(n3), .B(n4), .C(n5), .Y(n1) );
  INVX2M U9 ( .A(enable), .Y(n10) );
  XOR3XLM U10 ( .A(parallel_data[5]), .B(parallel_data[4]), .C(n6), .Y(n4) );
  CLKXOR2X2M U11 ( .A(parallel_data[3]), .B(parallel_data[2]), .Y(n9) );
endmodule


module stop_bit_checker ( clk, reset, enable, sampled_bit, stop_bit_error );
  input clk, reset, enable, sampled_bit;
  output stop_bit_error;
  wire   n5, n2, n1, n4;

  DFFRQX2M stop_bit_error_reg ( .D(n2), .CK(clk), .RN(reset), .Q(n5) );
  INVX2M U2 ( .A(n5), .Y(n1) );
  CLKINVX32M U3 ( .A(n1), .Y(stop_bit_error) );
  OAI2BB2X1M U4 ( .B0(sampled_bit), .B1(n4), .A0N(stop_bit_error), .A1N(n4), 
        .Y(n2) );
  INVX2M U5 ( .A(enable), .Y(n4) );
endmodule


module UART_receiver ( clk, reset, parity_type, parity_enable, prescale, 
        serial_data_in, parallel_data, data_valid, parity_error, frame_error );
  input [5:0] prescale;
  output [7:0] parallel_data;
  input clk, reset, parity_type, parity_enable, serial_data_in;
  output data_valid, parity_error, frame_error;
  wire   start_bit_error, edge_count_done, start_bit_check_enable,
         parity_bit_check_enable, stop_bit_check_enable,
         edge_counter_and_data_sampler_enable, deserializer_enable,
         sampled_bit, n1, n2, n3, n4, n5;
  wire   [4:0] edge_count;
  wire   [2:0] data_index;

  UART_receiver_FSM U_UART_receiver_FSM ( .clk(clk), .reset(reset), 
        .parity_enable(parity_enable), .serial_data_in(serial_data_in), .prescale({
        n5, n4, n3, n2, n1, prescale[0]}), .start_bit_error(start_bit_error), 
        .parity_bit_error(parity_error), .stop_bit_error(frame_error), 
        .edge_count(edge_count), .edge_count_done(edge_count_done), 
        .start_bit_check_enable(start_bit_check_enable), 
        .parity_bit_check_enable(parity_bit_check_enable), 
        .stop_bit_check_enable(stop_bit_check_enable), 
        .edge_counter_and_data_sampler_enable(
        edge_counter_and_data_sampler_enable), .deserializer_enable(
        deserializer_enable), .data_index(data_index), .data_valid(data_valid)
         );
  data_sampler U_data_sampler ( .clk(clk), .reset(reset), .serial_data_in(
        serial_data_in), .prescale({n5, n4, n3, n2, n1}), .enable(
        edge_counter_and_data_sampler_enable), .edge_count(edge_count), 
        .sampled_bit(sampled_bit) );
  deserializer U_deserializer ( .clk(clk), .reset(reset), .enable(
        deserializer_enable), .data_index(data_index), .sampled_bit(
        sampled_bit), .parallel_data(parallel_data) );
  edge_counter U_edge_counter ( .clk(clk), .reset(reset), .prescale({n5, n4, 
        n3, n2, n1, prescale[0]}), .enable(
        edge_counter_and_data_sampler_enable), .edge_count(edge_count), 
        .edge_count_done(edge_count_done) );
  start_bit_checker U_start_bit_checker ( .clk(clk), .reset(reset), .enable(
        start_bit_check_enable), .sampled_bit(sampled_bit), .start_bit_error(
        start_bit_error) );
  parity_bit_checker U_parity_bit_checker ( .clk(clk), .reset(reset), 
        .parity_type(parity_type), .enable(parity_bit_check_enable), 
        .sampled_bit(sampled_bit), .parallel_data(parallel_data), 
        .parity_bit_error(parity_error) );
  stop_bit_checker U_stop_bit_checker ( .clk(clk), .reset(reset), .enable(
        stop_bit_check_enable), .sampled_bit(sampled_bit), .stop_bit_error(
        frame_error) );
  BUFX6M U1 ( .A(prescale[1]), .Y(n1) );
  CLKBUFX6M U2 ( .A(prescale[2]), .Y(n2) );
  BUFX4M U3 ( .A(prescale[3]), .Y(n3) );
  BUFX4M U4 ( .A(prescale[4]), .Y(n4) );
  BUFX4M U5 ( .A(prescale[5]), .Y(n5) );
endmodule

