/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Fri Mar 10 02:32:44 2023
/////////////////////////////////////////////////////////////


module multiplexer_2x1_0 ( IN0, IN1, select, OUT );
  input IN0, IN1, select;
  output OUT;


  MX2X6M U1 ( .A(IN0), .B(IN1), .S0(select), .Y(OUT) );
endmodule


module multiplexer_2x1_1 ( IN0, IN1, select, OUT );
  input IN0, IN1, select;
  output OUT;


  MX2X2M U1 ( .A(IN0), .B(IN1), .S0(select), .Y(OUT) );
endmodule


module UART_receiver_FSM_test_1 ( clk, reset, parity_enable, serial_data_in, 
        prescale, start_bit_error, parity_bit_error, stop_bit_error, 
        edge_count, edge_count_done, start_bit_check_enable, 
        parity_bit_check_enable, stop_bit_check_enable, 
        edge_counter_and_data_sampler_enable, deserializer_enable, data_index, 
        data_valid, test_si, test_so, test_se );
  input [5:0] prescale;
  input [4:0] edge_count;
  output [2:0] data_index;
  input clk, reset, parity_enable, serial_data_in, start_bit_error,
         parity_bit_error, stop_bit_error, edge_count_done, test_si, test_se;
  output start_bit_check_enable, parity_bit_check_enable,
         stop_bit_check_enable, edge_counter_and_data_sampler_enable,
         deserializer_enable, data_valid, test_so;
  wire   n13, n79, \data_transmission_state[3] , \current_state[2] , N22, N99,
         N100, N101, N102, N103, N104, N105, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, \sub_48/carry[5] , \sub_48/carry[4] ,
         \sub_48/carry[3] , \add_0_root_r89/carry[3] ,
         \add_0_root_r89/carry[4] , n1, n2, n3, n5, n7, n8, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n82, n4, n6,
         n9, n11, n12;
  wire   [5:0] final_edge_number;
  wire   [2:0] next_state;
  assign final_edge_number[0] = prescale[0];
  assign N99 = prescale[1];
  assign test_so = n75;

  SDFFRQX2M \data_transmission_state_reg[3]  ( .D(n57), .SI(data_index[2]), 
        .SE(test_se), .CK(clk), .RN(n24), .Q(\data_transmission_state[3] ) );
  INVX2M U9 ( .A(n8), .Y(n71) );
  AOI31X2M U10 ( .A0(n71), .A1(n12), .A2(n69), .B0(data_valid), .Y(n43) );
  AOI32X1M U13 ( .A0(data_index[1]), .A1(n5), .A2(n47), .B0(n48), .B1(
        data_index[2]), .Y(n46) );
  INVX4M U15 ( .A(n1), .Y(n2) );
  OAI33X2M U16 ( .A0(n68), .A1(n6), .A2(n37), .B0(n12), .B1(n8), .B2(n38), .Y(
        next_state[2]) );
  NOR4X4M U17 ( .A(n33), .B(n32), .C(n31), .D(n30), .Y(N105) );
  INVX4M U19 ( .A(n3), .Y(data_index[0]) );
  INVX4M U20 ( .A(n5), .Y(data_index[2]) );
  INVX4M U22 ( .A(n7), .Y(n8) );
  NOR4X2M U30 ( .A(n65), .B(n64), .C(n63), .D(n62), .Y(N22) );
  NAND3BX2M U31 ( .AN(final_edge_number[5]), .B(n61), .C(n60), .Y(n65) );
  OR3X2M U32 ( .A(n12), .B(n2), .C(n71), .Y(n79) );
  CLKINVX32M U33 ( .A(n79), .Y(data_valid) );
  NOR2BX2M U34 ( .AN(final_edge_number[0]), .B(edge_count[0]), .Y(n58) );
  NOR2BX2M U35 ( .AN(edge_count[0]), .B(final_edge_number[0]), .Y(n59) );
  CLKINVX2M U36 ( .A(N99), .Y(final_edge_number[1]) );
  NOR2BX2M U37 ( .AN(edge_count[0]), .B(N99), .Y(n27) );
  NOR2BX2M U38 ( .AN(N99), .B(edge_count[0]), .Y(n26) );
  NOR2X2M U39 ( .A(n35), .B(n8), .Y(n54) );
  INVX2M U40 ( .A(\data_transmission_state[3] ), .Y(n75) );
  INVX2M U41 ( .A(edge_count_done), .Y(n68) );
  CLKINVX1M U42 ( .A(N105), .Y(n66) );
  INVX2M U43 ( .A(prescale[2]), .Y(N100) );
  AND3XLM U44 ( .A(n36), .B(n12), .C(N105), .Y(parity_bit_check_enable) );
  NAND2X2M U45 ( .A(n51), .B(n82), .Y(n50) );
  NOR2X4M U46 ( .A(n73), .B(n51), .Y(n47) );
  INVX2M U47 ( .A(n42), .Y(n70) );
  NOR2X2M U48 ( .A(n71), .B(n69), .Y(n36) );
  INVX4M U49 ( .A(n25), .Y(n24) );
  INVX2M U50 ( .A(reset), .Y(n25) );
  NOR3X4M U51 ( .A(n70), .B(n2), .C(n66), .Y(deserializer_enable) );
  NOR2X2M U53 ( .A(n34), .B(n66), .Y(stop_bit_check_enable) );
  NAND3X4M U54 ( .A(n42), .B(n69), .C(N22), .Y(n51) );
  OAI21X2M U55 ( .A0(data_index[1]), .A1(n51), .B0(n49), .Y(n48) );
  AND3X1M U56 ( .A(n35), .B(n12), .C(N105), .Y(start_bit_check_enable) );
  OAI21X2M U57 ( .A0(n52), .A1(n75), .B0(n53), .Y(n57) );
  NAND4X2M U58 ( .A(data_index[2]), .B(data_index[1]), .C(n47), .D(n75), .Y(
        n53) );
  AOI2BB1X2M U59 ( .A0N(n51), .A1N(data_index[2]), .B0(n48), .Y(n52) );
  OA21X2M U60 ( .A0(data_index[0]), .A1(n51), .B0(n50), .Y(n49) );
  INVX2M U61 ( .A(n46), .Y(n67) );
  OAI22X1M U62 ( .A0(n73), .A1(n50), .B0(data_index[0]), .B1(n51), .Y(n56) );
  OAI2BB2X1M U63 ( .B0(n49), .B1(n74), .A0N(n74), .A1N(n47), .Y(n55) );
  AOI2BB1X1M U65 ( .A0N(parity_bit_error), .A1N(stop_bit_error), .B0(n69), .Y(
        n38) );
  AOI31X2M U66 ( .A0(n8), .A1(n76), .A2(\data_transmission_state[3] ), .B0(n36), .Y(n37) );
  OAI21X1M U67 ( .A0(serial_data_in), .A1(n43), .B0(n44), .Y(next_state[0]) );
  AOI33X2M U68 ( .A0(n45), .A1(n69), .A2(edge_count_done), .B0(n12), .B1(n68), 
        .B2(n2), .Y(n44) );
  OAI32X2M U69 ( .A0(n76), .A1(n75), .A2(n70), .B0(n8), .B1(n12), .Y(n45) );
  OAI2BB1X2M U70 ( .A0N(n35), .A1N(n39), .B0(n40), .Y(next_state[1]) );
  OAI21X2M U71 ( .A0(n41), .A1(n68), .B0(n42), .Y(n40) );
  OAI33X2M U72 ( .A0(n12), .A1(stop_bit_error), .A2(parity_bit_error), .B0(n68), .B1(start_bit_error), .B2(n6), .Y(n39) );
  AOI21X2M U73 ( .A0(\data_transmission_state[3] ), .A1(n76), .B0(n2), .Y(n41)
         );
  INVX2M U74 ( .A(parity_enable), .Y(n76) );
  OAI21X6M U75 ( .A0(n6), .A1(n54), .B0(n34), .Y(
        edge_counter_and_data_sampler_enable) );
  INVX4M U76 ( .A(n2), .Y(n69) );
  NOR2X4M U77 ( .A(n69), .B(n8), .Y(n35) );
  NAND2X2M U78 ( .A(n6), .B(n54), .Y(n34) );
  NOR2X4M U79 ( .A(n71), .B(n6), .Y(n42) );
  INVX2M U80 ( .A(data_index[0]), .Y(n73) );
  AND2X1M U81 ( .A(\add_0_root_r89/carry[4] ), .B(prescale[5]), .Y(N104) );
  CLKXOR2X2M U82 ( .A(prescale[5]), .B(\add_0_root_r89/carry[4] ), .Y(N103) );
  AND2X1M U83 ( .A(\add_0_root_r89/carry[3] ), .B(prescale[4]), .Y(
        \add_0_root_r89/carry[4] ) );
  CLKXOR2X2M U84 ( .A(prescale[4]), .B(\add_0_root_r89/carry[3] ), .Y(N102) );
  AND2X1M U85 ( .A(prescale[2]), .B(prescale[3]), .Y(\add_0_root_r89/carry[3] ) );
  CLKXOR2X2M U86 ( .A(prescale[3]), .B(prescale[2]), .Y(N101) );
  XNOR2X1M U87 ( .A(prescale[5]), .B(\sub_48/carry[5] ), .Y(
        final_edge_number[5]) );
  OR2X1M U88 ( .A(prescale[4]), .B(\sub_48/carry[4] ), .Y(\sub_48/carry[5] )
         );
  XNOR2X1M U89 ( .A(\sub_48/carry[4] ), .B(prescale[4]), .Y(
        final_edge_number[4]) );
  OR2X1M U90 ( .A(prescale[3]), .B(\sub_48/carry[3] ), .Y(\sub_48/carry[4] )
         );
  XNOR2X1M U91 ( .A(\sub_48/carry[3] ), .B(prescale[3]), .Y(
        final_edge_number[3]) );
  OR2X1M U92 ( .A(prescale[2]), .B(N99), .Y(\sub_48/carry[3] ) );
  XNOR2X1M U93 ( .A(N99), .B(prescale[2]), .Y(final_edge_number[2]) );
  OAI2B2X1M U94 ( .A1N(edge_count[1]), .A0(n26), .B0(N100), .B1(n26), .Y(n29)
         );
  OAI2B2X1M U95 ( .A1N(N100), .A0(n27), .B0(edge_count[1]), .B1(n27), .Y(n28)
         );
  NAND3BX1M U96 ( .AN(N104), .B(n29), .C(n28), .Y(n33) );
  CLKXOR2X2M U97 ( .A(N103), .B(edge_count[4]), .Y(n32) );
  CLKXOR2X2M U98 ( .A(N101), .B(edge_count[2]), .Y(n31) );
  CLKXOR2X2M U99 ( .A(N102), .B(edge_count[3]), .Y(n30) );
  OAI2B2X1M U100 ( .A1N(edge_count[1]), .A0(n58), .B0(final_edge_number[1]), 
        .B1(n58), .Y(n61) );
  OAI2B2X1M U101 ( .A1N(final_edge_number[1]), .A0(n59), .B0(edge_count[1]), 
        .B1(n59), .Y(n60) );
  CLKXOR2X2M U102 ( .A(final_edge_number[4]), .B(edge_count[4]), .Y(n64) );
  CLKXOR2X2M U103 ( .A(final_edge_number[2]), .B(edge_count[2]), .Y(n63) );
  CLKXOR2X2M U104 ( .A(final_edge_number[3]), .B(edge_count[3]), .Y(n62) );
  INVXLM U105 ( .A(\data_transmission_state[3] ), .Y(n82) );
  SDFFRX1M \data_transmission_state_reg[0]  ( .D(n56), .SI(n12), .SE(test_se), 
        .CK(clk), .RN(n24), .QN(n3) );
  SDFFRX1M \current_state_reg[1]  ( .D(next_state[1]), .SI(n69), .SE(test_se), 
        .CK(clk), .RN(n24), .QN(n7) );
  SDFFRX1M \current_state_reg[0]  ( .D(next_state[0]), .SI(test_si), .SE(
        test_se), .CK(clk), .RN(n24), .QN(n1) );
  SDFFRX1M \data_transmission_state_reg[2]  ( .D(n67), .SI(n74), .SE(test_se), 
        .CK(clk), .RN(n24), .QN(n5) );
  SDFFRX2M \data_transmission_state_reg[1]  ( .D(n55), .SI(n73), .SE(test_se), 
        .CK(clk), .RN(n24), .Q(n13), .QN(n74) );
  SDFFRX1M \current_state_reg[2]  ( .D(next_state[2]), .SI(n8), .SE(test_se), 
        .CK(clk), .RN(n24), .Q(\current_state[2] ), .QN(n72) );
  INVXLM U3 ( .A(\current_state[2] ), .Y(n4) );
  INVX4M U4 ( .A(n4), .Y(n6) );
  INVXLM U5 ( .A(n13), .Y(n9) );
  INVX4M U6 ( .A(n9), .Y(data_index[1]) );
  INVXLM U7 ( .A(n72), .Y(n11) );
  INVX4M U8 ( .A(n11), .Y(n12) );
endmodule


module data_sampler_test_1 ( clk, reset, serial_data_in, prescale, enable, 
        edge_count, sampled_bit, test_si, test_so, test_se );
  input [4:0] prescale;
  input [4:0] edge_count;
  input clk, reset, serial_data_in, enable, test_si, test_se;
  output sampled_bit, test_so;
  wire   sample_enable, N18, N19, N20, N21, N23, N25, N26, N27, N30, N31, N32,
         N33, n29, n30, n31, n32, \add_24_3/carry[2] , \add_24_3/carry[3] ,
         \add_24_3/carry[4] , \add_24_2/carry[4] , \add_24_2/carry[3] ,
         \add_24/carry[4] , \add_24/carry[3] , \add_24/carry[2] ,
         \sub_16/carry[4] , \sub_16/carry[3] , n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51;
  wire   [4:0] sampling_edge_number;
  wire   [2:0] samples;
  assign test_so = samples[2];
  assign N23 = prescale[0];

  SDFFRQX2M \samples_reg[0]  ( .D(n30), .SI(sample_enable), .SE(test_se), .CK(
        clk), .RN(reset), .Q(samples[0]) );
  SDFFRQX2M \samples_reg[1]  ( .D(n31), .SI(samples[0]), .SE(test_se), .CK(clk), .RN(n5), .Q(samples[1]) );
  SDFFRQX2M sample_enable_reg ( .D(n29), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(n5), .Q(sample_enable) );
  SDFFRQX2M \samples_reg[2]  ( .D(n32), .SI(samples[1]), .SE(test_se), .CK(clk), .RN(n5), .Q(samples[2]) );
  XNOR2X4M U7 ( .A(edge_count[4]), .B(N27), .Y(n16) );
  XNOR2X4M U8 ( .A(edge_count[3]), .B(N26), .Y(n14) );
  XNOR2X8M U9 ( .A(prescale[4]), .B(\sub_16/carry[4] ), .Y(
        sampling_edge_number[4]) );
  AOI21X6M U10 ( .A0(n6), .A1(n7), .B0(n8), .Y(sampled_bit) );
  XNOR2X8M U11 ( .A(\sub_16/carry[3] ), .B(prescale[3]), .Y(
        sampling_edge_number[3]) );
  XNOR2X8M U12 ( .A(prescale[1]), .B(prescale[2]), .Y(sampling_edge_number[2])
         );
  XOR2X2M U13 ( .A(sampling_edge_number[2]), .B(edge_count[2]), .Y(n51) );
  XOR2X1M U14 ( .A(sampling_edge_number[4]), .B(\add_24_3/carry[4] ), .Y(N33)
         );
  NAND2X2M U15 ( .A(enable), .B(n19), .Y(n12) );
  XNOR2X1M U16 ( .A(n45), .B(N23), .Y(n35) );
  NAND3X2M U17 ( .A(n37), .B(n38), .C(n39), .Y(n15) );
  NOR3X2M U18 ( .A(n40), .B(n41), .C(n42), .Y(n39) );
  NOR3X2M U19 ( .A(n49), .B(n50), .C(n51), .Y(n48) );
  MX2XLM U20 ( .A(samples[2]), .B(serial_data_in), .S0(n9), .Y(n32) );
  XOR2X2M U21 ( .A(sampling_edge_number[4]), .B(\add_24_2/carry[4] ), .Y(N27)
         );
  ADDHX1M U22 ( .A(sampling_edge_number[2]), .B(\add_24/carry[2] ), .CO(
        \add_24/carry[3] ), .S(N19) );
  ADDHX1M U23 ( .A(sampling_edge_number[3]), .B(\add_24/carry[3] ), .CO(
        \add_24/carry[4] ), .S(N20) );
  INVX4M U24 ( .A(prescale[1]), .Y(sampling_edge_number[1]) );
  ADDHX1M U29 ( .A(sampling_edge_number[1]), .B(N23), .CO(\add_24/carry[2] ), 
        .S(N18) );
  XNOR2X2M U30 ( .A(n34), .B(sampling_edge_number[1]), .Y(n43) );
  BUFX2M U31 ( .A(reset), .Y(n5) );
  XNOR2X2M U32 ( .A(edge_count[0]), .B(N23), .Y(n40) );
  AND2X1M U33 ( .A(\add_24_3/carry[3] ), .B(sampling_edge_number[3]), .Y(
        \add_24_3/carry[4] ) );
  CLKXOR2X2M U34 ( .A(sampling_edge_number[3]), .B(\add_24_3/carry[3] ), .Y(
        N32) );
  AND2X1M U35 ( .A(\add_24_3/carry[2] ), .B(sampling_edge_number[2]), .Y(
        \add_24_3/carry[3] ) );
  CLKXOR2X2M U36 ( .A(sampling_edge_number[2]), .B(\add_24_3/carry[2] ), .Y(
        N31) );
  OR2X1M U37 ( .A(sampling_edge_number[1]), .B(N23), .Y(\add_24_3/carry[2] )
         );
  XNOR2X1M U38 ( .A(N23), .B(sampling_edge_number[1]), .Y(N30) );
  AND2X1M U39 ( .A(\add_24_2/carry[3] ), .B(sampling_edge_number[3]), .Y(
        \add_24_2/carry[4] ) );
  CLKXOR2X2M U40 ( .A(sampling_edge_number[3]), .B(\add_24_2/carry[3] ), .Y(
        N26) );
  AND2X1M U41 ( .A(sampling_edge_number[1]), .B(sampling_edge_number[2]), .Y(
        \add_24_2/carry[3] ) );
  CLKXOR2X2M U42 ( .A(sampling_edge_number[2]), .B(sampling_edge_number[1]), 
        .Y(N25) );
  OR2X1M U43 ( .A(prescale[3]), .B(\sub_16/carry[3] ), .Y(\sub_16/carry[4] )
         );
  OR2X1M U44 ( .A(prescale[2]), .B(prescale[1]), .Y(\sub_16/carry[3] ) );
  CLKXOR2X2M U45 ( .A(\add_24/carry[4] ), .B(sampling_edge_number[4]), .Y(N21)
         );
  OAI21X1M U46 ( .A0(samples[0]), .A1(samples[1]), .B0(samples[2]), .Y(n7) );
  CLKNAND2X2M U47 ( .A(samples[1]), .B(samples[0]), .Y(n6) );
  NOR4X1M U48 ( .A(n10), .B(n11), .C(n12), .D(n13), .Y(n9) );
  NAND3X1M U49 ( .A(n14), .B(n15), .C(n16), .Y(n10) );
  CLKMX2X2M U50 ( .A(samples[1]), .B(serial_data_in), .S0(n17), .Y(n31) );
  NOR2X1M U51 ( .A(n12), .B(n15), .Y(n17) );
  CLKMX2X2M U52 ( .A(samples[0]), .B(serial_data_in), .S0(n18), .Y(n30) );
  NOR2BX1M U53 ( .AN(enable), .B(n19), .Y(n18) );
  OAI22X1M U54 ( .A0(n20), .A1(n21), .B0(enable), .B1(n8), .Y(n29) );
  CLKINVX1M U55 ( .A(sample_enable), .Y(n8) );
  NAND4X1M U56 ( .A(n22), .B(n23), .C(n24), .D(n33), .Y(n21) );
  CLKXOR2X2M U57 ( .A(n34), .B(N30), .Y(n33) );
  XNOR2X1M U58 ( .A(edge_count[2]), .B(N31), .Y(n24) );
  XNOR2X1M U59 ( .A(edge_count[3]), .B(N32), .Y(n23) );
  XNOR2X1M U60 ( .A(edge_count[4]), .B(N33), .Y(n22) );
  NAND4BX1M U61 ( .AN(n12), .B(n35), .C(n36), .D(n15), .Y(n20) );
  CLKXOR2X2M U62 ( .A(edge_count[2]), .B(N19), .Y(n42) );
  CLKXOR2X2M U63 ( .A(edge_count[1]), .B(N18), .Y(n41) );
  XNOR2X1M U64 ( .A(edge_count[3]), .B(N20), .Y(n38) );
  XNOR2X1M U65 ( .A(edge_count[4]), .B(N21), .Y(n37) );
  NAND4BBX1M U66 ( .AN(n13), .BN(n11), .C(n16), .D(n14), .Y(n36) );
  CLKNAND2X2M U67 ( .A(n43), .B(n44), .Y(n11) );
  CLKXOR2X2M U68 ( .A(n45), .B(N23), .Y(n44) );
  CLKINVX1M U69 ( .A(edge_count[1]), .Y(n34) );
  CLKXOR2X2M U70 ( .A(edge_count[2]), .B(N25), .Y(n13) );
  CLKINVX1M U71 ( .A(edge_count[0]), .Y(n45) );
  NAND3X1M U72 ( .A(n46), .B(n47), .C(n48), .Y(n19) );
  CLKXOR2X2M U73 ( .A(sampling_edge_number[1]), .B(edge_count[1]), .Y(n50) );
  CLKXOR2X2M U74 ( .A(N23), .B(edge_count[0]), .Y(n49) );
  XNOR2X1M U75 ( .A(edge_count[3]), .B(sampling_edge_number[3]), .Y(n47) );
  XNOR2X1M U76 ( .A(edge_count[4]), .B(sampling_edge_number[4]), .Y(n46) );
endmodule


module deserializer_test_1 ( clk, reset, enable, data_index, sampled_bit, 
        parallel_data, test_si, test_se );
  input [2:0] data_index;
  output [7:0] parallel_data;
  input clk, reset, enable, sampled_bit, test_si, test_se;
  wire   n62, n64, n65, n68, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n9, n35, n37, n39, n41, n43, n45, n47, n57, n58, n59, n60;

  SDFFRQX2M \parallel_data_reg[6]  ( .D(n33), .SI(parallel_data[5]), .SE(
        test_se), .CK(clk), .RN(n57), .Q(n62) );
  SDFFRQX2M \parallel_data_reg[4]  ( .D(n31), .SI(parallel_data[3]), .SE(
        test_se), .CK(clk), .RN(n57), .Q(n64) );
  SDFFRQX2M \parallel_data_reg[0]  ( .D(n27), .SI(test_si), .SE(test_se), .CK(
        clk), .RN(n57), .Q(n68) );
  SDFFRQX2M \parallel_data_reg[3]  ( .D(n30), .SI(parallel_data[2]), .SE(
        test_se), .CK(clk), .RN(n57), .Q(n65) );
  NAND2X2M U10 ( .A(data_index[1]), .B(data_index[0]), .Y(n19) );
  CLKINVX32M U12 ( .A(n9), .Y(parallel_data[2]) );
  CLKINVX32M U14 ( .A(n35), .Y(parallel_data[1]) );
  CLKINVX32M U16 ( .A(n37), .Y(parallel_data[5]) );
  INVX2M U17 ( .A(n64), .Y(n39) );
  CLKINVX32M U18 ( .A(n39), .Y(parallel_data[4]) );
  INVX2M U19 ( .A(n68), .Y(n41) );
  CLKINVX32M U20 ( .A(n41), .Y(parallel_data[0]) );
  INVX2M U21 ( .A(n65), .Y(n43) );
  CLKINVX32M U22 ( .A(n43), .Y(parallel_data[3]) );
  CLKINVX32M U24 ( .A(n45), .Y(parallel_data[7]) );
  INVX2M U25 ( .A(n62), .Y(n47) );
  CLKINVX32M U26 ( .A(n47), .Y(parallel_data[6]) );
  NAND2X2M U35 ( .A(data_index[0]), .B(n60), .Y(n15) );
  NAND2X2M U36 ( .A(data_index[1]), .B(n59), .Y(n17) );
  NAND2BX2M U37 ( .AN(n14), .B(sampled_bit), .Y(n12) );
  NAND2BX2M U38 ( .AN(n23), .B(sampled_bit), .Y(n21) );
  NAND2X2M U39 ( .A(n60), .B(n59), .Y(n11) );
  INVX4M U40 ( .A(n58), .Y(n57) );
  INVX2M U41 ( .A(reset), .Y(n58) );
  NAND2BX4M U42 ( .AN(data_index[2]), .B(enable), .Y(n14) );
  OAI21X2M U43 ( .A0(n12), .A1(n15), .B0(n16), .Y(n28) );
  OAI21X1M U44 ( .A0(n14), .A1(n15), .B0(parallel_data[1]), .Y(n16) );
  OAI21X2M U45 ( .A0(n12), .A1(n17), .B0(n18), .Y(n29) );
  OAI21X1M U46 ( .A0(n14), .A1(n17), .B0(parallel_data[2]), .Y(n18) );
  OAI21X2M U47 ( .A0(n12), .A1(n19), .B0(n20), .Y(n30) );
  OAI21X1M U48 ( .A0(n14), .A1(n19), .B0(parallel_data[3]), .Y(n20) );
  NAND2X4M U49 ( .A(data_index[2]), .B(enable), .Y(n23) );
  OAI21X2M U50 ( .A0(n11), .A1(n21), .B0(n22), .Y(n31) );
  OAI21X1M U51 ( .A0(n11), .A1(n23), .B0(parallel_data[4]), .Y(n22) );
  OAI21X2M U52 ( .A0(n15), .A1(n21), .B0(n24), .Y(n32) );
  OAI21X1M U53 ( .A0(n15), .A1(n23), .B0(parallel_data[5]), .Y(n24) );
  OAI21X2M U54 ( .A0(n17), .A1(n21), .B0(n25), .Y(n33) );
  OAI21X1M U55 ( .A0(n17), .A1(n23), .B0(parallel_data[6]), .Y(n25) );
  OAI21X2M U56 ( .A0(n19), .A1(n21), .B0(n26), .Y(n34) );
  OAI21X1M U57 ( .A0(n19), .A1(n23), .B0(parallel_data[7]), .Y(n26) );
  OAI21X2M U58 ( .A0(n11), .A1(n12), .B0(n13), .Y(n27) );
  OAI21X1M U59 ( .A0(n14), .A1(n11), .B0(parallel_data[0]), .Y(n13) );
  INVX2M U60 ( .A(data_index[1]), .Y(n60) );
  INVX2M U61 ( .A(data_index[0]), .Y(n59) );
  SDFFRX1M \parallel_data_reg[5]  ( .D(n32), .SI(parallel_data[4]), .SE(
        test_se), .CK(clk), .RN(n57), .QN(n37) );
  SDFFRX1M \parallel_data_reg[7]  ( .D(n34), .SI(parallel_data[6]), .SE(
        test_se), .CK(clk), .RN(n57), .QN(n45) );
  SDFFRX1M \parallel_data_reg[2]  ( .D(n29), .SI(parallel_data[1]), .SE(
        test_se), .CK(clk), .RN(n57), .QN(n9) );
  SDFFRX1M \parallel_data_reg[1]  ( .D(n28), .SI(parallel_data[0]), .SE(
        test_se), .CK(clk), .RN(n57), .QN(n35) );
endmodule


module edge_counter_test_1 ( clk, reset, prescale, enable, edge_count, 
        edge_count_done, test_si, test_se );
  input [5:0] prescale;
  output [4:0] edge_count;
  input clk, reset, enable, test_si, test_se;
  output edge_count_done;
  wire   n36, N10, N11, N12, N14, N15, N16, N17, N18, n9, n10, n11, n12, n13,
         n14, \add_16/carry[4] , \add_16/carry[3] , \add_16/carry[2] , n6, n8,
         n16, n18, n20, n27, n28, n29, n31, n32;

  INVX2M U8 ( .A(n29), .Y(n28) );
  INVX4M U10 ( .A(n6), .Y(edge_count[4]) );
  INVX4M U12 ( .A(n8), .Y(edge_count[3]) );
  INVX4M U14 ( .A(n16), .Y(edge_count[2]) );
  INVX4M U16 ( .A(n18), .Y(edge_count[1]) );
  INVX6M U18 ( .A(n20), .Y(edge_count[0]) );
  NAND2X4M U24 ( .A(enable), .B(n9), .Y(n10) );
  NOR2BX2M U25 ( .AN(N12), .B(n10), .Y(N17) );
  NOR2BX2M U26 ( .AN(N11), .B(n10), .Y(N16) );
  NOR2BX2M U27 ( .AN(N10), .B(n10), .Y(N15) );
  INVX2M U28 ( .A(n9), .Y(edge_count_done) );
  INVX2M U29 ( .A(prescale[4]), .Y(n32) );
  INVX2M U30 ( .A(prescale[5]), .Y(n31) );
  INVX2M U31 ( .A(reset), .Y(n29) );
  AOI32X1M U32 ( .A0(edge_count[4]), .A1(n32), .A2(prescale[5]), .B0(
        prescale[4]), .B1(n31), .Y(n14) );
  NAND4X2M U33 ( .A(edge_count[1]), .B(edge_count[0]), .C(edge_count[2]), .D(
        n11), .Y(n9) );
  NOR4X2M U34 ( .A(prescale[2]), .B(prescale[1]), .C(prescale[0]), .D(n12), 
        .Y(n11) );
  AOI32X1M U35 ( .A0(n32), .A1(n31), .A2(prescale[3]), .B0(n13), .B1(
        edge_count[3]), .Y(n12) );
  NOR2X2M U36 ( .A(prescale[3]), .B(n14), .Y(n13) );
  NOR2X2M U37 ( .A(n27), .B(n10), .Y(N18) );
  XNOR2X2M U38 ( .A(\add_16/carry[4] ), .B(edge_count[4]), .Y(n27) );
  NOR2X2M U39 ( .A(edge_count[0]), .B(n10), .Y(N14) );
  ADDHX1M U40 ( .A(edge_count[0]), .B(edge_count[1]), .CO(\add_16/carry[2] ), 
        .S(N10) );
  ADDHX1M U41 ( .A(edge_count[2]), .B(\add_16/carry[2] ), .CO(
        \add_16/carry[3] ), .S(N11) );
  ADDHX1M U42 ( .A(edge_count[3]), .B(\add_16/carry[3] ), .CO(
        \add_16/carry[4] ), .S(N12) );
  SDFFRX1M \edge_count_reg[4]  ( .D(N18), .SI(edge_count[3]), .SE(test_se), 
        .CK(clk), .RN(reset), .QN(n6) );
  SDFFRX1M \edge_count_reg[0]  ( .D(N14), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(reset), .QN(n20) );
  SDFFRX1M \edge_count_reg[3]  ( .D(N17), .SI(edge_count[2]), .SE(test_se), 
        .CK(clk), .RN(n28), .QN(n8) );
  SDFFRX1M \edge_count_reg[2]  ( .D(N16), .SI(n36), .SE(test_se), .CK(clk), 
        .RN(n28), .QN(n16) );
  SDFFRX1M \edge_count_reg[1]  ( .D(N15), .SI(edge_count[0]), .SE(test_se), 
        .CK(clk), .RN(n28), .Q(n36), .QN(n18) );
endmodule


module start_bit_checker_test_1 ( clk, reset, enable, sampled_bit, 
        start_bit_error, test_si, test_se );
  input clk, reset, enable, sampled_bit, test_si, test_se;
  output start_bit_error;
  wire   n2;

  SDFFRQX2M start_bit_error_reg ( .D(n2), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(reset), .Q(start_bit_error) );
  AO2B2XLM U4 ( .B0(sampled_bit), .B1(enable), .A0(start_bit_error), .A1N(
        enable), .Y(n2) );
endmodule


module parity_bit_checker_test_1 ( clk, reset, parity_type, enable, 
        sampled_bit, parallel_data, parity_bit_error, test_si, test_se );
  input [7:0] parallel_data;
  input clk, reset, parity_type, enable, sampled_bit, test_si, test_se;
  output parity_bit_error;
  wire   n1, n3, n4, n5, n6, n9, n2, n11, n12;

  XNOR2X2M U2 ( .A(parallel_data[7]), .B(parallel_data[6]), .Y(n6) );
  CLKINVX32M U4 ( .A(n2), .Y(parity_bit_error) );
  XNOR2X1M U6 ( .A(sampled_bit), .B(parity_type), .Y(n5) );
  XNOR3XLM U7 ( .A(parallel_data[1]), .B(parallel_data[0]), .C(n11), .Y(n3) );
  OAI2BB2X1M U8 ( .B0(n1), .B1(n12), .A0N(parity_bit_error), .A1N(n12), .Y(n9)
         );
  XOR3XLM U9 ( .A(n3), .B(n4), .C(n5), .Y(n1) );
  INVX2M U11 ( .A(enable), .Y(n12) );
  XOR3XLM U12 ( .A(parallel_data[5]), .B(parallel_data[4]), .C(n6), .Y(n4) );
  CLKXOR2X2M U13 ( .A(parallel_data[3]), .B(parallel_data[2]), .Y(n11) );
  SDFFRX1M parity_bit_error_reg ( .D(n9), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(reset), .QN(n2) );
endmodule


module stop_bit_checker_test_1 ( clk, reset, enable, sampled_bit, 
        stop_bit_error, test_si, test_so, test_se );
  input clk, reset, enable, sampled_bit, test_si, test_se;
  output stop_bit_error, test_so;
  wire   n7, n3, n1, n6;
  assign test_so = n7;

  CLKINVX32M U3 ( .A(n1), .Y(stop_bit_error) );
  OAI2BB2X1M U6 ( .B0(sampled_bit), .B1(n6), .A0N(stop_bit_error), .A1N(n6), 
        .Y(n3) );
  INVX2M U7 ( .A(enable), .Y(n6) );
  SDFFRX1M stop_bit_error_reg ( .D(n3), .SI(test_si), .SE(test_se), .CK(clk), 
        .RN(reset), .Q(n7), .QN(n1) );
endmodule


module UART_receiver ( clk, reset, parity_type, parity_enable, prescale, 
        serial_data_in, scan_clk, scan_reset, test_mode, SE, SI, SO, 
        parallel_data, data_valid, parity_error, frame_error );
  input [5:0] prescale;
  output [7:0] parallel_data;
  input clk, reset, parity_type, parity_enable, serial_data_in, scan_clk,
         scan_reset, test_mode, SE, SI;
  output SO, data_valid, parity_error, frame_error;
  wire   multiplexed_clk, multiplexed_reset, start_bit_error, edge_count_done,
         start_bit_check_enable, parity_bit_check_enable,
         stop_bit_check_enable, edge_counter_and_data_sampler_enable,
         deserializer_enable, sampled_bit, n1, n2, n3, n4, n5, n6, n7, n10,
         n11;
  wire   [4:0] edge_count;
  wire   [2:0] data_index;

  BUFX6M U1 ( .A(prescale[1]), .Y(n1) );
  CLKBUFX6M U3 ( .A(prescale[2]), .Y(n2) );
  BUFX4M U4 ( .A(prescale[3]), .Y(n3) );
  BUFX4M U5 ( .A(prescale[4]), .Y(n4) );
  BUFX4M U6 ( .A(prescale[5]), .Y(n5) );
  INVX2M U7 ( .A(multiplexed_reset), .Y(n7) );
  multiplexer_2x1_0 U_clock_multiplexer ( .IN0(clk), .IN1(scan_clk), .select(
        test_mode), .OUT(multiplexed_clk) );
  multiplexer_2x1_1 U_reset_multiplexer ( .IN0(reset), .IN1(scan_reset), 
        .select(test_mode), .OUT(multiplexed_reset) );
  UART_receiver_FSM_test_1 U_UART_receiver_FSM ( .clk(multiplexed_clk), 
        .reset(n6), .parity_enable(parity_enable), .serial_data_in(serial_data_in), 
        .prescale({n5, n4, n3, n2, n1, prescale[0]}), .start_bit_error(
        start_bit_error), .parity_bit_error(parity_error), .stop_bit_error(
        frame_error), .edge_count(edge_count), .edge_count_done(
        edge_count_done), .start_bit_check_enable(start_bit_check_enable), 
        .parity_bit_check_enable(parity_bit_check_enable), 
        .stop_bit_check_enable(stop_bit_check_enable), 
        .edge_counter_and_data_sampler_enable(
        edge_counter_and_data_sampler_enable), .deserializer_enable(
        deserializer_enable), .data_index(data_index), .data_valid(data_valid), 
        .test_si(SI), .test_so(n11), .test_se(SE) );
  data_sampler_test_1 U_data_sampler ( .clk(multiplexed_clk), .reset(n6), 
        .serial_data_in(serial_data_in), .prescale({n5, n4, n3, n2, n1}), .enable(
        edge_counter_and_data_sampler_enable), .edge_count(edge_count), 
        .sampled_bit(sampled_bit), .test_si(n11), .test_so(n10), .test_se(SE)
         );
  deserializer_test_1 U_deserializer ( .clk(multiplexed_clk), .reset(n6), 
        .enable(deserializer_enable), .data_index(data_index), .sampled_bit(
        sampled_bit), .parallel_data(parallel_data), .test_si(n10), .test_se(
        SE) );
  edge_counter_test_1 U_edge_counter ( .clk(multiplexed_clk), .reset(n6), 
        .prescale({n5, n4, n3, n2, n1, prescale[0]}), .enable(
        edge_counter_and_data_sampler_enable), .edge_count(edge_count), 
        .edge_count_done(edge_count_done), .test_si(parallel_data[7]), 
        .test_se(SE) );
  start_bit_checker_test_1 U_start_bit_checker ( .clk(multiplexed_clk), 
        .reset(n6), .enable(start_bit_check_enable), .sampled_bit(sampled_bit), 
        .start_bit_error(start_bit_error), .test_si(parity_error), .test_se(SE) );
  parity_bit_checker_test_1 U_parity_bit_checker ( .clk(multiplexed_clk), 
        .reset(n6), .parity_type(parity_type), .enable(parity_bit_check_enable), .sampled_bit(sampled_bit), .parallel_data(parallel_data), .parity_bit_error(
        parity_error), .test_si(edge_count[4]), .test_se(SE) );
  stop_bit_checker_test_1 U_stop_bit_checker ( .clk(multiplexed_clk), .reset(
        n6), .enable(stop_bit_check_enable), .sampled_bit(sampled_bit), 
        .stop_bit_error(frame_error), .test_si(start_bit_error), .test_so(SO), 
        .test_se(SE) );
  INVX6M U2 ( .A(n7), .Y(n6) );
endmodule

