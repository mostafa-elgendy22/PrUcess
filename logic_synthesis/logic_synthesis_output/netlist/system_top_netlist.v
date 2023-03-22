/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : K-2015.06
// Date      : Wed Mar 22 21:12:39 2023
/////////////////////////////////////////////////////////////


module reset_synchronizer_0 ( clk, reset, reset_synchronized );
  input clk, reset;
  output reset_synchronized;
  wire   \Q[0] , n1;

  DFFRQX1M \Q_reg[0]  ( .D(1'b1), .CK(clk), .RN(reset), .Q(\Q[0] ) );
  DFFSX1M \Q_reg[1]  ( .D(n1), .CK(clk), .SN(reset), .QN(reset_synchronized)
         );
  CLKINVX1M U4 ( .A(\Q[0] ), .Y(n1) );
endmodule


module UART_transmitter_controller ( clk, reset, ALU_result_valid, ALU_result, 
        read_data_valid, read_data, transmitter_busy_synchronized, 
        transmitter_Q_pulse_generator, transmitter_parallel_data_valid, 
        transmitter_parallel_data, UART_receiver_controller_enable );
  input [15:0] ALU_result;
  input [7:0] read_data;
  output [7:0] transmitter_parallel_data;
  input clk, reset, ALU_result_valid, read_data_valid,
         transmitter_busy_synchronized, transmitter_Q_pulse_generator;
  output transmitter_parallel_data_valid, UART_receiver_controller_enable;
  wire   N62, D_UART_receiver_controller_enable, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n40;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  wire   [15:0] message;
  wire   [1:0] transmission_current_state;
  wire   [1:0] transmission_next_state;
  assign N62 = read_data_valid;

  DFFRQX1M \current_state_reg[2]  ( .D(next_state[2]), .CK(clk), .RN(reset), 
        .Q(current_state[2]) );
  DFFRQX1M \current_state_reg[1]  ( .D(next_state[1]), .CK(clk), .RN(reset), 
        .Q(current_state[1]) );
  DFFRQX1M \current_state_reg[0]  ( .D(next_state[0]), .CK(clk), .RN(reset), 
        .Q(current_state[0]) );
  DFFRQX1M \transmission_current_state_reg[1]  ( .D(transmission_next_state[1]), .CK(clk), .RN(reset), .Q(transmission_current_state[1]) );
  DFFRQX1M \transmission_current_state_reg[0]  ( .D(transmission_next_state[0]), .CK(clk), .RN(reset), .Q(transmission_current_state[0]) );
  DFFRQX1M \message_reg[15]  ( .D(n39), .CK(clk), .RN(reset), .Q(message[15])
         );
  DFFRQX1M \message_reg[14]  ( .D(n38), .CK(clk), .RN(reset), .Q(message[14])
         );
  DFFRQX1M \message_reg[13]  ( .D(n37), .CK(clk), .RN(reset), .Q(message[13])
         );
  DFFRQX1M \message_reg[12]  ( .D(n36), .CK(clk), .RN(reset), .Q(message[12])
         );
  DFFRQX1M \message_reg[11]  ( .D(n35), .CK(clk), .RN(reset), .Q(message[11])
         );
  DFFRQX1M \message_reg[10]  ( .D(n34), .CK(clk), .RN(reset), .Q(message[10])
         );
  DFFRQX1M \message_reg[9]  ( .D(n33), .CK(clk), .RN(reset), .Q(message[9]) );
  DFFRQX1M \message_reg[8]  ( .D(n32), .CK(clk), .RN(reset), .Q(message[8]) );
  DFFRQX1M \message_reg[7]  ( .D(n31), .CK(clk), .RN(reset), .Q(message[7]) );
  DFFRQX1M \message_reg[6]  ( .D(n30), .CK(clk), .RN(reset), .Q(message[6]) );
  DFFRQX1M \message_reg[5]  ( .D(n29), .CK(clk), .RN(reset), .Q(message[5]) );
  DFFRQX1M \message_reg[4]  ( .D(n28), .CK(clk), .RN(reset), .Q(message[4]) );
  DFFRQX1M \message_reg[3]  ( .D(n27), .CK(clk), .RN(reset), .Q(message[3]) );
  DFFRQX1M \message_reg[2]  ( .D(n26), .CK(clk), .RN(reset), .Q(message[2]) );
  DFFRQX1M \message_reg[1]  ( .D(n25), .CK(clk), .RN(reset), .Q(message[1]) );
  DFFRQX1M \message_reg[0]  ( .D(n24), .CK(clk), .RN(reset), .Q(message[0]) );
  DFFSQX2M UART_receiver_controller_enable_reg ( .D(
        D_UART_receiver_controller_enable), .CK(clk), .SN(reset), .Q(
        UART_receiver_controller_enable) );
  CLKINVX1M U3 ( .A(n16), .Y(n12) );
  CLKINVX1M U4 ( .A(transmitter_busy_synchronized), .Y(n21) );
  NOR2XLM U5 ( .A(transmission_current_state[1]), .B(n21), .Y(
        transmission_next_state[0]) );
  NOR3BXLM U6 ( .AN(transmission_current_state[0]), .B(
        transmission_current_state[1]), .C(transmitter_busy_synchronized), .Y(
        transmission_next_state[1]) );
  NOR2BXLM U7 ( .AN(transmission_current_state[1]), .B(
        transmission_current_state[0]), .Y(n20) );
  NOR2XLM U8 ( .A(current_state[0]), .B(current_state[1]), .Y(n22) );
  NAND2XLM U9 ( .A(current_state[2]), .B(n22), .Y(n10) );
  NAND3BXLM U10 ( .AN(transmitter_Q_pulse_generator), .B(current_state[1]), 
        .C(current_state[0]), .Y(n1) );
  OAI22XLM U11 ( .A0(n20), .A1(n10), .B0(current_state[2]), .B1(n1), .Y(
        next_state[2]) );
  NOR2XLM U12 ( .A(N62), .B(ALU_result_valid), .Y(n13) );
  NAND2BXLM U13 ( .AN(N62), .B(ALU_result_valid), .Y(n16) );
  AOI222XLM U14 ( .A0(N62), .A1(read_data[6]), .B0(message[6]), .B1(n13), .C0(
        n12), .C1(ALU_result[6]), .Y(n2) );
  CLKINVX1M U15 ( .A(n2), .Y(n30) );
  AOI222XLM U16 ( .A0(N62), .A1(read_data[7]), .B0(message[7]), .B1(n13), .C0(
        n12), .C1(ALU_result[7]), .Y(n3) );
  CLKINVX1M U17 ( .A(n3), .Y(n31) );
  AOI222XLM U18 ( .A0(N62), .A1(read_data[1]), .B0(message[1]), .B1(n13), .C0(
        n12), .C1(ALU_result[1]), .Y(n4) );
  CLKINVX1M U19 ( .A(n4), .Y(n25) );
  AOI222XLM U20 ( .A0(N62), .A1(read_data[3]), .B0(message[3]), .B1(n13), .C0(
        n12), .C1(ALU_result[3]), .Y(n5) );
  CLKINVX1M U21 ( .A(n5), .Y(n27) );
  AOI222XLM U22 ( .A0(N62), .A1(read_data[2]), .B0(message[2]), .B1(n13), .C0(
        n12), .C1(ALU_result[2]), .Y(n6) );
  CLKINVX1M U23 ( .A(n6), .Y(n26) );
  AOI222XLM U24 ( .A0(N62), .A1(read_data[0]), .B0(message[0]), .B1(n13), .C0(
        n12), .C1(ALU_result[0]), .Y(n7) );
  CLKINVX1M U25 ( .A(n7), .Y(n24) );
  AOI222XLM U26 ( .A0(N62), .A1(read_data[5]), .B0(message[5]), .B1(n13), .C0(
        n12), .C1(ALU_result[5]), .Y(n8) );
  CLKINVX1M U27 ( .A(n8), .Y(n29) );
  AOI222XLM U28 ( .A0(N62), .A1(read_data[4]), .B0(message[4]), .B1(n13), .C0(
        n12), .C1(ALU_result[4]), .Y(n9) );
  CLKINVX1M U29 ( .A(n9), .Y(n28) );
  AOI211XLM U30 ( .A0(current_state[0]), .A1(current_state[1]), .B0(
        current_state[2]), .C0(n22), .Y(n15) );
  NAND2BXLM U31 ( .AN(n15), .B(n10), .Y(transmitter_parallel_data_valid) );
  NOR2XLM U32 ( .A(current_state[2]), .B(n22), .Y(n11) );
  CLKINVX1M U33 ( .A(n10), .Y(n14) );
  NOR2XLM U34 ( .A(n11), .B(n14), .Y(D_UART_receiver_controller_enable) );
  AO22XLM U35 ( .A0(message[15]), .A1(n13), .B0(n12), .B1(ALU_result[15]), .Y(
        n39) );
  AO22XLM U36 ( .A0(message[14]), .A1(n13), .B0(n12), .B1(ALU_result[14]), .Y(
        n38) );
  AO22XLM U37 ( .A0(message[13]), .A1(n13), .B0(n12), .B1(ALU_result[13]), .Y(
        n37) );
  AO22XLM U38 ( .A0(message[12]), .A1(n13), .B0(n12), .B1(ALU_result[12]), .Y(
        n36) );
  AO22XLM U39 ( .A0(message[11]), .A1(n13), .B0(n12), .B1(ALU_result[11]), .Y(
        n35) );
  AO22XLM U40 ( .A0(message[10]), .A1(n13), .B0(n12), .B1(ALU_result[10]), .Y(
        n34) );
  AO22XLM U41 ( .A0(message[9]), .A1(n13), .B0(n12), .B1(ALU_result[9]), .Y(
        n33) );
  AO22XLM U42 ( .A0(message[8]), .A1(n13), .B0(n12), .B1(ALU_result[8]), .Y(
        n32) );
  AO22XLM U43 ( .A0(n15), .A1(message[7]), .B0(n14), .B1(message[15]), .Y(
        transmitter_parallel_data[7]) );
  AO22XLM U44 ( .A0(n15), .A1(message[6]), .B0(n14), .B1(message[14]), .Y(
        transmitter_parallel_data[6]) );
  AO22XLM U45 ( .A0(n15), .A1(message[5]), .B0(n14), .B1(message[13]), .Y(
        transmitter_parallel_data[5]) );
  AO22XLM U46 ( .A0(n15), .A1(message[4]), .B0(n14), .B1(message[12]), .Y(
        transmitter_parallel_data[4]) );
  AO22XLM U47 ( .A0(n15), .A1(message[3]), .B0(n14), .B1(message[11]), .Y(
        transmitter_parallel_data[3]) );
  AO22XLM U48 ( .A0(n15), .A1(message[2]), .B0(n14), .B1(message[10]), .Y(
        transmitter_parallel_data[2]) );
  AO22XLM U49 ( .A0(n15), .A1(message[1]), .B0(n14), .B1(message[9]), .Y(
        transmitter_parallel_data[1]) );
  AO22XLM U50 ( .A0(n15), .A1(message[0]), .B0(n14), .B1(message[8]), .Y(
        transmitter_parallel_data[0]) );
  NAND2BXLM U51 ( .AN(current_state[0]), .B(n21), .Y(n17) );
  OAI2B1XLM U52 ( .A1N(current_state[0]), .A0(transmitter_Q_pulse_generator), 
        .B0(current_state[1]), .Y(n18) );
  AOI221XLM U53 ( .A0(n17), .A1(n18), .B0(n16), .B1(n18), .C0(current_state[2]), .Y(next_state[1]) );
  OAI21XLM U54 ( .A0(n20), .A1(current_state[1]), .B0(n18), .Y(n19) );
  OAI21XLM U55 ( .A0(n20), .A1(current_state[0]), .B0(n19), .Y(n40) );
  NAND3XLM U56 ( .A(N62), .B(n22), .C(n21), .Y(n23) );
  AOI21XLM U57 ( .A0(n40), .A1(n23), .B0(current_state[2]), .Y(next_state[0])
         );
endmodule


module UART_receiver_controller ( clk, reset, enable, 
        parallel_data_valid_synchronized, parallel_data_synchronized, 
        ALU_function, ALU_enable, ALU_clk_enable, address, write_enable, 
        write_data, read_enable );
  input [7:0] parallel_data_synchronized;
  output [3:0] ALU_function;
  output [3:0] address;
  output [7:0] write_data;
  input clk, reset, enable, parallel_data_valid_synchronized;
  output ALU_enable, ALU_clk_enable, write_enable, read_enable;
  wire   N102, n36, n37, n38, n39, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33;
  wire   [2:0] current_state;
  wire   [2:0] next_state;
  wire   [3:0] Q_write_address_register;
  wire   [1:0] counter;

  DFFRQX1M \current_state_reg[0]  ( .D(next_state[0]), .CK(clk), .RN(reset), 
        .Q(current_state[0]) );
  DFFRQX1M \current_state_reg[2]  ( .D(next_state[2]), .CK(clk), .RN(reset), 
        .Q(current_state[2]) );
  DFFRQX1M \current_state_reg[1]  ( .D(next_state[1]), .CK(clk), .RN(reset), 
        .Q(current_state[1]) );
  DFFRQX1M \counter_reg[1]  ( .D(N102), .CK(clk), .RN(reset), .Q(counter[1])
         );
  DFFRQX1M \counter_reg[0]  ( .D(parallel_data_valid_synchronized), .CK(clk), 
        .RN(reset), .Q(counter[0]) );
  DFFRQX1M \Q_write_address_register_reg[0]  ( .D(n39), .CK(clk), .RN(reset), 
        .Q(Q_write_address_register[0]) );
  DFFRQX1M \Q_write_address_register_reg[1]  ( .D(n38), .CK(clk), .RN(reset), 
        .Q(Q_write_address_register[1]) );
  DFFRQX1M \Q_write_address_register_reg[2]  ( .D(n37), .CK(clk), .RN(reset), 
        .Q(Q_write_address_register[2]) );
  DFFRQX1M \Q_write_address_register_reg[3]  ( .D(n36), .CK(clk), .RN(reset), 
        .Q(Q_write_address_register[3]) );
  NOR2BXLM U3 ( .AN(n18), .B(n16), .Y(n3) );
  CLKINVX1M U4 ( .A(n2), .Y(read_enable) );
  NOR2XLM U5 ( .A(n3), .B(n4), .Y(write_data[5]) );
  NOR2XLM U6 ( .A(n29), .B(n22), .Y(ALU_function[0]) );
  NOR2XLM U7 ( .A(n28), .B(n19), .Y(n26) );
  CLKINVX1M U8 ( .A(parallel_data_valid_synchronized), .Y(n9) );
  NOR3XLM U9 ( .A(counter[1]), .B(counter[0]), .C(n9), .Y(n1) );
  CLKINVX1M U10 ( .A(current_state[1]), .Y(n19) );
  NAND3XLM U11 ( .A(current_state[2]), .B(n1), .C(n19), .Y(n18) );
  CLKINVX1M U12 ( .A(n1), .Y(n27) );
  NOR4XLM U13 ( .A(current_state[0]), .B(current_state[2]), .C(n19), .D(n27), 
        .Y(n16) );
  CLKINVX1M U14 ( .A(parallel_data_synchronized[2]), .Y(n31) );
  NOR2XLM U15 ( .A(n3), .B(n31), .Y(write_data[2]) );
  CLKINVX1M U16 ( .A(parallel_data_synchronized[1]), .Y(n30) );
  NOR2XLM U17 ( .A(n3), .B(n30), .Y(write_data[1]) );
  CLKINVX1M U18 ( .A(parallel_data_synchronized[3]), .Y(n32) );
  NOR2XLM U19 ( .A(n3), .B(n32), .Y(write_data[3]) );
  CLKINVX1M U20 ( .A(current_state[0]), .Y(n28) );
  CLKINVX1M U21 ( .A(current_state[2]), .Y(n25) );
  NAND3XLM U22 ( .A(n26), .B(n25), .C(n1), .Y(n2) );
  OAI2BB2XLM U23 ( .B0(n30), .B1(n2), .A0N(n16), .A1N(
        Q_write_address_register[1]), .Y(address[1]) );
  OAI2BB2XLM U24 ( .B0(n31), .B1(n2), .A0N(n16), .A1N(
        Q_write_address_register[2]), .Y(address[2]) );
  OAI2BB2XLM U25 ( .B0(n32), .B1(n2), .A0N(n16), .A1N(
        Q_write_address_register[3]), .Y(address[3]) );
  CLKINVX1M U26 ( .A(n3), .Y(write_enable) );
  NOR2XLM U27 ( .A(n25), .B(n19), .Y(n15) );
  CLKINVX1M U28 ( .A(n15), .Y(n21) );
  NOR2XLM U29 ( .A(n28), .B(n21), .Y(ALU_enable) );
  CLKINVX1M U30 ( .A(ALU_enable), .Y(n22) );
  NOR2XLM U31 ( .A(n32), .B(n22), .Y(ALU_function[3]) );
  NOR2XLM U32 ( .A(n31), .B(n22), .Y(ALU_function[2]) );
  CLKINVX1M U33 ( .A(parallel_data_synchronized[5]), .Y(n4) );
  AND2X1M U34 ( .A(parallel_data_synchronized[6]), .B(write_enable), .Y(
        write_data[6]) );
  CLKINVX1M U35 ( .A(parallel_data_synchronized[0]), .Y(n29) );
  NOR2XLM U36 ( .A(n3), .B(n29), .Y(write_data[0]) );
  AND2X1M U37 ( .A(parallel_data_synchronized[7]), .B(write_enable), .Y(
        write_data[7]) );
  CLKINVX1M U38 ( .A(parallel_data_synchronized[4]), .Y(n11) );
  NOR2XLM U39 ( .A(n3), .B(n11), .Y(write_data[4]) );
  NOR2XLM U40 ( .A(n30), .B(n22), .Y(ALU_function[1]) );
  AOI33XLM U41 ( .A0(parallel_data_valid_synchronized), .A1(current_state[0]), 
        .A2(n19), .B0(current_state[1]), .B1(n25), .B2(n9), .Y(n8) );
  NOR4XLM U42 ( .A(parallel_data_synchronized[2]), .B(
        parallel_data_synchronized[6]), .C(n30), .D(n4), .Y(n12) );
  AND4XLM U43 ( .A(parallel_data_synchronized[6]), .B(
        parallel_data_synchronized[2]), .C(n4), .D(n30), .Y(n24) );
  NOR2XLM U44 ( .A(n12), .B(n24), .Y(n6) );
  NOR4XLM U45 ( .A(current_state[2]), .B(current_state[0]), .C(
        current_state[1]), .D(n9), .Y(n5) );
  NAND4XLM U46 ( .A(enable), .B(parallel_data_synchronized[3]), .C(
        parallel_data_synchronized[7]), .D(n5), .Y(n10) );
  OR4X1M U47 ( .A(n6), .B(n10), .C(n29), .D(n11), .Y(n7) );
  OAI211XLM U48 ( .A0(current_state[0]), .A1(n21), .B0(n8), .C0(n7), .Y(
        next_state[1]) );
  NOR2XLM U49 ( .A(current_state[0]), .B(n9), .Y(n13) );
  AOI221XLM U50 ( .A0(parallel_data_synchronized[0]), .A1(n11), .B0(n29), .B1(
        parallel_data_synchronized[4]), .C0(n10), .Y(n23) );
  AOI22XLM U51 ( .A0(current_state[2]), .A1(n13), .B0(n12), .B1(n23), .Y(n14)
         );
  OAI31XLM U52 ( .A0(parallel_data_valid_synchronized), .A1(n15), .A2(n28), 
        .B0(n14), .Y(next_state[0]) );
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
        .A1N(n33), .Y(n39) );
  AOI2BB2XLM U61 ( .B0(n33), .B1(n30), .A0N(Q_write_address_register[1]), 
        .A1N(n33), .Y(n38) );
  AOI2BB2XLM U62 ( .B0(n33), .B1(n31), .A0N(Q_write_address_register[2]), 
        .A1N(n33), .Y(n37) );
  AOI2BB2XLM U63 ( .B0(n33), .B1(n32), .A0N(Q_write_address_register[3]), 
        .A1N(n33), .Y(n36) );
endmodule


module system_controller ( clk, reset, ALU_result_valid, ALU_result, 
        register_file_read_data_valid, register_file_read_data, 
        transmitter_busy_synchronized, transmitter_Q_pulse_generator, 
        receiver_parallel_data_valid_synchronized, 
        receiver_parallel_data_synchronized, ALU_function, ALU_enable, 
        ALU_clk_enable, transmitter_parallel_data_valid, 
        transmitter_parallel_data, register_file_address, 
        register_file_write_enable, register_file_write_data, 
        register_file_read_enable );
  input [15:0] ALU_result;
  input [7:0] register_file_read_data;
  input [7:0] receiver_parallel_data_synchronized;
  output [3:0] ALU_function;
  output [7:0] transmitter_parallel_data;
  output [3:0] register_file_address;
  output [7:0] register_file_write_data;
  input clk, reset, ALU_result_valid, register_file_read_data_valid,
         transmitter_busy_synchronized, transmitter_Q_pulse_generator,
         receiver_parallel_data_valid_synchronized;
  output ALU_enable, ALU_clk_enable, transmitter_parallel_data_valid,
         register_file_write_enable, register_file_read_enable;
  wire   receiver_controller_enable, n1;

  UART_transmitter_controller U_UART_transmitter_controller ( .clk(clk), 
        .reset(n1), .ALU_result_valid(ALU_result_valid), .ALU_result(
        ALU_result), .read_data_valid(register_file_read_data_valid), 
        .read_data(register_file_read_data), .transmitter_busy_synchronized(
        transmitter_busy_synchronized), .transmitter_Q_pulse_generator(
        transmitter_Q_pulse_generator), .transmitter_parallel_data_valid(
        transmitter_parallel_data_valid), .transmitter_parallel_data(
        transmitter_parallel_data), .UART_receiver_controller_enable(
        receiver_controller_enable) );
  UART_receiver_controller U_UART_receiver_controller ( .clk(clk), .reset(n1), 
        .enable(receiver_controller_enable), 
        .parallel_data_valid_synchronized(
        receiver_parallel_data_valid_synchronized), 
        .parallel_data_synchronized(receiver_parallel_data_synchronized), 
        .ALU_function(ALU_function), .ALU_enable(ALU_enable), .ALU_clk_enable(
        ALU_clk_enable), .address(register_file_address), .write_enable(
        register_file_write_enable), .write_data(register_file_write_data), 
        .read_enable(register_file_read_enable) );
  BUFX2M U1 ( .A(reset), .Y(n1) );
endmodule


module clock_gating_cell ( clk, clk_enable, gated_clock );
  input clk, clk_enable;
  output gated_clock;


  TLATNCAX4M U_ICG_cell ( .E(clk_enable), .CK(clk), .ECK(gated_clock) );
endmodule


module ALU ( clk, reset, A, B, ALU_function, enable, ALU_result_valid, 
        ALU_result );
  input [7:0] A;
  input [7:0] B;
  input [3:0] ALU_function;
  output [15:0] ALU_result;
  input clk, reset, enable;
  output ALU_result_valid;
  wire   N179, N180, N181, N182, N183, N184, N185, N186, N187, N188, N189,
         N190, N191, N192, N193, N194, \C7M/DATA15_0 , \C7M/DATA15_1 ,
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
         n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155,
         n156, n157, n158, n159, n160, n161, n162, n163, n164, n165, n166,
         n167, n168, n169, n170, n171, n172, n173, n174, n175, n176, n177,
         n178, n179, n180, n181, n182, n183, n184, n185, n186, n187, n188,
         n189, n190, n191, n192, n193, n194, n195, n196, n197, n198, n199,
         n200, n201, n202, n203, n204, n205, n206, n207, n208, n209, n210,
         n211, n212, n213, n214, n215, n216, n217, n218, n219, n220, n221,
         n222, n223, n224, n225, n226, n227, n228, n229, n230, n231, n232,
         n233, n234, n235, n236, n237, n238, n239, n240, n241, n242, n243,
         n244, n245, n246, n247, n248, n249, n250, n251, n252, n253, n254,
         n255, n256, n257, n258, n259, n260, n261, n262, n263, n264, n265,
         n266, n267, n268, n269, n270, n271, n272, n273, n274, n275, n276,
         n277, n278, n279, n280, n281, n282, n283, n284, n285, n286, n287,
         n288, n289, n290, n291, n292, n293, n294, n295, n296, n297, n298,
         n299, n300, n301, n302, n303, n304, n305, n306, n307, n308, n309,
         n310, n311, n312, n313, n314, n315, n316, n317, n318, n319, n320,
         n321, n322, n323, n324, n325, n326, n327, n328, n329, n330, n331,
         n332, n333, n334, n335, n336, n337, n338, n339, n340, n341, n342,
         n343, n344, n345, n346, n347, n348, n349, n350, n351, n352, n353,
         n354, n355, n356, n357, n358, n359, n360, n361, n362, n363, n364,
         n365, n366, n367, n368, n369, n370, n371, n372, n373, n374;

  DFFRQX1M \ALU_result_reg[15]  ( .D(N194), .CK(clk), .RN(reset), .Q(
        ALU_result[15]) );
  DFFRQX1M \ALU_result_reg[14]  ( .D(N193), .CK(clk), .RN(reset), .Q(
        ALU_result[14]) );
  DFFRQX1M \ALU_result_reg[13]  ( .D(N192), .CK(clk), .RN(reset), .Q(
        ALU_result[13]) );
  DFFRQX1M \ALU_result_reg[12]  ( .D(N191), .CK(clk), .RN(reset), .Q(
        ALU_result[12]) );
  DFFRQX1M \ALU_result_reg[11]  ( .D(N190), .CK(clk), .RN(reset), .Q(
        ALU_result[11]) );
  DFFRQX1M \ALU_result_reg[10]  ( .D(N189), .CK(clk), .RN(reset), .Q(
        ALU_result[10]) );
  DFFRQX1M \ALU_result_reg[9]  ( .D(N188), .CK(clk), .RN(reset), .Q(
        ALU_result[9]) );
  DFFRQX1M \ALU_result_reg[8]  ( .D(N187), .CK(clk), .RN(reset), .Q(
        ALU_result[8]) );
  DFFRQX1M \ALU_result_reg[7]  ( .D(N186), .CK(clk), .RN(reset), .Q(
        ALU_result[7]) );
  DFFRQX1M \ALU_result_reg[6]  ( .D(N185), .CK(clk), .RN(reset), .Q(
        ALU_result[6]) );
  DFFRQX1M \ALU_result_reg[5]  ( .D(N184), .CK(clk), .RN(reset), .Q(
        ALU_result[5]) );
  DFFRQX1M \ALU_result_reg[4]  ( .D(N183), .CK(clk), .RN(reset), .Q(
        ALU_result[4]) );
  DFFRQX1M \ALU_result_reg[3]  ( .D(N182), .CK(clk), .RN(reset), .Q(
        ALU_result[3]) );
  DFFRQX1M \ALU_result_reg[2]  ( .D(N181), .CK(clk), .RN(reset), .Q(
        ALU_result[2]) );
  DFFRQX1M \ALU_result_reg[1]  ( .D(N180), .CK(clk), .RN(reset), .Q(
        ALU_result[1]) );
  DFFRQX1M \ALU_result_reg[0]  ( .D(N179), .CK(clk), .RN(reset), .Q(
        ALU_result[0]) );
  ADDFX1M \intadd_3/U3  ( .A(\intadd_3/A[2] ), .B(\intadd_3/B[2] ), .CI(
        \intadd_3/n3 ), .CO(\intadd_3/n2 ), .S(\intadd_3/SUM[2] ) );
  ADDFX1M \intadd_4/U3  ( .A(\intadd_0/SUM[0] ), .B(\intadd_4/B[1] ), .CI(
        \intadd_4/n3 ), .CO(\intadd_4/n2 ), .S(\intadd_1/A[2] ) );
  ADDFX1M \intadd_4/U2  ( .A(\intadd_0/SUM[1] ), .B(\intadd_3/SUM[2] ), .CI(
        \intadd_4/n2 ), .CO(\intadd_4/n1 ), .S(\intadd_1/B[3] ) );
  ADDFX1M \intadd_3/U2  ( .A(\intadd_3/A[3] ), .B(\intadd_0/SUM[2] ), .CI(
        \intadd_3/n2 ), .CO(\intadd_3/n1 ), .S(\intadd_1/B[4] ) );
  ADDFX1M \intadd_6/U3  ( .A(\intadd_1/SUM[0] ), .B(\intadd_6/B[1] ), .CI(
        \intadd_6/n3 ), .CO(\intadd_6/n2 ), .S(\intadd_6/SUM[1] ) );
  ADDFX1M \intadd_6/U2  ( .A(\intadd_6/A[2] ), .B(\intadd_6/B[2] ), .CI(
        \intadd_6/n2 ), .CO(\intadd_6/n1 ), .S(\intadd_6/SUM[2] ) );
  ADDFX1M \intadd_1/U4  ( .A(\intadd_1/A[2] ), .B(\intadd_1/B[2] ), .CI(
        \intadd_1/n4 ), .CO(\intadd_1/n3 ), .S(\intadd_1/SUM[2] ) );
  ADDFX1M \intadd_0/U3  ( .A(\intadd_0/A[3] ), .B(\intadd_0/B[3] ), .CI(
        \intadd_0/n3 ), .CO(\intadd_0/n2 ), .S(\intadd_0/SUM[3] ) );
  ADDFX1M \intadd_2/U3  ( .A(\intadd_2/A[2] ), .B(\intadd_2/B[2] ), .CI(
        \intadd_2/n3 ), .CO(\intadd_2/n2 ), .S(\intadd_2/SUM[2] ) );
  ADDFX1M \intadd_1/U2  ( .A(\intadd_4/n1 ), .B(\intadd_1/B[4] ), .CI(
        \intadd_1/n2 ), .CO(\intadd_1/n1 ), .S(\intadd_1/SUM[4] ) );
  ADDFX1M \DP_OP_29J1_122_2578/U21  ( .A(A[0]), .B(\DP_OP_29J1_122_2578/n43 ), 
        .CI(\DP_OP_29J1_122_2578/n29 ), .CO(\DP_OP_29J1_122_2578/n16 ), .S(
        \C7M/DATA15_0 ) );
  ADDFX1M \DP_OP_29J1_122_2578/U20  ( .A(\DP_OP_29J1_122_2578/n28 ), .B(A[1]), 
        .CI(\DP_OP_29J1_122_2578/n16 ), .CO(\DP_OP_29J1_122_2578/n15 ), .S(
        \C7M/DATA15_1 ) );
  ADDFX1M \DP_OP_29J1_122_2578/U19  ( .A(\DP_OP_29J1_122_2578/n27 ), .B(A[2]), 
        .CI(\DP_OP_29J1_122_2578/n15 ), .CO(\DP_OP_29J1_122_2578/n14 ), .S(
        \C7M/DATA15_2 ) );
  ADDFX1M \intadd_7/U4  ( .A(\intadd_7/A[0] ), .B(\intadd_7/B[0] ), .CI(
        \intadd_7/CI ), .CO(\intadd_7/n3 ), .S(\intadd_7/SUM[0] ) );
  ADDFX1M \DP_OP_29J1_122_2578/U18  ( .A(\DP_OP_29J1_122_2578/n26 ), .B(A[3]), 
        .CI(\DP_OP_29J1_122_2578/n14 ), .CO(\DP_OP_29J1_122_2578/n13 ), .S(
        \C7M/DATA15_3 ) );
  ADDFX1M \intadd_7/U3  ( .A(\intadd_7/A[1] ), .B(\intadd_7/B[1] ), .CI(
        \intadd_7/n3 ), .CO(\intadd_7/n2 ), .S(\intadd_7/SUM[1] ) );
  ADDFX1M \DP_OP_29J1_122_2578/U17  ( .A(\DP_OP_29J1_122_2578/n25 ), .B(A[4]), 
        .CI(\DP_OP_29J1_122_2578/n13 ), .CO(\DP_OP_29J1_122_2578/n12 ), .S(
        \C7M/DATA15_4 ) );
  ADDFX1M \DP_OP_29J1_122_2578/U16  ( .A(\DP_OP_29J1_122_2578/n24 ), .B(A[5]), 
        .CI(\DP_OP_29J1_122_2578/n12 ), .CO(\DP_OP_29J1_122_2578/n11 ), .S(
        \C7M/DATA15_5 ) );
  ADDFX1M \DP_OP_29J1_122_2578/U15  ( .A(\DP_OP_29J1_122_2578/n23 ), .B(A[6]), 
        .CI(\DP_OP_29J1_122_2578/n11 ), .CO(\DP_OP_29J1_122_2578/n10 ), .S(
        \C7M/DATA15_6 ) );
  ADDFX1M \DP_OP_29J1_122_2578/U14  ( .A(\DP_OP_29J1_122_2578/n22 ), .B(A[7]), 
        .CI(\DP_OP_29J1_122_2578/n10 ), .CO(\DP_OP_29J1_122_2578/n9 ), .S(
        \C7M/DATA15_7 ) );
  ADDFX1M \intadd_0/U6  ( .A(\intadd_0/A[0] ), .B(\intadd_0/B[0] ), .CI(
        \intadd_0/CI ), .CO(\intadd_0/n5 ), .S(\intadd_0/SUM[0] ) );
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
  ADDFX1M \intadd_1/U6  ( .A(\intadd_1/A[0] ), .B(\intadd_1/B[0] ), .CI(
        \intadd_1/CI ), .CO(\intadd_1/n5 ), .S(\intadd_1/SUM[0] ) );
  ADDFX1M \intadd_6/U4  ( .A(\intadd_6/A[0] ), .B(\intadd_6/B[0] ), .CI(
        \intadd_6/CI ), .CO(\intadd_6/n3 ), .S(\intadd_6/SUM[0] ) );
  ADDFX1M \intadd_7/U2  ( .A(\intadd_6/SUM[0] ), .B(\intadd_7/B[2] ), .CI(
        \intadd_7/n2 ), .CO(\intadd_7/n1 ), .S(\intadd_7/SUM[2] ) );
  ADDFX1M \intadd_1/U5  ( .A(\intadd_1/A[1] ), .B(\intadd_1/B[1] ), .CI(
        \intadd_1/n5 ), .CO(\intadd_1/n4 ), .S(\intadd_1/SUM[1] ) );
  ADDFX1M \intadd_1/U3  ( .A(\intadd_1/A[3] ), .B(\intadd_1/B[3] ), .CI(
        \intadd_1/n3 ), .CO(\intadd_1/n2 ), .S(\intadd_1/SUM[3] ) );
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
  ADDFX1M \intadd_2/U2  ( .A(\intadd_2/A[3] ), .B(\intadd_2/B[3] ), .CI(
        \intadd_2/n2 ), .CO(\intadd_2/n1 ), .S(\intadd_2/SUM[3] ) );
  DFFSQX2M ALU_result_valid_reg ( .D(n373), .CK(clk), .SN(reset), .Q(n374) );
  CLKINVX1M U3 ( .A(n20), .Y(n298) );
  NAND3XLM U4 ( .A(n28), .B(n5), .C(n16), .Y(n20) );
  NOR2XLM U5 ( .A(A[0]), .B(n269), .Y(n270) );
  AOI22XLM U6 ( .A0(B[0]), .A1(n270), .B0(A[1]), .B1(n272), .Y(n271) );
  OAI21XLM U7 ( .A0(A[1]), .A1(n272), .B0(n271), .Y(n273) );
  OAI31XLM U8 ( .A0(n268), .A1(n267), .A2(n266), .B0(n265), .Y(n276) );
  OAI22XLM U9 ( .A0(B[1]), .A1(n315), .B0(B[2]), .B1(n305), .Y(n330) );
  NOR2XLM U10 ( .A(B[3]), .B(n113), .Y(n259) );
  NAND2XLM U11 ( .A(A[0]), .B(n372), .Y(n316) );
  OAI21XLM U12 ( .A0(n99), .A1(n98), .B0(n100), .Y(n97) );
  OAI21XLM U13 ( .A0(n47), .A1(n48), .B0(n45), .Y(n62) );
  OAI21XLM U14 ( .A0(n253), .A1(n252), .B0(n254), .Y(n251) );
  AOI22XLM U15 ( .A0(n269), .A1(n63), .B0(n62), .B1(n46), .Y(n56) );
  NOR4XLM U16 ( .A(n368), .B(n366), .C(n269), .D(n372), .Y(\intadd_1/A[0] ) );
  NOR2XLM U17 ( .A(n342), .B(n305), .Y(n206) );
  AOI31XLM U18 ( .A0(n341), .A1(n340), .A2(n339), .B0(n338), .Y(n344) );
  AOI222XLM U19 ( .A0(B[3]), .A1(n74), .B0(B[3]), .B1(n76), .C0(n74), .C1(n76), 
        .Y(n69) );
  CLKINVX1M U20 ( .A(\intadd_7/n1 ), .Y(n193) );
  OAI31XLM U21 ( .A0(n207), .A1(n206), .A2(n205), .B0(n204), .Y(
        \intadd_0/B[2] ) );
  NOR2XLM U22 ( .A(n89), .B(n228), .Y(n119) );
  NAND2XLM U23 ( .A(n342), .B(n290), .Y(n93) );
  OAI211XLM U24 ( .A0(n70), .A1(n55), .B0(n54), .C0(n53), .Y(n147) );
  CLKINVX1M U25 ( .A(n302), .Y(n240) );
  CLKINVX1M U26 ( .A(n237), .Y(n158) );
  CLKINVX1M U27 ( .A(\intadd_2/SUM[2] ), .Y(n173) );
  OAI211XLM U28 ( .A0(n305), .A1(n138), .B0(n128), .C0(n127), .Y(n129) );
  NOR2BXLM U29 ( .AN(n23), .B(n22), .Y(n297) );
  OAI22XLM U30 ( .A0(n176), .A1(n240), .B0(n310), .B1(n158), .Y(n18) );
  OAI21XLM U31 ( .A0(n314), .A1(n158), .B0(n153), .Y(n154) );
  AOI31XLM U32 ( .A0(ALU_function[3]), .A1(ALU_function[1]), .A2(n23), .B0(n1), 
        .Y(n2) );
  AOI211XLM U33 ( .A0(n302), .A1(n185), .B0(n136), .C0(n135), .Y(n143) );
  OAI21XLM U34 ( .A0(\intadd_3/n1 ), .A1(n4), .B0(n3), .Y(n6) );
  OAI211XLM U35 ( .A0(n359), .A1(n168), .B0(n167), .C0(n166), .Y(N186) );
  CLKINVX1M U36 ( .A(n374), .Y(ALU_result_valid) );
  CLKINVX1M U37 ( .A(ALU_function[2]), .Y(n5) );
  CLKINVX1M U38 ( .A(ALU_function[0]), .Y(n328) );
  NOR2XLM U39 ( .A(n5), .B(n328), .Y(n23) );
  CLKINVX1M U40 ( .A(enable), .Y(n1) );
  CLKINVX1M U41 ( .A(n2), .Y(n373) );
  NOR2BXLM U42 ( .AN(ALU_function[0]), .B(ALU_function[2]), .Y(n24) );
  NOR3BX1M U43 ( .AN(n24), .B(ALU_function[3]), .C(ALU_function[1]), .Y(
        \DP_OP_29J1_122_2578/n43 ) );
  CLKINVX1M U44 ( .A(\DP_OP_29J1_122_2578/n43 ), .Y(n152) );
  NOR2XLM U45 ( .A(\DP_OP_29J1_122_2578/n9 ), .B(n152), .Y(n35) );
  CLKINVX1M U46 ( .A(ALU_function[3]), .Y(n28) );
  CLKINVX1M U47 ( .A(ALU_function[1]), .Y(n349) );
  NAND2XLM U48 ( .A(enable), .B(n349), .Y(n25) );
  CLKINVX1M U49 ( .A(n25), .Y(n16) );
  CLKINVX1M U50 ( .A(\intadd_1/n1 ), .Y(n184) );
  CLKINVX1M U51 ( .A(\intadd_0/SUM[3] ), .Y(n183) );
  AOI22XLM U52 ( .A0(\intadd_0/SUM[3] ), .A1(\intadd_1/n1 ), .B0(n184), .B1(
        n183), .Y(n4) );
  NAND2XLM U53 ( .A(enable), .B(ALU_function[1]), .Y(n17) );
  NAND2BXLM U54 ( .AN(n17), .B(n28), .Y(n15) );
  NOR3X1M U55 ( .A(ALU_function[2]), .B(ALU_function[0]), .C(n15), .Y(n352) );
  CLKINVX1M U56 ( .A(n352), .Y(n38) );
  AOI21XLM U57 ( .A0(\intadd_3/n1 ), .A1(n4), .B0(n38), .Y(n3) );
  NOR2XLM U58 ( .A(n5), .B(ALU_function[0]), .Y(n345) );
  CLKINVX1M U59 ( .A(n345), .Y(n27) );
  NOR2XLM U60 ( .A(n27), .B(n15), .Y(n302) );
  NAND2XLM U61 ( .A(ALU_function[3]), .B(n16), .Y(n22) );
  AOI221XLM U62 ( .A0(ALU_function[2]), .A1(n15), .B0(n5), .B1(n22), .C0(n328), 
        .Y(n296) );
  NOR2XLM U63 ( .A(n302), .B(n296), .Y(n153) );
  OAI2B11XLM U64 ( .A1N(n35), .A0(n20), .B0(n6), .C0(n153), .Y(N189) );
  CLKINVX1M U65 ( .A(\intadd_0/n1 ), .Y(n174) );
  AOI22XLM U66 ( .A0(\intadd_2/SUM[2] ), .A1(\intadd_0/n1 ), .B0(n174), .B1(
        n173), .Y(n8) );
  AOI21XLM U67 ( .A0(\intadd_5/n1 ), .A1(n8), .B0(n38), .Y(n7) );
  OAI21XLM U68 ( .A0(\intadd_5/n1 ), .A1(n8), .B0(n7), .Y(n9) );
  OAI2B11XLM U69 ( .A1N(n35), .A0(n20), .B0(n9), .C0(n153), .Y(N191) );
  CLKINVX1M U70 ( .A(A[7]), .Y(n314) );
  CLKINVX1M U71 ( .A(B[5]), .Y(n333) );
  NOR2XLM U72 ( .A(n314), .B(n333), .Y(n177) );
  CLKINVX1M U73 ( .A(A[6]), .Y(n370) );
  CLKINVX1M U74 ( .A(B[6]), .Y(n290) );
  NOR2XLM U75 ( .A(n370), .B(n290), .Y(n176) );
  CLKINVX1M U76 ( .A(B[7]), .Y(n342) );
  CLKINVX1M U77 ( .A(A[5]), .Y(n310) );
  NOR2XLM U78 ( .A(n342), .B(n310), .Y(n175) );
  NOR2XLM U79 ( .A(n342), .B(n370), .Y(n170) );
  NOR2XLM U80 ( .A(n314), .B(n290), .Y(n169) );
  NOR2XLM U81 ( .A(n314), .B(n342), .Y(n160) );
  OAI211XLM U82 ( .A0(\intadd_2/n1 ), .A1(n11), .B0(n160), .C0(n352), .Y(n10)
         );
  OAI2B11XLM U83 ( .A1N(n35), .A0(n20), .B0(n10), .C0(n153), .Y(N194) );
  AOI2BB2XLM U84 ( .B0(n160), .B1(n11), .A0N(n11), .A1N(n160), .Y(n13) );
  AOI21XLM U85 ( .A0(\intadd_2/n1 ), .A1(n13), .B0(n38), .Y(n12) );
  OAI21XLM U86 ( .A0(\intadd_2/n1 ), .A1(n13), .B0(n12), .Y(n14) );
  OAI2B11XLM U87 ( .A1N(n35), .A0(n20), .B0(n14), .C0(n153), .Y(N193) );
  NOR2BXLM U88 ( .AN(n24), .B(n15), .Y(n244) );
  CLKINVX1M U89 ( .A(n244), .Y(n359) );
  CLKINVX1M U90 ( .A(B[1]), .Y(n269) );
  CLKINVX1M U91 ( .A(B[3]), .Y(n222) );
  NAND3XLM U92 ( .A(n342), .B(n290), .C(n333), .Y(n71) );
  NOR2XLM U93 ( .A(B[4]), .B(n71), .Y(n53) );
  NAND2XLM U94 ( .A(n222), .B(n53), .Y(n43) );
  NOR2XLM U95 ( .A(n43), .B(B[2]), .Y(n157) );
  AOI21BXLM U96 ( .A0(n370), .A1(B[0]), .B0N(n157), .Y(n41) );
  OAI21XLM U97 ( .A0(A[7]), .A1(n269), .B0(n41), .Y(n39) );
  NAND3XLM U98 ( .A(n28), .B(n23), .C(n16), .Y(n353) );
  AOI21XLM U99 ( .A0(n370), .A1(n290), .B0(n353), .Y(n19) );
  NOR3XLM U100 ( .A(n28), .B(n27), .C(n17), .Y(n237) );
  AOI211XLM U101 ( .A0(n352), .A1(\intadd_6/SUM[2] ), .B0(n19), .C0(n18), .Y(
        n32) );
  CLKINVX1M U102 ( .A(n296), .Y(n236) );
  NAND2XLM U103 ( .A(n370), .B(n290), .Y(n21) );
  AOI22XLM U104 ( .A0(A[6]), .A1(n290), .B0(B[6]), .B1(n370), .Y(n320) );
  NOR3XLM U105 ( .A(ALU_function[2]), .B(ALU_function[0]), .C(n22), .Y(n350)
         );
  CLKINVX1M U106 ( .A(n350), .Y(n234) );
  OAI22XLM U107 ( .A0(n236), .A1(n21), .B0(n320), .B1(n234), .Y(n30) );
  CLKINVX1M U108 ( .A(n297), .Y(n138) );
  NOR2XLM U109 ( .A(n24), .B(n28), .Y(n26) );
  AOI211XLM U110 ( .A0(n28), .A1(n27), .B0(n26), .C0(n25), .Y(n351) );
  OAI2BB2XLM U111 ( .B0(n138), .B1(n314), .A0N(n351), .A1N(n176), .Y(n29) );
  AOI211XLM U112 ( .A0(\C7M/DATA15_6 ), .A1(n298), .B0(n30), .C0(n29), .Y(n31)
         );
  OAI211XLM U113 ( .A0(n359), .A1(n39), .B0(n32), .C0(n31), .Y(N185) );
  CLKINVX1M U114 ( .A(n153), .Y(n34) );
  AOI21XLM U115 ( .A0(\intadd_1/SUM[4] ), .A1(n352), .B0(n34), .Y(n33) );
  OAI2BB1XLM U116 ( .A0N(n298), .A1N(n35), .B0(n33), .Y(N188) );
  AOI21XLM U117 ( .A0(n35), .A1(n298), .B0(n34), .Y(n36) );
  OAI2BB1XLM U118 ( .A0N(n352), .A1N(\intadd_0/SUM[4] ), .B0(n36), .Y(N190) );
  OAI2BB1XLM U119 ( .A0N(n352), .A1N(\intadd_2/SUM[3] ), .B0(n36), .Y(N192) );
  NAND2XLM U120 ( .A(B[1]), .B(A[1]), .Y(n363) );
  NAND2XLM U121 ( .A(B[1]), .B(A[0]), .Y(n247) );
  CLKINVX1M U122 ( .A(n353), .Y(n303) );
  AOI31XLM U123 ( .A0(B[0]), .A1(n352), .A2(n247), .B0(n303), .Y(n37) );
  CLKINVX1M U124 ( .A(A[1]), .Y(n315) );
  NAND2XLM U125 ( .A(A[1]), .B(n269), .Y(n317) );
  OAI22XLM U126 ( .A0(n37), .A1(n315), .B0(n317), .B1(n234), .Y(n124) );
  CLKINVX1M U127 ( .A(A[0]), .Y(n364) );
  NOR3XLM U128 ( .A(n269), .B(n364), .C(n38), .Y(n125) );
  AOI221XLM U129 ( .A0(n350), .A1(B[1]), .B0(n296), .B1(n269), .C0(n125), .Y(
        n122) );
  CLKINVX1M U130 ( .A(A[4]), .Y(n368) );
  NAND2XLM U131 ( .A(B[0]), .B(n368), .Y(n63) );
  CLKINVX1M U132 ( .A(B[2]), .Y(n362) );
  NAND2XLM U133 ( .A(n310), .B(B[0]), .Y(n48) );
  CLKINVX1M U134 ( .A(n48), .Y(n49) );
  CLKINVX1M U135 ( .A(B[0]), .Y(n372) );
  OAI21XLM U136 ( .A0(n372), .A1(n39), .B0(A[6]), .Y(n50) );
  AOI222XLM U137 ( .A0(B[1]), .A1(n49), .B0(B[1]), .B1(n50), .C0(n49), .C1(n50), .Y(n40) );
  OAI21XLM U138 ( .A0(A[7]), .A1(n362), .B0(n40), .Y(n44) );
  AOI211XLM U139 ( .A0(n269), .A1(n157), .B0(n314), .C0(n41), .Y(n42) );
  CLKINVX1M U140 ( .A(n42), .Y(n52) );
  AOI221XLM U141 ( .A0(B[2]), .A1(n44), .B0(n52), .B1(n44), .C0(n43), .Y(n141)
         );
  CLKINVX1M U142 ( .A(n141), .Y(n47) );
  OAI21XLM U143 ( .A0(n47), .A1(n372), .B0(A[5]), .Y(n45) );
  NAND3XLM U144 ( .A(B[1]), .B(B[0]), .C(n368), .Y(n46) );
  NOR2XLM U145 ( .A(B[2]), .B(n56), .Y(n61) );
  AOI221XLM U146 ( .A0(n49), .A1(B[1]), .B0(n48), .B1(n269), .C0(n47), .Y(n51)
         );
  XOR2XLM U147 ( .A(n51), .B(n50), .Y(n60) );
  NOR2XLM U148 ( .A(n52), .B(n141), .Y(n70) );
  AOI222XLM U149 ( .A0(B[2]), .A1(n56), .B0(B[2]), .B1(n60), .C0(n56), .C1(n60), .Y(n55) );
  AO21XLM U150 ( .A0(n70), .A1(n55), .B0(n222), .Y(n54) );
  NAND2XLM U151 ( .A(B[2]), .B(n56), .Y(n57) );
  NAND2BXLM U152 ( .AN(n147), .B(n57), .Y(n59) );
  OAI21XLM U153 ( .A0(n61), .A1(n59), .B0(n60), .Y(n58) );
  OAI31XLM U154 ( .A0(n61), .A1(n60), .A2(n59), .B0(n58), .Y(n76) );
  CLKINVX1M U155 ( .A(n62), .Y(n66) );
  AOI32XLM U156 ( .A0(B[0]), .A1(n269), .A2(n368), .B0(B[1]), .B1(n63), .Y(n65) );
  OAI21XLM U157 ( .A0(n147), .A1(n65), .B0(n66), .Y(n64) );
  OAI31XLM U158 ( .A0(n147), .A1(n66), .A2(n65), .B0(n64), .Y(n78) );
  CLKINVX1M U159 ( .A(A[3]), .Y(n366) );
  NAND2XLM U160 ( .A(B[0]), .B(n366), .Y(n82) );
  OAI21XLM U161 ( .A0(n372), .A1(n147), .B0(A[4]), .Y(n67) );
  OAI31XLM U162 ( .A0(n372), .A1(A[4]), .A2(n147), .B0(n67), .Y(n85) );
  NAND3XLM U163 ( .A(B[1]), .B(B[0]), .C(n366), .Y(n68) );
  AOI22XLM U164 ( .A0(n269), .A1(n82), .B0(n85), .B1(n68), .Y(n77) );
  CLKINVX1M U165 ( .A(n74), .Y(n73) );
  CLKINVX1M U166 ( .A(B[4]), .Y(n309) );
  OAI21XLM U167 ( .A0(n70), .A1(n309), .B0(n69), .Y(n72) );
  NAND2XLM U168 ( .A(n70), .B(n147), .Y(n89) );
  AOI221XLM U169 ( .A0(B[4]), .A1(n72), .B0(n89), .B1(n72), .C0(n71), .Y(n228)
         );
  CLKINVX1M U170 ( .A(n228), .Y(n86) );
  AOI221XLM U171 ( .A0(n74), .A1(B[3]), .B0(n73), .B1(n222), .C0(n86), .Y(n75)
         );
  XOR2XLM U172 ( .A(n76), .B(n75), .Y(n90) );
  CLKINVX1M U173 ( .A(n90), .Y(n100) );
  ADDFX1M U174 ( .A(B[2]), .B(n78), .CI(n77), .CO(n74), .S(n79) );
  MXI2XLM U175 ( .A(n79), .B(n78), .S0(n86), .Y(n117) );
  CLKINVX1M U176 ( .A(A[2]), .Y(n305) );
  AOI21XLM U177 ( .A0(B[0]), .A1(n305), .B0(B[1]), .Y(n81) );
  OAI21XLM U178 ( .A0(n86), .A1(n372), .B0(A[3]), .Y(n80) );
  OAI31XLM U179 ( .A0(n86), .A1(A[3]), .A2(n372), .B0(n80), .Y(n106) );
  NOR2XLM U180 ( .A(n372), .B(A[2]), .Y(n103) );
  OAI2BB2XLM U181 ( .B0(n81), .B1(n106), .A0N(B[1]), .A1N(n103), .Y(n87) );
  NOR2XLM U182 ( .A(B[2]), .B(n87), .Y(n112) );
  AOI32XLM U183 ( .A0(B[0]), .A1(n269), .A2(n366), .B0(B[1]), .B1(n82), .Y(n84) );
  OAI21XLM U184 ( .A0(n86), .A1(n84), .B0(n85), .Y(n83) );
  OAI31XLM U185 ( .A0(n86), .A1(n85), .A2(n84), .B0(n83), .Y(n111) );
  NAND2XLM U186 ( .A(B[2]), .B(n87), .Y(n108) );
  OAI21XLM U187 ( .A0(n112), .A1(n111), .B0(n108), .Y(n88) );
  NOR2XLM U188 ( .A(B[3]), .B(n88), .Y(n114) );
  NAND2XLM U189 ( .A(B[3]), .B(n88), .Y(n115) );
  OAI21XLM U190 ( .A0(n117), .A1(n114), .B0(n115), .Y(n95) );
  NOR2XLM U191 ( .A(B[4]), .B(n95), .Y(n99) );
  CLKINVX1M U192 ( .A(n119), .Y(n94) );
  AOI222XLM U193 ( .A0(B[4]), .A1(n95), .B0(B[4]), .B1(n90), .C0(n95), .C1(n90), .Y(n91) );
  AOI21XLM U194 ( .A0(n333), .A1(n119), .B0(n91), .Y(n92) );
  AOI211XLM U195 ( .A0(n94), .A1(B[5]), .B0(n93), .C0(n92), .Y(n243) );
  NAND2XLM U196 ( .A(B[4]), .B(n95), .Y(n96) );
  NAND2XLM U197 ( .A(n243), .B(n96), .Y(n98) );
  OAI31XLM U198 ( .A0(n100), .A1(n99), .A2(n98), .B0(n97), .Y(n254) );
  NOR2XLM U199 ( .A(A[1]), .B(n372), .Y(n264) );
  NOR2XLM U200 ( .A(B[1]), .B(n264), .Y(n102) );
  CLKINVX1M U201 ( .A(n243), .Y(n118) );
  OAI21XLM U202 ( .A0(n118), .A1(n372), .B0(A[2]), .Y(n101) );
  OAI31XLM U203 ( .A0(n118), .A1(A[2]), .A2(n372), .B0(n101), .Y(n267) );
  OAI2BB2XLM U204 ( .B0(n102), .B1(n267), .A0N(B[1]), .A1N(n264), .Y(n107) );
  NOR2XLM U205 ( .A(B[2]), .B(n107), .Y(n260) );
  OAI32XLM U206 ( .A0(n269), .A1(A[2]), .A2(n372), .B0(B[1]), .B1(n103), .Y(
        n105) );
  OAI21XLM U207 ( .A0(n118), .A1(n105), .B0(n106), .Y(n104) );
  OAI31XLM U208 ( .A0(n118), .A1(n106), .A2(n105), .B0(n104), .Y(n263) );
  NAND2XLM U209 ( .A(B[2]), .B(n107), .Y(n261) );
  OAI21XLM U210 ( .A0(n260), .A1(n263), .B0(n261), .Y(n113) );
  NAND2XLM U211 ( .A(n108), .B(n243), .Y(n110) );
  OAI21XLM U212 ( .A0(n112), .A1(n110), .B0(n111), .Y(n109) );
  OAI31XLM U213 ( .A0(n112), .A1(n111), .A2(n110), .B0(n109), .Y(n258) );
  NAND2XLM U214 ( .A(B[3]), .B(n113), .Y(n255) );
  OAI21XLM U215 ( .A0(n259), .A1(n258), .B0(n255), .Y(n281) );
  NOR3BXLM U216 ( .AN(n115), .B(n114), .C(n118), .Y(n116) );
  XNOR2XLM U217 ( .A(n117), .B(n116), .Y(n285) );
  AOI222XLM U218 ( .A0(B[4]), .A1(n281), .B0(B[4]), .B1(n285), .C0(n281), .C1(
        n285), .Y(n248) );
  AOI222XLM U219 ( .A0(n254), .A1(n248), .B0(n254), .B1(n333), .C0(n248), .C1(
        n333), .Y(n120) );
  NAND2XLM U220 ( .A(n119), .B(n118), .Y(n295) );
  OR2X1M U221 ( .A(n120), .B(n295), .Y(n121) );
  AOI221XLM U222 ( .A0(B[6]), .A1(n121), .B0(n120), .B1(n295), .C0(B[7]), .Y(
        n293) );
  CLKINVX1M U223 ( .A(n293), .Y(n268) );
  OAI22XLM U224 ( .A0(A[1]), .A1(n122), .B0(n268), .B1(n359), .Y(n123) );
  AOI211XLM U225 ( .A0(n302), .A1(n363), .B0(n124), .C0(n123), .Y(n131) );
  CLKINVX1M U226 ( .A(n363), .Y(n126) );
  AOI22XLM U227 ( .A0(n126), .A1(n351), .B0(n125), .B1(n372), .Y(n128) );
  AOI22XLM U228 ( .A0(B[1]), .A1(n303), .B0(A[0]), .B1(n237), .Y(n127) );
  AOI21XLM U229 ( .A0(n298), .A1(\C7M/DATA15_1 ), .B0(n129), .Y(n130) );
  NAND2XLM U230 ( .A(n131), .B(n130), .Y(N180) );
  NAND2XLM U231 ( .A(B[5]), .B(A[5]), .Y(n185) );
  NAND2XLM U232 ( .A(B[2]), .B(A[1]), .Y(n232) );
  NOR2XLM U233 ( .A(n222), .B(n364), .Y(n233) );
  NOR3XLM U234 ( .A(n362), .B(n364), .C(n363), .Y(n361) );
  AOI2B1XLM U235 ( .A1N(n232), .A0(n233), .B0(n361), .Y(n198) );
  NAND2XLM U236 ( .A(B[3]), .B(A[1]), .Y(n197) );
  NOR4XLM U237 ( .A(n366), .B(n305), .C(n269), .D(n372), .Y(n365) );
  CLKINVX1M U238 ( .A(n365), .Y(n196) );
  CLKINVX1M U239 ( .A(\intadd_6/SUM[1] ), .Y(n194) );
  AOI22XLM U240 ( .A0(\intadd_6/SUM[1] ), .A1(n193), .B0(\intadd_7/n1 ), .B1(
        n194), .Y(n133) );
  OAI21XLM U241 ( .A0(n195), .A1(n133), .B0(n352), .Y(n132) );
  AOI21XLM U242 ( .A0(n195), .A1(n133), .B0(n132), .Y(n136) );
  OAI21XLM U243 ( .A0(n333), .A1(n310), .B0(n350), .Y(n134) );
  AOI22XLM U244 ( .A0(n333), .A1(n310), .B0(n353), .B1(n134), .Y(n135) );
  NAND2XLM U245 ( .A(n333), .B(n310), .Y(n137) );
  OAI22XLM U246 ( .A0(n236), .A1(n137), .B0(n368), .B1(n158), .Y(n140) );
  OAI2B2XLM U247 ( .A1N(n351), .A0(n185), .B0(n370), .B1(n138), .Y(n139) );
  AOI211XLM U248 ( .A0(n141), .A1(n244), .B0(n140), .C0(n139), .Y(n142) );
  OAI2B11XLM U249 ( .A1N(\C7M/DATA15_5 ), .A0(n20), .B0(n143), .C0(n142), .Y(
        N184) );
  NOR3XLM U250 ( .A(B[4]), .B(A[4]), .C(n236), .Y(n149) );
  NOR2XLM U251 ( .A(n309), .B(n368), .Y(n212) );
  AOI2BB2XLM U252 ( .B0(n352), .B1(\intadd_7/SUM[2] ), .A0N(n212), .A1N(n240), 
        .Y(n146) );
  AOI21XLM U253 ( .A0(B[4]), .A1(A[4]), .B0(n234), .Y(n144) );
  OAI22XLM U254 ( .A0(A[4]), .A1(B[4]), .B0(n303), .B1(n144), .Y(n145) );
  OAI211XLM U255 ( .A0(n359), .A1(n147), .B0(n146), .C0(n145), .Y(n148) );
  AOI211XLM U256 ( .A0(n237), .A1(A[3]), .B0(n149), .C0(n148), .Y(n151) );
  AOI22XLM U257 ( .A0(n351), .A1(n212), .B0(n297), .B1(A[5]), .Y(n150) );
  OAI2B11XLM U258 ( .A1N(\C7M/DATA15_4 ), .A0(n20), .B0(n151), .C0(n150), .Y(
        N183) );
  XNOR2XLM U259 ( .A(\DP_OP_29J1_122_2578/n9 ), .B(n152), .Y(n156) );
  AOI21XLM U260 ( .A0(\intadd_1/SUM[3] ), .A1(n352), .B0(n154), .Y(n155) );
  OAI2BB1XLM U261 ( .A0N(n298), .A1N(n156), .B0(n155), .Y(N187) );
  OAI211XLM U262 ( .A0(A[7]), .A1(n372), .B0(n157), .C0(n269), .Y(n168) );
  NAND2XLM U263 ( .A(n314), .B(n342), .Y(n165) );
  AOI2BB2XLM U264 ( .B0(n351), .B1(n160), .A0N(n165), .A1N(n236), .Y(n167) );
  AOI22XLM U265 ( .A0(A[7]), .A1(n342), .B0(B[7]), .B1(n314), .Y(n321) );
  OAI22XLM U266 ( .A0(n321), .A1(n234), .B0(n370), .B1(n158), .Y(n164) );
  CLKINVX1M U267 ( .A(\intadd_6/n1 ), .Y(n192) );
  CLKINVX1M U268 ( .A(\intadd_1/SUM[2] ), .Y(n191) );
  AOI22XLM U269 ( .A0(\intadd_1/SUM[2] ), .A1(\intadd_6/n1 ), .B0(n192), .B1(
        n191), .Y(n159) );
  AOI2BB2XLM U270 ( .B0(n189), .B1(n159), .A0N(n189), .A1N(n159), .Y(n161) );
  AOI2BB2XLM U271 ( .B0(n161), .B1(n352), .A0N(n160), .A1N(n240), .Y(n162) );
  OAI2BB1XLM U272 ( .A0N(n298), .A1N(\C7M/DATA15_7 ), .B0(n162), .Y(n163) );
  AOI211XLM U273 ( .A0(n303), .A1(n165), .B0(n164), .C0(n163), .Y(n166) );
  ADDFX1M U274 ( .A(n171), .B(n170), .CI(n169), .CO(n11), .S(\intadd_2/B[3] )
         );
  OAI21XLM U275 ( .A0(\intadd_2/SUM[2] ), .A1(\intadd_0/n1 ), .B0(
        \intadd_5/n1 ), .Y(n172) );
  OAI21XLM U276 ( .A0(n174), .A1(n173), .B0(n172), .Y(\intadd_2/A[3] ) );
  ADDFX1M U277 ( .A(n177), .B(n176), .CI(n175), .CO(n171), .S(\intadd_2/B[2] )
         );
  NOR2XLM U278 ( .A(n290), .B(n310), .Y(\intadd_2/B[1] ) );
  NOR2XLM U279 ( .A(n314), .B(n309), .Y(n180) );
  NOR2XLM U280 ( .A(n370), .B(n333), .Y(n179) );
  NOR2XLM U281 ( .A(n342), .B(n368), .Y(n178) );
  ADDFX1M U282 ( .A(n180), .B(n179), .CI(n178), .CO(\intadd_2/A[2] ), .S(
        \intadd_2/A[1] ) );
  NAND2XLM U283 ( .A(A[7]), .B(B[2]), .Y(n205) );
  NOR4XLM U284 ( .A(n314), .B(n370), .C(n362), .D(n269), .Y(n207) );
  AOI2B1XLM U285 ( .A1N(n205), .A0(n206), .B0(n207), .Y(n187) );
  NAND2XLM U286 ( .A(B[6]), .B(A[4]), .Y(n186) );
  CLKINVX1M U287 ( .A(n181), .Y(\intadd_5/A[2] ) );
  OAI21XLM U288 ( .A0(\intadd_0/SUM[3] ), .A1(\intadd_1/n1 ), .B0(
        \intadd_3/n1 ), .Y(n182) );
  OAI21XLM U289 ( .A0(n184), .A1(n183), .B0(n182), .Y(\intadd_0/A[4] ) );
  ADDFX1M U290 ( .A(n187), .B(n186), .CI(n185), .CO(n181), .S(n188) );
  CLKINVX1M U291 ( .A(n188), .Y(\intadd_5/B[1] ) );
  NOR2XLM U292 ( .A(n342), .B(n366), .Y(\intadd_2/CI ) );
  NOR2XLM U293 ( .A(n370), .B(n309), .Y(\intadd_2/B[0] ) );
  NOR2XLM U294 ( .A(n314), .B(n222), .Y(\intadd_2/A[0] ) );
  OAI21XLM U295 ( .A0(\intadd_1/SUM[2] ), .A1(\intadd_6/n1 ), .B0(n189), .Y(
        n190) );
  OAI21XLM U296 ( .A0(n192), .A1(n191), .B0(n190), .Y(\intadd_1/A[3] ) );
  NOR2XLM U297 ( .A(n309), .B(n305), .Y(\intadd_1/B[1] ) );
  AOI222XLM U298 ( .A0(n195), .A1(n194), .B0(n195), .B1(n193), .C0(n194), .C1(
        n193), .Y(\intadd_6/A[2] ) );
  ADDFX1M U299 ( .A(n198), .B(n197), .CI(n196), .CO(n195), .S(n199) );
  CLKINVX1M U300 ( .A(n199), .Y(\intadd_7/B[2] ) );
  NOR2XLM U301 ( .A(n309), .B(n364), .Y(\intadd_6/CI ) );
  NOR4XLM U302 ( .A(n310), .B(n368), .C(n269), .D(n372), .Y(\intadd_4/A[0] )
         );
  NOR2XLM U303 ( .A(n366), .B(n362), .Y(n203) );
  NAND2XLM U304 ( .A(A[4]), .B(B[1]), .Y(n200) );
  AOI221XLM U305 ( .A0(n372), .A1(n200), .B0(n310), .B1(n200), .C0(
        \intadd_4/A[0] ), .Y(n202) );
  NOR2XLM U306 ( .A(n333), .B(n364), .Y(n201) );
  ADDFX1M U307 ( .A(n203), .B(n202), .CI(n201), .CO(\intadd_1/A[1] ), .S(
        \intadd_6/B[1] ) );
  NOR2XLM U308 ( .A(n222), .B(n305), .Y(\intadd_1/CI ) );
  NOR2XLM U309 ( .A(n309), .B(n315), .Y(\intadd_1/B[0] ) );
  OAI21XLM U310 ( .A0(n207), .A1(n205), .B0(n206), .Y(n204) );
  NOR2XLM U311 ( .A(n290), .B(n366), .Y(\intadd_5/CI ) );
  NOR2XLM U312 ( .A(n310), .B(n309), .Y(\intadd_5/B[0] ) );
  NOR2XLM U313 ( .A(n370), .B(n222), .Y(\intadd_5/A[0] ) );
  NOR2XLM U314 ( .A(n310), .B(n222), .Y(n214) );
  NAND2XLM U315 ( .A(A[6]), .B(B[2]), .Y(n208) );
  AOI221XLM U316 ( .A0(n269), .A1(n208), .B0(n314), .B1(n208), .C0(n207), .Y(
        n213) );
  NOR4XLM U317 ( .A(n314), .B(n370), .C(n269), .D(n372), .Y(n217) );
  NOR2XLM U318 ( .A(n342), .B(n315), .Y(n216) );
  NOR2XLM U319 ( .A(n333), .B(n366), .Y(n215) );
  NOR2XLM U320 ( .A(n333), .B(n368), .Y(n209) );
  ADDFX1M U321 ( .A(n211), .B(n210), .CI(n209), .CO(\intadd_0/A[3] ), .S(
        \intadd_3/A[3] ) );
  NOR2XLM U322 ( .A(n333), .B(n315), .Y(\intadd_4/B[0] ) );
  NOR2XLM U323 ( .A(n290), .B(n364), .Y(\intadd_3/CI ) );
  NOR2XLM U324 ( .A(n368), .B(n362), .Y(\intadd_3/A[0] ) );
  NOR2XLM U325 ( .A(n309), .B(n366), .Y(\intadd_3/B[1] ) );
  NOR2XLM U326 ( .A(n333), .B(n305), .Y(\intadd_3/A[1] ) );
  ADDFX1M U327 ( .A(n214), .B(n213), .CI(n212), .CO(n211), .S(\intadd_3/B[2] )
         );
  ADDFX1M U328 ( .A(n217), .B(n216), .CI(n215), .CO(n210), .S(\intadd_3/A[2] )
         );
  NOR2XLM U329 ( .A(n368), .B(n222), .Y(\intadd_0/CI ) );
  NOR2XLM U330 ( .A(n290), .B(n315), .Y(\intadd_0/B[0] ) );
  NOR4XLM U331 ( .A(n370), .B(n310), .C(n269), .D(n372), .Y(\intadd_0/A[0] )
         );
  NOR2XLM U332 ( .A(n290), .B(n305), .Y(\intadd_0/B[1] ) );
  NOR2XLM U333 ( .A(n310), .B(n362), .Y(n221) );
  NAND2XLM U334 ( .A(A[6]), .B(B[1]), .Y(n218) );
  AOI221XLM U335 ( .A0(n372), .A1(n218), .B0(n314), .B1(n218), .C0(n217), .Y(
        n220) );
  NOR2XLM U336 ( .A(n342), .B(n364), .Y(n219) );
  ADDFX1M U337 ( .A(n221), .B(n220), .CI(n219), .CO(\intadd_0/A[1] ), .S(
        \intadd_4/B[1] ) );
  NOR2XLM U338 ( .A(n222), .B(n366), .Y(\intadd_4/CI ) );
  NAND2XLM U339 ( .A(n222), .B(n366), .Y(n223) );
  AOI22XLM U340 ( .A0(B[3]), .A1(n366), .B0(A[3]), .B1(n222), .Y(n319) );
  OAI22XLM U341 ( .A0(n236), .A1(n223), .B0(n319), .B1(n234), .Y(n227) );
  AOI22XLM U342 ( .A0(A[2]), .A1(n237), .B0(n352), .B1(\intadd_7/SUM[1] ), .Y(
        n225) );
  OAI21XLM U343 ( .A0(B[3]), .A1(A[3]), .B0(n303), .Y(n224) );
  OAI211XLM U344 ( .A0(\intadd_4/CI ), .A1(n240), .B0(n225), .C0(n224), .Y(
        n226) );
  AOI211XLM U345 ( .A0(n244), .A1(n228), .B0(n227), .C0(n226), .Y(n230) );
  AOI22XLM U346 ( .A0(n351), .A1(\intadd_4/CI ), .B0(n297), .B1(A[4]), .Y(n229) );
  OAI2B11XLM U347 ( .A1N(\C7M/DATA15_3 ), .A0(n20), .B0(n230), .C0(n229), .Y(
        N182) );
  OAI21XLM U348 ( .A0(n361), .A1(n232), .B0(n233), .Y(n231) );
  OAI31XLM U349 ( .A0(n361), .A1(n233), .A2(n232), .B0(n231), .Y(
        \intadd_7/B[1] ) );
  NOR2XLM U350 ( .A(n362), .B(n305), .Y(\intadd_6/A[0] ) );
  NAND2XLM U351 ( .A(n362), .B(n305), .Y(n235) );
  AOI22XLM U352 ( .A0(B[2]), .A1(n305), .B0(A[2]), .B1(n362), .Y(n318) );
  OAI22XLM U353 ( .A0(n236), .A1(n235), .B0(n318), .B1(n234), .Y(n242) );
  AOI22XLM U354 ( .A0(A[1]), .A1(n237), .B0(n352), .B1(\intadd_7/SUM[0] ), .Y(
        n239) );
  OAI21XLM U355 ( .A0(B[2]), .A1(A[2]), .B0(n303), .Y(n238) );
  OAI211XLM U356 ( .A0(\intadd_6/A[0] ), .A1(n240), .B0(n239), .C0(n238), .Y(
        n241) );
  AOI211XLM U357 ( .A0(n244), .A1(n243), .B0(n242), .C0(n241), .Y(n246) );
  AOI22XLM U358 ( .A0(n351), .A1(\intadd_6/A[0] ), .B0(A[3]), .B1(n297), .Y(
        n245) );
  OAI2B11XLM U359 ( .A1N(\C7M/DATA15_2 ), .A0(n20), .B0(n246), .C0(n245), .Y(
        N181) );
  NOR2XLM U360 ( .A(n305), .B(n372), .Y(\intadd_7/CI ) );
  NOR3XLM U361 ( .A(n315), .B(n372), .C(n247), .Y(\intadd_7/A[0] ) );
  XOR2XLM U362 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[2]), .Y(
        \DP_OP_29J1_122_2578/n27 ) );
  XOR2XLM U363 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[1]), .Y(
        \DP_OP_29J1_122_2578/n28 ) );
  CLKINVX1M U364 ( .A(n248), .Y(n249) );
  NOR2XLM U365 ( .A(B[5]), .B(n249), .Y(n253) );
  NAND2XLM U366 ( .A(B[5]), .B(n249), .Y(n250) );
  NAND2XLM U367 ( .A(n293), .B(n250), .Y(n252) );
  OAI31XLM U368 ( .A0(n254), .A1(n253), .A2(n252), .B0(n251), .Y(n291) );
  NAND2XLM U369 ( .A(n293), .B(n255), .Y(n257) );
  OAI21XLM U370 ( .A0(n259), .A1(n257), .B0(n258), .Y(n256) );
  OAI31XLM U371 ( .A0(n259), .A1(n258), .A2(n257), .B0(n256), .Y(n280) );
  NOR3BXLM U372 ( .AN(n261), .B(n260), .C(n268), .Y(n262) );
  XNOR2XLM U373 ( .A(n263), .B(n262), .Y(n278) );
  OAI32XLM U374 ( .A0(n269), .A1(A[1]), .A2(n372), .B0(B[1]), .B1(n264), .Y(
        n266) );
  OAI21XLM U375 ( .A0(n268), .A1(n266), .B0(n267), .Y(n265) );
  NOR2XLM U376 ( .A(A[0]), .B(n372), .Y(n274) );
  NOR2XLM U377 ( .A(n372), .B(n268), .Y(n272) );
  OAI21XLM U378 ( .A0(B[1]), .A1(n274), .B0(n273), .Y(n275) );
  AOI222XLM U379 ( .A0(n362), .A1(n276), .B0(n362), .B1(n275), .C0(n276), .C1(
        n275), .Y(n277) );
  AOI222XLM U380 ( .A0(B[3]), .A1(n278), .B0(B[3]), .B1(n277), .C0(n278), .C1(
        n277), .Y(n279) );
  AOI222XLM U381 ( .A0(n309), .A1(n280), .B0(n309), .B1(n279), .C0(n280), .C1(
        n279), .Y(n288) );
  NOR2XLM U382 ( .A(B[4]), .B(n281), .Y(n286) );
  NAND2XLM U383 ( .A(B[4]), .B(n281), .Y(n282) );
  NAND2XLM U384 ( .A(n293), .B(n282), .Y(n284) );
  OAI21XLM U385 ( .A0(n286), .A1(n284), .B0(n285), .Y(n283) );
  OAI31XLM U386 ( .A0(n286), .A1(n285), .A2(n284), .B0(n283), .Y(n287) );
  AOI222XLM U387 ( .A0(B[5]), .A1(n288), .B0(B[5]), .B1(n287), .C0(n288), .C1(
        n287), .Y(n289) );
  AOI222XLM U388 ( .A0(n291), .A1(n290), .B0(n291), .B1(n289), .C0(n290), .C1(
        n289), .Y(n292) );
  OAI31XLM U389 ( .A0(B[7]), .A1(n295), .A2(n293), .B0(n292), .Y(n294) );
  OAI2BB1XLM U390 ( .A0N(n295), .A1N(B[7]), .B0(n294), .Y(n360) );
  AOI221XLM U391 ( .A0(n350), .A1(B[0]), .B0(n296), .B1(n372), .C0(n302), .Y(
        n300) );
  AOI22XLM U392 ( .A0(\C7M/DATA15_0 ), .A1(n298), .B0(n297), .B1(A[1]), .Y(
        n299) );
  OAI21XLM U393 ( .A0(n300), .A1(A[0]), .B0(n299), .Y(n301) );
  AOI221XLM U394 ( .A0(n303), .A1(B[0]), .B0(n302), .B1(n372), .C0(n301), .Y(
        n358) );
  NAND2XLM U395 ( .A(n342), .B(A[7]), .Y(n346) );
  CLKINVX1M U396 ( .A(n346), .Y(n327) );
  NOR2XLM U397 ( .A(n370), .B(B[6]), .Y(n338) );
  CLKINVX1M U398 ( .A(n338), .Y(n313) );
  NAND2XLM U399 ( .A(B[1]), .B(n315), .Y(n304) );
  AOI31XLM U400 ( .A0(A[0]), .A1(n304), .A2(n372), .B0(n330), .Y(n308) );
  NOR2XLM U401 ( .A(n366), .B(B[3]), .Y(n329) );
  CLKINVX1M U402 ( .A(n329), .Y(n307) );
  AOI22XLM U403 ( .A0(n366), .A1(B[3]), .B0(n305), .B1(B[2]), .Y(n331) );
  CLKINVX1M U404 ( .A(n331), .Y(n306) );
  NOR2XLM U405 ( .A(A[4]), .B(n309), .Y(n335) );
  AOI221XLM U406 ( .A0(n308), .A1(n307), .B0(n306), .B1(n307), .C0(n335), .Y(
        n311) );
  AOI22XLM U407 ( .A0(n309), .A1(A[4]), .B0(n333), .B1(A[5]), .Y(n336) );
  CLKINVX1M U408 ( .A(n336), .Y(n324) );
  NAND2XLM U409 ( .A(B[6]), .B(n370), .Y(n339) );
  NAND2XLM U410 ( .A(B[5]), .B(n310), .Y(n340) );
  OAI211XLM U411 ( .A0(n311), .A1(n324), .B0(n339), .C0(n340), .Y(n312) );
  AOI22XLM U412 ( .A0(B[7]), .A1(n314), .B0(n313), .B1(n312), .Y(n326) );
  AOI22XLM U413 ( .A0(n315), .A1(B[1]), .B0(n364), .B1(B[0]), .Y(n332) );
  NAND4BXLM U414 ( .AN(n335), .B(n340), .C(n317), .D(n316), .Y(n323) );
  NAND4XLM U415 ( .A(n321), .B(n320), .C(n319), .D(n318), .Y(n322) );
  NOR4BXLM U416 ( .AN(n332), .B(n324), .C(n323), .D(n322), .Y(n325) );
  OAI32XLM U417 ( .A0(n328), .A1(n327), .A2(n326), .B0(ALU_function[0]), .B1(
        n325), .Y(n348) );
  AOI221XLM U418 ( .A0(n332), .A1(n331), .B0(n330), .B1(n331), .C0(n329), .Y(
        n337) );
  NAND2XLM U419 ( .A(A[5]), .B(n333), .Y(n334) );
  AOI22XLM U420 ( .A0(n337), .A1(n336), .B0(n335), .B1(n334), .Y(n341) );
  NOR2XLM U421 ( .A(A[7]), .B(n342), .Y(n343) );
  AOI32XLM U422 ( .A0(n346), .A1(n345), .A2(n344), .B0(n343), .B1(n345), .Y(
        n347) );
  OAI32XLM U423 ( .A0(n349), .A1(ALU_function[2]), .A2(n348), .B0(
        ALU_function[1]), .B1(n347), .Y(n356) );
  OAI32XLM U424 ( .A0(n372), .A1(n352), .A2(n351), .B0(n350), .B1(B[0]), .Y(
        n354) );
  AOI21XLM U425 ( .A0(n354), .A1(n353), .B0(n364), .Y(n355) );
  AOI31XLM U426 ( .A0(enable), .A1(ALU_function[3]), .A2(n356), .B0(n355), .Y(
        n357) );
  OAI211XLM U427 ( .A0(n360), .A1(n359), .B0(n358), .C0(n357), .Y(N179) );
  XOR2XLM U428 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[4]), .Y(
        \DP_OP_29J1_122_2578/n25 ) );
  XOR2XLM U429 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[3]), .Y(
        \DP_OP_29J1_122_2578/n26 ) );
  XOR2XLM U430 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[7]), .Y(
        \DP_OP_29J1_122_2578/n22 ) );
  XOR2XLM U431 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[6]), .Y(
        \DP_OP_29J1_122_2578/n23 ) );
  XOR2XLM U432 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[5]), .Y(
        \DP_OP_29J1_122_2578/n24 ) );
  XOR2XLM U433 ( .A(\DP_OP_29J1_122_2578/n43 ), .B(B[0]), .Y(
        \DP_OP_29J1_122_2578/n29 ) );
  AOI221XLM U434 ( .A0(n364), .A1(n363), .B0(n362), .B1(n363), .C0(n361), .Y(
        \intadd_7/B[0] ) );
  NAND2XLM U435 ( .A(A[2]), .B(B[1]), .Y(n367) );
  AOI221XLM U436 ( .A0(n372), .A1(n367), .B0(n366), .B1(n367), .C0(n365), .Y(
        \intadd_7/A[1] ) );
  NAND2XLM U437 ( .A(A[3]), .B(B[1]), .Y(n369) );
  AOI221XLM U438 ( .A0(n372), .A1(n369), .B0(n368), .B1(n369), .C0(
        \intadd_1/A[0] ), .Y(\intadd_6/B[0] ) );
  NAND2XLM U439 ( .A(A[5]), .B(B[1]), .Y(n371) );
  AOI221XLM U440 ( .A0(n372), .A1(n371), .B0(n370), .B1(n371), .C0(
        \intadd_0/A[0] ), .Y(\intadd_3/B[0] ) );
  ADDFX1M U441 ( .A(\intadd_3/SUM[0] ), .B(\intadd_1/SUM[1] ), .CI(
        \intadd_4/SUM[0] ), .CO(n189), .S(\intadd_6/B[2] ) );
endmodule


module register_file ( clk, reset, address, write_enable, write_data, 
        read_enable, read_data, read_data_valid, register0, register1, 
        register2, register3 );
  input [3:0] address;
  input [7:0] write_data;
  output [7:0] read_data;
  output [7:0] register0;
  output [7:0] register1;
  output [7:0] register2;
  output [7:0] register3;
  input clk, reset, write_enable, read_enable;
  output read_data_valid;
  wire   n288, n289, n290, n291, n292, n293, n294, n295, \memory[4][7] ,
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
         \memory[15][2] , \memory[15][1] , \memory[15][0] , N61, n150, n151,
         n152, n153, n154, n155, n156, n157, n158, n159, n160, n161, n162,
         n163, n164, n165, n166, n167, n168, n169, n170, n171, n172, n173,
         n174, n175, n176, n177, n178, n179, n180, n181, n182, n183, n184,
         n185, n186, n187, n188, n189, n190, n191, n192, n193, n194, n195,
         n196, n197, n198, n199, n200, n201, n202, n203, n204, n205, n206,
         n207, n208, n209, n210, n211, n212, n213, n214, n215, n216, n217,
         n218, n219, n220, n221, n222, n223, n224, n225, n226, n227, n228,
         n229, n230, n231, n232, n233, n234, n235, n236, n237, n238, n239,
         n240, n241, n242, n243, n244, n245, n246, n247, n248, n249, n250,
         n251, n252, n253, n254, n255, n256, n257, n258, n259, n260, n261,
         n262, n263, n264, n265, n266, n267, n268, n269, n270, n271, n272,
         n273, n274, n275, n276, n277, n278, n279, n280, n281, n282, n283,
         n284, n285, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
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
         n143, n144, n145, n146, n147, n148, n149, n286, n287;

  DFFRQX1M \memory_reg[0][7]  ( .D(n285), .CK(clk), .RN(n287), .Q(register0[7]) );
  DFFRQX1M \memory_reg[0][6]  ( .D(n284), .CK(clk), .RN(n148), .Q(register0[6]) );
  DFFRQX1M \memory_reg[0][5]  ( .D(n283), .CK(clk), .RN(n286), .Q(register0[5]) );
  DFFRQX1M \memory_reg[0][4]  ( .D(n282), .CK(clk), .RN(n149), .Q(register0[4]) );
  DFFRQX1M \memory_reg[0][3]  ( .D(n281), .CK(clk), .RN(n287), .Q(register0[3]) );
  DFFRQX1M \memory_reg[0][2]  ( .D(n280), .CK(clk), .RN(n148), .Q(register0[2]) );
  DFFRQX1M \memory_reg[0][1]  ( .D(n279), .CK(clk), .RN(n286), .Q(register0[1]) );
  DFFRQX1M \memory_reg[0][0]  ( .D(n278), .CK(clk), .RN(n149), .Q(register0[0]) );
  DFFRQX1M \memory_reg[1][7]  ( .D(n277), .CK(clk), .RN(n287), .Q(register1[7]) );
  DFFRQX1M \memory_reg[1][6]  ( .D(n276), .CK(clk), .RN(n148), .Q(register1[6]) );
  DFFRQX1M \memory_reg[1][5]  ( .D(n275), .CK(clk), .RN(n286), .Q(register1[5]) );
  DFFRQX1M \memory_reg[1][4]  ( .D(n274), .CK(clk), .RN(n149), .Q(register1[4]) );
  DFFRQX1M \memory_reg[1][3]  ( .D(n273), .CK(clk), .RN(n287), .Q(register1[3]) );
  DFFRQX1M \memory_reg[1][2]  ( .D(n272), .CK(clk), .RN(reset), .Q(
        register1[2]) );
  DFFRQX1M \memory_reg[1][1]  ( .D(n271), .CK(clk), .RN(reset), .Q(
        register1[1]) );
  DFFRQX1M \memory_reg[1][0]  ( .D(n270), .CK(clk), .RN(reset), .Q(
        register1[0]) );
  DFFRQX1M \memory_reg[2][7]  ( .D(n269), .CK(clk), .RN(reset), .Q(n288) );
  DFFRQX1M \memory_reg[2][6]  ( .D(n268), .CK(clk), .RN(reset), .Q(n289) );
  DFFRQX1M \memory_reg[2][5]  ( .D(n267), .CK(clk), .RN(reset), .Q(n290) );
  DFFRQX1M \memory_reg[2][4]  ( .D(n266), .CK(clk), .RN(reset), .Q(n291) );
  DFFRQX1M \memory_reg[2][3]  ( .D(n265), .CK(clk), .RN(reset), .Q(n292) );
  DFFRQX1M \memory_reg[2][2]  ( .D(n264), .CK(clk), .RN(n148), .Q(n293) );
  DFFRQX1M \memory_reg[2][1]  ( .D(n263), .CK(clk), .RN(n287), .Q(register2[1]) );
  DFFRQX1M \memory_reg[3][7]  ( .D(n261), .CK(clk), .RN(n149), .Q(n294) );
  DFFRQX1M \memory_reg[3][6]  ( .D(n260), .CK(clk), .RN(n286), .Q(n295) );
  DFFRQX1M \memory_reg[3][5]  ( .D(n259), .CK(clk), .RN(n148), .Q(register3[5]) );
  DFFRQX1M \memory_reg[3][4]  ( .D(n258), .CK(clk), .RN(n148), .Q(register3[4]) );
  DFFRQX1M \memory_reg[3][2]  ( .D(n256), .CK(clk), .RN(n148), .Q(register3[2]) );
  DFFRQX1M \memory_reg[3][1]  ( .D(n255), .CK(clk), .RN(n148), .Q(register3[1]) );
  DFFRQX1M \memory_reg[3][0]  ( .D(n254), .CK(clk), .RN(n148), .Q(register3[0]) );
  DFFRQX1M \memory_reg[4][7]  ( .D(n253), .CK(clk), .RN(n148), .Q(
        \memory[4][7] ) );
  DFFRQX1M \memory_reg[4][6]  ( .D(n252), .CK(clk), .RN(n148), .Q(
        \memory[4][6] ) );
  DFFRQX1M \memory_reg[4][5]  ( .D(n251), .CK(clk), .RN(n148), .Q(
        \memory[4][5] ) );
  DFFRQX1M \memory_reg[4][4]  ( .D(n250), .CK(clk), .RN(n148), .Q(
        \memory[4][4] ) );
  DFFRQX1M \memory_reg[4][3]  ( .D(n249), .CK(clk), .RN(n148), .Q(
        \memory[4][3] ) );
  DFFRQX1M \memory_reg[4][2]  ( .D(n248), .CK(clk), .RN(n148), .Q(
        \memory[4][2] ) );
  DFFRQX1M \memory_reg[4][1]  ( .D(n247), .CK(clk), .RN(n148), .Q(
        \memory[4][1] ) );
  DFFRQX1M \memory_reg[4][0]  ( .D(n246), .CK(clk), .RN(n148), .Q(
        \memory[4][0] ) );
  DFFRQX1M \memory_reg[5][7]  ( .D(n245), .CK(clk), .RN(n148), .Q(
        \memory[5][7] ) );
  DFFRQX1M \memory_reg[5][6]  ( .D(n244), .CK(clk), .RN(n287), .Q(
        \memory[5][6] ) );
  DFFRQX1M \memory_reg[5][5]  ( .D(n243), .CK(clk), .RN(n287), .Q(
        \memory[5][5] ) );
  DFFRQX1M \memory_reg[5][4]  ( .D(n242), .CK(clk), .RN(n287), .Q(
        \memory[5][4] ) );
  DFFRQX1M \memory_reg[5][3]  ( .D(n241), .CK(clk), .RN(n287), .Q(
        \memory[5][3] ) );
  DFFRQX1M \memory_reg[5][2]  ( .D(n240), .CK(clk), .RN(n287), .Q(
        \memory[5][2] ) );
  DFFRQX1M \memory_reg[5][1]  ( .D(n239), .CK(clk), .RN(n287), .Q(
        \memory[5][1] ) );
  DFFRQX1M \memory_reg[5][0]  ( .D(n238), .CK(clk), .RN(n287), .Q(
        \memory[5][0] ) );
  DFFRQX1M \memory_reg[6][7]  ( .D(n237), .CK(clk), .RN(n287), .Q(
        \memory[6][7] ) );
  DFFRQX1M \memory_reg[6][6]  ( .D(n236), .CK(clk), .RN(n287), .Q(
        \memory[6][6] ) );
  DFFRQX1M \memory_reg[6][5]  ( .D(n235), .CK(clk), .RN(n287), .Q(
        \memory[6][5] ) );
  DFFRQX1M \memory_reg[6][4]  ( .D(n234), .CK(clk), .RN(n287), .Q(
        \memory[6][4] ) );
  DFFRQX1M \memory_reg[6][3]  ( .D(n233), .CK(clk), .RN(n287), .Q(
        \memory[6][3] ) );
  DFFRQX1M \memory_reg[6][2]  ( .D(n232), .CK(clk), .RN(n287), .Q(
        \memory[6][2] ) );
  DFFRQX1M \memory_reg[6][1]  ( .D(n231), .CK(clk), .RN(n287), .Q(
        \memory[6][1] ) );
  DFFRQX1M \memory_reg[6][0]  ( .D(n230), .CK(clk), .RN(n287), .Q(
        \memory[6][0] ) );
  DFFRQX1M \memory_reg[7][7]  ( .D(n229), .CK(clk), .RN(n287), .Q(
        \memory[7][7] ) );
  DFFRQX1M \memory_reg[7][6]  ( .D(n228), .CK(clk), .RN(n287), .Q(
        \memory[7][6] ) );
  DFFRQX1M \memory_reg[7][5]  ( .D(n227), .CK(clk), .RN(n287), .Q(
        \memory[7][5] ) );
  DFFRQX1M \memory_reg[7][4]  ( .D(n226), .CK(clk), .RN(n287), .Q(
        \memory[7][4] ) );
  DFFRQX1M \memory_reg[7][3]  ( .D(n225), .CK(clk), .RN(n287), .Q(
        \memory[7][3] ) );
  DFFRQX1M \memory_reg[7][2]  ( .D(n224), .CK(clk), .RN(n287), .Q(
        \memory[7][2] ) );
  DFFRQX1M \memory_reg[7][1]  ( .D(n223), .CK(clk), .RN(n287), .Q(
        \memory[7][1] ) );
  DFFRQX1M \memory_reg[7][0]  ( .D(n222), .CK(clk), .RN(n287), .Q(
        \memory[7][0] ) );
  DFFRQX1M \memory_reg[8][7]  ( .D(n221), .CK(clk), .RN(n287), .Q(
        \memory[8][7] ) );
  DFFRQX1M \memory_reg[8][6]  ( .D(n220), .CK(clk), .RN(n287), .Q(
        \memory[8][6] ) );
  DFFRQX1M \memory_reg[8][5]  ( .D(n219), .CK(clk), .RN(n148), .Q(
        \memory[8][5] ) );
  DFFRQX1M \memory_reg[8][4]  ( .D(n218), .CK(clk), .RN(n149), .Q(
        \memory[8][4] ) );
  DFFRQX1M \memory_reg[8][3]  ( .D(n217), .CK(clk), .RN(n149), .Q(
        \memory[8][3] ) );
  DFFRQX1M \memory_reg[8][2]  ( .D(n216), .CK(clk), .RN(n149), .Q(
        \memory[8][2] ) );
  DFFRQX1M \memory_reg[8][1]  ( .D(n215), .CK(clk), .RN(n149), .Q(
        \memory[8][1] ) );
  DFFRQX1M \memory_reg[8][0]  ( .D(n214), .CK(clk), .RN(n149), .Q(
        \memory[8][0] ) );
  DFFRQX1M \memory_reg[9][7]  ( .D(n213), .CK(clk), .RN(n149), .Q(
        \memory[9][7] ) );
  DFFRQX1M \memory_reg[9][6]  ( .D(n212), .CK(clk), .RN(n149), .Q(
        \memory[9][6] ) );
  DFFRQX1M \memory_reg[9][5]  ( .D(n211), .CK(clk), .RN(n149), .Q(
        \memory[9][5] ) );
  DFFRQX1M \memory_reg[9][4]  ( .D(n210), .CK(clk), .RN(n149), .Q(
        \memory[9][4] ) );
  DFFRQX1M \memory_reg[9][3]  ( .D(n209), .CK(clk), .RN(n149), .Q(
        \memory[9][3] ) );
  DFFRQX1M \memory_reg[9][2]  ( .D(n208), .CK(clk), .RN(n149), .Q(
        \memory[9][2] ) );
  DFFRQX1M \memory_reg[9][1]  ( .D(n207), .CK(clk), .RN(n149), .Q(
        \memory[9][1] ) );
  DFFRQX1M \memory_reg[9][0]  ( .D(n206), .CK(clk), .RN(n149), .Q(
        \memory[9][0] ) );
  DFFRQX1M \memory_reg[10][7]  ( .D(n205), .CK(clk), .RN(n286), .Q(
        \memory[10][7] ) );
  DFFRQX1M \memory_reg[10][6]  ( .D(n204), .CK(clk), .RN(n286), .Q(
        \memory[10][6] ) );
  DFFRQX1M \memory_reg[10][5]  ( .D(n203), .CK(clk), .RN(n286), .Q(
        \memory[10][5] ) );
  DFFRQX1M \memory_reg[10][4]  ( .D(n202), .CK(clk), .RN(n286), .Q(
        \memory[10][4] ) );
  DFFRQX1M \memory_reg[10][3]  ( .D(n201), .CK(clk), .RN(n286), .Q(
        \memory[10][3] ) );
  DFFRQX1M \memory_reg[10][2]  ( .D(n200), .CK(clk), .RN(n286), .Q(
        \memory[10][2] ) );
  DFFRQX1M \memory_reg[10][1]  ( .D(n199), .CK(clk), .RN(n286), .Q(
        \memory[10][1] ) );
  DFFRQX1M \memory_reg[10][0]  ( .D(n198), .CK(clk), .RN(n286), .Q(
        \memory[10][0] ) );
  DFFRQX1M \memory_reg[11][7]  ( .D(n197), .CK(clk), .RN(n286), .Q(
        \memory[11][7] ) );
  DFFRQX1M \memory_reg[11][6]  ( .D(n196), .CK(clk), .RN(n286), .Q(
        \memory[11][6] ) );
  DFFRQX1M \memory_reg[11][5]  ( .D(n195), .CK(clk), .RN(n286), .Q(
        \memory[11][5] ) );
  DFFRQX1M \memory_reg[11][4]  ( .D(n194), .CK(clk), .RN(n286), .Q(
        \memory[11][4] ) );
  DFFRQX1M \memory_reg[11][3]  ( .D(n193), .CK(clk), .RN(n286), .Q(
        \memory[11][3] ) );
  DFFRQX1M \memory_reg[11][2]  ( .D(n192), .CK(clk), .RN(n286), .Q(
        \memory[11][2] ) );
  DFFRQX1M \memory_reg[11][1]  ( .D(n191), .CK(clk), .RN(n286), .Q(
        \memory[11][1] ) );
  DFFRQX1M \memory_reg[11][0]  ( .D(n190), .CK(clk), .RN(n286), .Q(
        \memory[11][0] ) );
  DFFRQX1M \memory_reg[12][7]  ( .D(n189), .CK(clk), .RN(n286), .Q(
        \memory[12][7] ) );
  DFFRQX1M \memory_reg[12][6]  ( .D(n188), .CK(clk), .RN(n286), .Q(
        \memory[12][6] ) );
  DFFRQX1M \memory_reg[12][5]  ( .D(n187), .CK(clk), .RN(n286), .Q(
        \memory[12][5] ) );
  DFFRQX1M \memory_reg[12][4]  ( .D(n186), .CK(clk), .RN(n286), .Q(
        \memory[12][4] ) );
  DFFRQX1M \memory_reg[12][3]  ( .D(n185), .CK(clk), .RN(n286), .Q(
        \memory[12][3] ) );
  DFFRQX1M \memory_reg[12][2]  ( .D(n184), .CK(clk), .RN(n286), .Q(
        \memory[12][2] ) );
  DFFRQX1M \memory_reg[12][1]  ( .D(n183), .CK(clk), .RN(n286), .Q(
        \memory[12][1] ) );
  DFFRQX1M \memory_reg[12][0]  ( .D(n182), .CK(clk), .RN(n286), .Q(
        \memory[12][0] ) );
  DFFRQX1M \memory_reg[13][7]  ( .D(n181), .CK(clk), .RN(n286), .Q(
        \memory[13][7] ) );
  DFFRQX1M \memory_reg[13][6]  ( .D(n180), .CK(clk), .RN(n149), .Q(
        \memory[13][6] ) );
  DFFRQX1M \memory_reg[13][5]  ( .D(n179), .CK(clk), .RN(n148), .Q(
        \memory[13][5] ) );
  DFFRQX1M \memory_reg[13][4]  ( .D(n178), .CK(clk), .RN(n149), .Q(
        \memory[13][4] ) );
  DFFRQX1M \memory_reg[13][3]  ( .D(n177), .CK(clk), .RN(n148), .Q(
        \memory[13][3] ) );
  DFFRQX1M \memory_reg[13][2]  ( .D(n176), .CK(clk), .RN(n149), .Q(
        \memory[13][2] ) );
  DFFRQX1M \memory_reg[13][1]  ( .D(n175), .CK(clk), .RN(n148), .Q(
        \memory[13][1] ) );
  DFFRQX1M \memory_reg[13][0]  ( .D(n174), .CK(clk), .RN(n149), .Q(
        \memory[13][0] ) );
  DFFRQX1M \memory_reg[14][7]  ( .D(n173), .CK(clk), .RN(n148), .Q(
        \memory[14][7] ) );
  DFFRQX1M \memory_reg[14][6]  ( .D(n172), .CK(clk), .RN(n149), .Q(
        \memory[14][6] ) );
  DFFRQX1M \memory_reg[14][5]  ( .D(n171), .CK(clk), .RN(n148), .Q(
        \memory[14][5] ) );
  DFFRQX1M \memory_reg[14][4]  ( .D(n170), .CK(clk), .RN(n149), .Q(
        \memory[14][4] ) );
  DFFRQX1M \memory_reg[14][3]  ( .D(n169), .CK(clk), .RN(n148), .Q(
        \memory[14][3] ) );
  DFFRQX1M \memory_reg[14][2]  ( .D(n168), .CK(clk), .RN(n149), .Q(
        \memory[14][2] ) );
  DFFRQX1M \memory_reg[14][1]  ( .D(n167), .CK(clk), .RN(n148), .Q(
        \memory[14][1] ) );
  DFFRQX1M \memory_reg[14][0]  ( .D(n166), .CK(clk), .RN(n149), .Q(
        \memory[14][0] ) );
  DFFRQX1M \memory_reg[15][7]  ( .D(n165), .CK(clk), .RN(n287), .Q(
        \memory[15][7] ) );
  DFFRQX1M \memory_reg[15][6]  ( .D(n164), .CK(clk), .RN(n286), .Q(
        \memory[15][6] ) );
  DFFRQX1M \memory_reg[15][5]  ( .D(n163), .CK(clk), .RN(n148), .Q(
        \memory[15][5] ) );
  DFFRQX1M \memory_reg[15][4]  ( .D(n162), .CK(clk), .RN(n149), .Q(
        \memory[15][4] ) );
  DFFRQX1M \memory_reg[15][3]  ( .D(n161), .CK(clk), .RN(n287), .Q(
        \memory[15][3] ) );
  DFFRQX1M \memory_reg[15][2]  ( .D(n160), .CK(clk), .RN(n286), .Q(
        \memory[15][2] ) );
  DFFRQX1M \memory_reg[15][1]  ( .D(n159), .CK(clk), .RN(n148), .Q(
        \memory[15][1] ) );
  DFFRQX1M \memory_reg[15][0]  ( .D(n158), .CK(clk), .RN(n149), .Q(
        \memory[15][0] ) );
  DFFRQX1M \read_data_reg[7]  ( .D(n157), .CK(clk), .RN(n148), .Q(read_data[7]) );
  DFFRQX1M \read_data_reg[6]  ( .D(n156), .CK(clk), .RN(n149), .Q(read_data[6]) );
  DFFRQX1M \read_data_reg[5]  ( .D(n155), .CK(clk), .RN(n148), .Q(read_data[5]) );
  DFFRQX1M \read_data_reg[4]  ( .D(n154), .CK(clk), .RN(n149), .Q(read_data[4]) );
  DFFRQX1M \read_data_reg[3]  ( .D(n153), .CK(clk), .RN(n149), .Q(read_data[3]) );
  DFFRQX1M \read_data_reg[2]  ( .D(n152), .CK(clk), .RN(n148), .Q(read_data[2]) );
  DFFRQX1M \read_data_reg[1]  ( .D(n151), .CK(clk), .RN(n149), .Q(read_data[1]) );
  DFFRQX1M \read_data_reg[0]  ( .D(n150), .CK(clk), .RN(n148), .Q(read_data[0]) );
  DFFRQX1M read_data_valid_reg ( .D(N61), .CK(clk), .RN(n149), .Q(
        read_data_valid) );
  DFFSQX2M \memory_reg[2][0]  ( .D(n262), .CK(clk), .SN(n286), .Q(register2[0]) );
  DFFSQX2M \memory_reg[3][3]  ( .D(n257), .CK(clk), .SN(n148), .Q(register3[3]) );
  CLKINVX1M U3 ( .A(n113), .Y(n4) );
  NOR2XLM U4 ( .A(n126), .B(n127), .Y(n95) );
  AOI22XLM U5 ( .A0(n100), .A1(\memory[12][1] ), .B0(n99), .B1(\memory[13][1] ), .Y(n11) );
  AOI22XLM U6 ( .A0(n102), .A1(\memory[14][3] ), .B0(n101), .B1(
        \memory[15][3] ), .Y(n43) );
  AOI22XLM U7 ( .A0(n102), .A1(\memory[14][5] ), .B0(n101), .B1(
        \memory[15][5] ), .Y(n54) );
  AOI22XLM U8 ( .A0(n86), .A1(n289), .B0(n85), .B1(n295), .Y(n30) );
  NAND4XLM U9 ( .A(n35), .B(n34), .C(n33), .D(n32), .Y(n36) );
  OAI32XLM U10 ( .A0(n109), .A1(n108), .A2(n107), .B0(read_data[2]), .B1(N61), 
        .Y(n110) );
  NOR2XLM U11 ( .A(n138), .B(n119), .Y(n120) );
  CLKINVX1M U12 ( .A(n109), .Y(N61) );
  BUFX2M U13 ( .A(reset), .Y(n286) );
  BUFX2M U14 ( .A(n286), .Y(n149) );
  BUFX2M U15 ( .A(reset), .Y(n287) );
  BUFX2M U16 ( .A(n287), .Y(n148) );
  NAND2BXLM U17 ( .AN(write_enable), .B(read_enable), .Y(n109) );
  CLKINVX1M U18 ( .A(address[2]), .Y(n1) );
  CLKINVX1M U19 ( .A(address[1]), .Y(n2) );
  NAND2XLM U20 ( .A(n1), .B(n2), .Y(n127) );
  NOR2XLM U21 ( .A(address[0]), .B(address[3]), .Y(n111) );
  CLKINVX1M U22 ( .A(n111), .Y(n3) );
  NOR2XLM U23 ( .A(n127), .B(n3), .Y(n84) );
  CLKINVX1M U24 ( .A(address[0]), .Y(n9) );
  NOR2XLM U25 ( .A(n9), .B(address[3]), .Y(n113) );
  NOR2XLM U26 ( .A(n127), .B(n4), .Y(n83) );
  AOI22XLM U27 ( .A0(n84), .A1(register0[1]), .B0(n83), .B1(register1[1]), .Y(
        n8) );
  NAND2XLM U28 ( .A(address[1]), .B(n1), .Y(n130) );
  NOR2XLM U29 ( .A(n130), .B(n3), .Y(n86) );
  NOR2XLM U30 ( .A(n130), .B(n4), .Y(n85) );
  AOI22XLM U31 ( .A0(n86), .A1(register2[1]), .B0(n85), .B1(register3[1]), .Y(
        n7) );
  NAND2XLM U32 ( .A(address[2]), .B(n2), .Y(n133) );
  NOR2XLM U33 ( .A(n133), .B(n3), .Y(n88) );
  NOR2XLM U34 ( .A(n133), .B(n4), .Y(n87) );
  AOI22XLM U35 ( .A0(n88), .A1(\memory[4][1] ), .B0(n87), .B1(\memory[5][1] ), 
        .Y(n6) );
  NAND2XLM U36 ( .A(address[2]), .B(address[1]), .Y(n138) );
  NOR2XLM U37 ( .A(n138), .B(n3), .Y(n90) );
  NOR2XLM U38 ( .A(n138), .B(n4), .Y(n89) );
  AOI22XLM U39 ( .A0(n90), .A1(\memory[6][1] ), .B0(n89), .B1(\memory[7][1] ), 
        .Y(n5) );
  NAND4XLM U40 ( .A(n8), .B(n7), .C(n6), .D(n5), .Y(n15) );
  NAND2XLM U41 ( .A(address[3]), .B(n9), .Y(n123) );
  NOR2XLM U42 ( .A(n123), .B(n127), .Y(n96) );
  NAND2XLM U43 ( .A(address[0]), .B(address[3]), .Y(n126) );
  AOI22XLM U44 ( .A0(n96), .A1(\memory[8][1] ), .B0(n95), .B1(\memory[9][1] ), 
        .Y(n13) );
  NOR2XLM U45 ( .A(n123), .B(n130), .Y(n98) );
  NOR2XLM U46 ( .A(n130), .B(n126), .Y(n97) );
  AOI22XLM U47 ( .A0(n98), .A1(\memory[10][1] ), .B0(n97), .B1(\memory[11][1] ), .Y(n12) );
  NOR2XLM U48 ( .A(n123), .B(n133), .Y(n100) );
  NOR2XLM U49 ( .A(n126), .B(n133), .Y(n99) );
  NOR2XLM U50 ( .A(n123), .B(n138), .Y(n102) );
  NOR2XLM U51 ( .A(n126), .B(n138), .Y(n101) );
  AOI22XLM U52 ( .A0(n102), .A1(\memory[14][1] ), .B0(n101), .B1(
        \memory[15][1] ), .Y(n10) );
  NAND4XLM U53 ( .A(n13), .B(n12), .C(n11), .D(n10), .Y(n14) );
  OAI32XLM U54 ( .A0(n109), .A1(n15), .A2(n14), .B0(read_data[1]), .B1(N61), 
        .Y(n16) );
  CLKINVX1M U55 ( .A(n16), .Y(n151) );
  AOI22XLM U56 ( .A0(n84), .A1(register0[0]), .B0(n83), .B1(register1[0]), .Y(
        n20) );
  AOI22XLM U57 ( .A0(n86), .A1(register2[0]), .B0(n85), .B1(register3[0]), .Y(
        n19) );
  AOI22XLM U58 ( .A0(n88), .A1(\memory[4][0] ), .B0(n87), .B1(\memory[5][0] ), 
        .Y(n18) );
  AOI22XLM U59 ( .A0(n90), .A1(\memory[6][0] ), .B0(n89), .B1(\memory[7][0] ), 
        .Y(n17) );
  NAND4XLM U60 ( .A(n20), .B(n19), .C(n18), .D(n17), .Y(n26) );
  AOI22XLM U61 ( .A0(n96), .A1(\memory[8][0] ), .B0(n95), .B1(\memory[9][0] ), 
        .Y(n24) );
  AOI22XLM U62 ( .A0(n98), .A1(\memory[10][0] ), .B0(n97), .B1(\memory[11][0] ), .Y(n23) );
  AOI22XLM U63 ( .A0(n100), .A1(\memory[12][0] ), .B0(n99), .B1(
        \memory[13][0] ), .Y(n22) );
  AOI22XLM U64 ( .A0(n102), .A1(\memory[14][0] ), .B0(n101), .B1(
        \memory[15][0] ), .Y(n21) );
  NAND4XLM U65 ( .A(n24), .B(n23), .C(n22), .D(n21), .Y(n25) );
  OAI32XLM U66 ( .A0(n109), .A1(n26), .A2(n25), .B0(read_data[0]), .B1(N61), 
        .Y(n27) );
  CLKINVX1M U67 ( .A(n27), .Y(n150) );
  AOI22XLM U68 ( .A0(n84), .A1(register0[6]), .B0(n83), .B1(register1[6]), .Y(
        n31) );
  AOI22XLM U69 ( .A0(n88), .A1(\memory[4][6] ), .B0(n87), .B1(\memory[5][6] ), 
        .Y(n29) );
  AOI22XLM U70 ( .A0(n90), .A1(\memory[6][6] ), .B0(n89), .B1(\memory[7][6] ), 
        .Y(n28) );
  NAND4XLM U71 ( .A(n31), .B(n30), .C(n29), .D(n28), .Y(n37) );
  AOI22XLM U72 ( .A0(n96), .A1(\memory[8][6] ), .B0(n95), .B1(\memory[9][6] ), 
        .Y(n35) );
  AOI22XLM U73 ( .A0(n98), .A1(\memory[10][6] ), .B0(n97), .B1(\memory[11][6] ), .Y(n34) );
  AOI22XLM U74 ( .A0(n100), .A1(\memory[12][6] ), .B0(n99), .B1(
        \memory[13][6] ), .Y(n33) );
  AOI22XLM U75 ( .A0(n102), .A1(\memory[14][6] ), .B0(n101), .B1(
        \memory[15][6] ), .Y(n32) );
  OAI32XLM U76 ( .A0(n109), .A1(n37), .A2(n36), .B0(read_data[6]), .B1(N61), 
        .Y(n38) );
  CLKINVX1M U77 ( .A(n38), .Y(n156) );
  AOI22XLM U78 ( .A0(n84), .A1(register0[3]), .B0(n83), .B1(register1[3]), .Y(
        n42) );
  AOI22XLM U79 ( .A0(n86), .A1(n292), .B0(n85), .B1(register3[3]), .Y(n41) );
  AOI22XLM U80 ( .A0(n88), .A1(\memory[4][3] ), .B0(n87), .B1(\memory[5][3] ), 
        .Y(n40) );
  AOI22XLM U81 ( .A0(n90), .A1(\memory[6][3] ), .B0(n89), .B1(\memory[7][3] ), 
        .Y(n39) );
  NAND4XLM U82 ( .A(n42), .B(n41), .C(n40), .D(n39), .Y(n48) );
  AOI22XLM U83 ( .A0(n96), .A1(\memory[8][3] ), .B0(n95), .B1(\memory[9][3] ), 
        .Y(n46) );
  AOI22XLM U84 ( .A0(n98), .A1(\memory[10][3] ), .B0(n97), .B1(\memory[11][3] ), .Y(n45) );
  AOI22XLM U85 ( .A0(n100), .A1(\memory[12][3] ), .B0(n99), .B1(
        \memory[13][3] ), .Y(n44) );
  NAND4XLM U86 ( .A(n46), .B(n45), .C(n44), .D(n43), .Y(n47) );
  OAI32XLM U87 ( .A0(n109), .A1(n48), .A2(n47), .B0(read_data[3]), .B1(N61), 
        .Y(n49) );
  CLKINVX1M U88 ( .A(n49), .Y(n153) );
  AOI22XLM U89 ( .A0(n84), .A1(register0[5]), .B0(n83), .B1(register1[5]), .Y(
        n53) );
  AOI22XLM U90 ( .A0(n86), .A1(n290), .B0(n85), .B1(register3[5]), .Y(n52) );
  AOI22XLM U91 ( .A0(n88), .A1(\memory[4][5] ), .B0(n87), .B1(\memory[5][5] ), 
        .Y(n51) );
  AOI22XLM U92 ( .A0(n90), .A1(\memory[6][5] ), .B0(n89), .B1(\memory[7][5] ), 
        .Y(n50) );
  NAND4XLM U93 ( .A(n53), .B(n52), .C(n51), .D(n50), .Y(n59) );
  AOI22XLM U94 ( .A0(n96), .A1(\memory[8][5] ), .B0(n95), .B1(\memory[9][5] ), 
        .Y(n57) );
  AOI22XLM U95 ( .A0(n98), .A1(\memory[10][5] ), .B0(n97), .B1(\memory[11][5] ), .Y(n56) );
  AOI22XLM U96 ( .A0(n100), .A1(\memory[12][5] ), .B0(n99), .B1(
        \memory[13][5] ), .Y(n55) );
  NAND4XLM U97 ( .A(n57), .B(n56), .C(n55), .D(n54), .Y(n58) );
  OAI32XLM U98 ( .A0(n109), .A1(n59), .A2(n58), .B0(read_data[5]), .B1(N61), 
        .Y(n60) );
  CLKINVX1M U99 ( .A(n60), .Y(n155) );
  AOI22XLM U100 ( .A0(n84), .A1(register0[7]), .B0(n83), .B1(register1[7]), 
        .Y(n64) );
  AOI22XLM U101 ( .A0(n86), .A1(n288), .B0(n85), .B1(n294), .Y(n63) );
  AOI22XLM U102 ( .A0(n88), .A1(\memory[4][7] ), .B0(n87), .B1(\memory[5][7] ), 
        .Y(n62) );
  AOI22XLM U103 ( .A0(n90), .A1(\memory[6][7] ), .B0(n89), .B1(\memory[7][7] ), 
        .Y(n61) );
  NAND4XLM U104 ( .A(n64), .B(n63), .C(n62), .D(n61), .Y(n70) );
  AOI22XLM U105 ( .A0(n96), .A1(\memory[8][7] ), .B0(n95), .B1(\memory[9][7] ), 
        .Y(n68) );
  AOI22XLM U106 ( .A0(n98), .A1(\memory[10][7] ), .B0(n97), .B1(
        \memory[11][7] ), .Y(n67) );
  AOI22XLM U107 ( .A0(n100), .A1(\memory[12][7] ), .B0(n99), .B1(
        \memory[13][7] ), .Y(n66) );
  AOI22XLM U108 ( .A0(n102), .A1(\memory[14][7] ), .B0(n101), .B1(
        \memory[15][7] ), .Y(n65) );
  NAND4XLM U109 ( .A(n68), .B(n67), .C(n66), .D(n65), .Y(n69) );
  OAI32XLM U110 ( .A0(n109), .A1(n70), .A2(n69), .B0(read_data[7]), .B1(N61), 
        .Y(n71) );
  CLKINVX1M U111 ( .A(n71), .Y(n157) );
  AOI22XLM U112 ( .A0(n84), .A1(register0[4]), .B0(n83), .B1(register1[4]), 
        .Y(n75) );
  AOI22XLM U113 ( .A0(n86), .A1(n291), .B0(n85), .B1(register3[4]), .Y(n74) );
  AOI22XLM U114 ( .A0(n88), .A1(\memory[4][4] ), .B0(n87), .B1(\memory[5][4] ), 
        .Y(n73) );
  AOI22XLM U115 ( .A0(n90), .A1(\memory[6][4] ), .B0(n89), .B1(\memory[7][4] ), 
        .Y(n72) );
  NAND4XLM U116 ( .A(n75), .B(n74), .C(n73), .D(n72), .Y(n81) );
  AOI22XLM U117 ( .A0(n96), .A1(\memory[8][4] ), .B0(n95), .B1(\memory[9][4] ), 
        .Y(n79) );
  AOI22XLM U118 ( .A0(n98), .A1(\memory[10][4] ), .B0(n97), .B1(
        \memory[11][4] ), .Y(n78) );
  AOI22XLM U119 ( .A0(n100), .A1(\memory[12][4] ), .B0(n99), .B1(
        \memory[13][4] ), .Y(n77) );
  AOI22XLM U120 ( .A0(n102), .A1(\memory[14][4] ), .B0(n101), .B1(
        \memory[15][4] ), .Y(n76) );
  NAND4XLM U121 ( .A(n79), .B(n78), .C(n77), .D(n76), .Y(n80) );
  OAI32XLM U122 ( .A0(n109), .A1(n81), .A2(n80), .B0(read_data[4]), .B1(N61), 
        .Y(n82) );
  CLKINVX1M U123 ( .A(n82), .Y(n154) );
  AOI22XLM U124 ( .A0(n84), .A1(register0[2]), .B0(n83), .B1(register1[2]), 
        .Y(n94) );
  AOI22XLM U125 ( .A0(n86), .A1(n293), .B0(n85), .B1(register3[2]), .Y(n93) );
  AOI22XLM U126 ( .A0(n88), .A1(\memory[4][2] ), .B0(n87), .B1(\memory[5][2] ), 
        .Y(n92) );
  AOI22XLM U127 ( .A0(n90), .A1(\memory[6][2] ), .B0(n89), .B1(\memory[7][2] ), 
        .Y(n91) );
  NAND4XLM U128 ( .A(n94), .B(n93), .C(n92), .D(n91), .Y(n108) );
  AOI22XLM U129 ( .A0(n96), .A1(\memory[8][2] ), .B0(n95), .B1(\memory[9][2] ), 
        .Y(n106) );
  AOI22XLM U130 ( .A0(n98), .A1(\memory[10][2] ), .B0(n97), .B1(
        \memory[11][2] ), .Y(n105) );
  AOI22XLM U131 ( .A0(n100), .A1(\memory[12][2] ), .B0(n99), .B1(
        \memory[13][2] ), .Y(n104) );
  AOI22XLM U132 ( .A0(n102), .A1(\memory[14][2] ), .B0(n101), .B1(
        \memory[15][2] ), .Y(n103) );
  NAND4XLM U133 ( .A(n106), .B(n105), .C(n104), .D(n103), .Y(n107) );
  CLKINVX1M U134 ( .A(n110), .Y(n152) );
  NOR2BXLM U135 ( .AN(write_enable), .B(read_enable), .Y(n125) );
  NAND2XLM U136 ( .A(n111), .B(n125), .Y(n119) );
  NOR2XLM U137 ( .A(n127), .B(n119), .Y(n112) );
  CLKINVX1M U138 ( .A(write_data[7]), .Y(n139) );
  AOI2BB2XLM U139 ( .B0(n112), .B1(n139), .A0N(register0[7]), .A1N(n112), .Y(
        n285) );
  CLKINVX1M U140 ( .A(write_data[6]), .Y(n140) );
  AOI2BB2XLM U141 ( .B0(n112), .B1(n140), .A0N(register0[6]), .A1N(n112), .Y(
        n284) );
  CLKINVX1M U142 ( .A(write_data[5]), .Y(n141) );
  AOI2BB2XLM U143 ( .B0(n112), .B1(n141), .A0N(register0[5]), .A1N(n112), .Y(
        n283) );
  CLKINVX1M U144 ( .A(write_data[4]), .Y(n142) );
  AOI2BB2XLM U145 ( .B0(n112), .B1(n142), .A0N(register0[4]), .A1N(n112), .Y(
        n282) );
  CLKINVX1M U146 ( .A(write_data[3]), .Y(n143) );
  AOI2BB2XLM U147 ( .B0(n112), .B1(n143), .A0N(register0[3]), .A1N(n112), .Y(
        n281) );
  CLKINVX1M U148 ( .A(write_data[2]), .Y(n144) );
  AOI2BB2XLM U149 ( .B0(n112), .B1(n144), .A0N(register0[2]), .A1N(n112), .Y(
        n280) );
  CLKINVX1M U150 ( .A(write_data[1]), .Y(n145) );
  AOI2BB2XLM U151 ( .B0(n112), .B1(n145), .A0N(register0[1]), .A1N(n112), .Y(
        n279) );
  CLKINVX1M U152 ( .A(write_data[0]), .Y(n146) );
  AOI2BB2XLM U153 ( .B0(n112), .B1(n146), .A0N(register0[0]), .A1N(n112), .Y(
        n278) );
  NAND2XLM U154 ( .A(n113), .B(n125), .Y(n121) );
  NOR2XLM U155 ( .A(n127), .B(n121), .Y(n114) );
  AOI2BB2XLM U156 ( .B0(n114), .B1(n139), .A0N(register1[7]), .A1N(n114), .Y(
        n277) );
  AOI2BB2XLM U157 ( .B0(n114), .B1(n140), .A0N(register1[6]), .A1N(n114), .Y(
        n276) );
  AOI2BB2XLM U158 ( .B0(n114), .B1(n141), .A0N(register1[5]), .A1N(n114), .Y(
        n275) );
  AOI2BB2XLM U159 ( .B0(n114), .B1(n142), .A0N(register1[4]), .A1N(n114), .Y(
        n274) );
  AOI2BB2XLM U160 ( .B0(n114), .B1(n143), .A0N(register1[3]), .A1N(n114), .Y(
        n273) );
  AOI2BB2XLM U161 ( .B0(n114), .B1(n144), .A0N(register1[2]), .A1N(n114), .Y(
        n272) );
  AOI2BB2XLM U162 ( .B0(n114), .B1(n145), .A0N(register1[1]), .A1N(n114), .Y(
        n271) );
  AOI2BB2XLM U163 ( .B0(n114), .B1(n146), .A0N(register1[0]), .A1N(n114), .Y(
        n270) );
  NOR2XLM U164 ( .A(n130), .B(n119), .Y(n115) );
  AOI2BB2XLM U165 ( .B0(n115), .B1(n139), .A0N(n288), .A1N(n115), .Y(n269) );
  AOI2BB2XLM U166 ( .B0(n115), .B1(n140), .A0N(n289), .A1N(n115), .Y(n268) );
  AOI2BB2XLM U167 ( .B0(n115), .B1(n141), .A0N(n290), .A1N(n115), .Y(n267) );
  AOI2BB2XLM U168 ( .B0(n115), .B1(n142), .A0N(n291), .A1N(n115), .Y(n266) );
  AOI2BB2XLM U169 ( .B0(n115), .B1(n143), .A0N(n292), .A1N(n115), .Y(n265) );
  AOI2BB2XLM U170 ( .B0(n115), .B1(n144), .A0N(n293), .A1N(n115), .Y(n264) );
  AOI2BB2XLM U171 ( .B0(n115), .B1(n145), .A0N(register2[1]), .A1N(n115), .Y(
        n263) );
  AOI2BB2XLM U172 ( .B0(n115), .B1(n146), .A0N(register2[0]), .A1N(n115), .Y(
        n262) );
  NOR2XLM U173 ( .A(n130), .B(n121), .Y(n116) );
  AOI2BB2XLM U174 ( .B0(n116), .B1(n139), .A0N(n294), .A1N(n116), .Y(n261) );
  AOI2BB2XLM U175 ( .B0(n116), .B1(n140), .A0N(n295), .A1N(n116), .Y(n260) );
  AOI2BB2XLM U176 ( .B0(n116), .B1(n141), .A0N(register3[5]), .A1N(n116), .Y(
        n259) );
  AOI2BB2XLM U177 ( .B0(n116), .B1(n142), .A0N(register3[4]), .A1N(n116), .Y(
        n258) );
  AOI2BB2XLM U178 ( .B0(n116), .B1(n143), .A0N(register3[3]), .A1N(n116), .Y(
        n257) );
  AOI2BB2XLM U179 ( .B0(n116), .B1(n144), .A0N(register3[2]), .A1N(n116), .Y(
        n256) );
  AOI2BB2XLM U180 ( .B0(n116), .B1(n145), .A0N(register3[1]), .A1N(n116), .Y(
        n255) );
  AOI2BB2XLM U181 ( .B0(n116), .B1(n146), .A0N(register3[0]), .A1N(n116), .Y(
        n254) );
  NOR2XLM U182 ( .A(n133), .B(n119), .Y(n117) );
  AOI2BB2XLM U183 ( .B0(n117), .B1(n139), .A0N(\memory[4][7] ), .A1N(n117), 
        .Y(n253) );
  AOI2BB2XLM U184 ( .B0(n117), .B1(n140), .A0N(\memory[4][6] ), .A1N(n117), 
        .Y(n252) );
  AOI2BB2XLM U185 ( .B0(n117), .B1(n141), .A0N(\memory[4][5] ), .A1N(n117), 
        .Y(n251) );
  AOI2BB2XLM U186 ( .B0(n117), .B1(n142), .A0N(\memory[4][4] ), .A1N(n117), 
        .Y(n250) );
  AOI2BB2XLM U187 ( .B0(n117), .B1(n143), .A0N(\memory[4][3] ), .A1N(n117), 
        .Y(n249) );
  AOI2BB2XLM U188 ( .B0(n117), .B1(n144), .A0N(\memory[4][2] ), .A1N(n117), 
        .Y(n248) );
  AOI2BB2XLM U189 ( .B0(n117), .B1(n145), .A0N(\memory[4][1] ), .A1N(n117), 
        .Y(n247) );
  AOI2BB2XLM U190 ( .B0(n117), .B1(n146), .A0N(\memory[4][0] ), .A1N(n117), 
        .Y(n246) );
  NOR2XLM U191 ( .A(n133), .B(n121), .Y(n118) );
  AOI2BB2XLM U192 ( .B0(n118), .B1(n139), .A0N(\memory[5][7] ), .A1N(n118), 
        .Y(n245) );
  AOI2BB2XLM U193 ( .B0(n118), .B1(n140), .A0N(\memory[5][6] ), .A1N(n118), 
        .Y(n244) );
  AOI2BB2XLM U194 ( .B0(n118), .B1(n141), .A0N(\memory[5][5] ), .A1N(n118), 
        .Y(n243) );
  AOI2BB2XLM U195 ( .B0(n118), .B1(n142), .A0N(\memory[5][4] ), .A1N(n118), 
        .Y(n242) );
  AOI2BB2XLM U196 ( .B0(n118), .B1(n143), .A0N(\memory[5][3] ), .A1N(n118), 
        .Y(n241) );
  AOI2BB2XLM U197 ( .B0(n118), .B1(n144), .A0N(\memory[5][2] ), .A1N(n118), 
        .Y(n240) );
  AOI2BB2XLM U198 ( .B0(n118), .B1(n145), .A0N(\memory[5][1] ), .A1N(n118), 
        .Y(n239) );
  AOI2BB2XLM U199 ( .B0(n118), .B1(n146), .A0N(\memory[5][0] ), .A1N(n118), 
        .Y(n238) );
  AOI2BB2XLM U200 ( .B0(n120), .B1(n139), .A0N(\memory[6][7] ), .A1N(n120), 
        .Y(n237) );
  AOI2BB2XLM U201 ( .B0(n120), .B1(n140), .A0N(\memory[6][6] ), .A1N(n120), 
        .Y(n236) );
  AOI2BB2XLM U202 ( .B0(n120), .B1(n141), .A0N(\memory[6][5] ), .A1N(n120), 
        .Y(n235) );
  AOI2BB2XLM U203 ( .B0(n120), .B1(n142), .A0N(\memory[6][4] ), .A1N(n120), 
        .Y(n234) );
  AOI2BB2XLM U204 ( .B0(n120), .B1(n143), .A0N(\memory[6][3] ), .A1N(n120), 
        .Y(n233) );
  AOI2BB2XLM U205 ( .B0(n120), .B1(n144), .A0N(\memory[6][2] ), .A1N(n120), 
        .Y(n232) );
  AOI2BB2XLM U206 ( .B0(n120), .B1(n145), .A0N(\memory[6][1] ), .A1N(n120), 
        .Y(n231) );
  AOI2BB2XLM U207 ( .B0(n120), .B1(n146), .A0N(\memory[6][0] ), .A1N(n120), 
        .Y(n230) );
  NOR2XLM U208 ( .A(n138), .B(n121), .Y(n122) );
  AOI2BB2XLM U209 ( .B0(n122), .B1(n139), .A0N(\memory[7][7] ), .A1N(n122), 
        .Y(n229) );
  AOI2BB2XLM U210 ( .B0(n122), .B1(n140), .A0N(\memory[7][6] ), .A1N(n122), 
        .Y(n228) );
  AOI2BB2XLM U211 ( .B0(n122), .B1(n141), .A0N(\memory[7][5] ), .A1N(n122), 
        .Y(n227) );
  AOI2BB2XLM U212 ( .B0(n122), .B1(n142), .A0N(\memory[7][4] ), .A1N(n122), 
        .Y(n226) );
  AOI2BB2XLM U213 ( .B0(n122), .B1(n143), .A0N(\memory[7][3] ), .A1N(n122), 
        .Y(n225) );
  AOI2BB2XLM U214 ( .B0(n122), .B1(n144), .A0N(\memory[7][2] ), .A1N(n122), 
        .Y(n224) );
  AOI2BB2XLM U215 ( .B0(n122), .B1(n145), .A0N(\memory[7][1] ), .A1N(n122), 
        .Y(n223) );
  AOI2BB2XLM U216 ( .B0(n122), .B1(n146), .A0N(\memory[7][0] ), .A1N(n122), 
        .Y(n222) );
  NAND2BXLM U217 ( .AN(n123), .B(n125), .Y(n135) );
  NOR2XLM U218 ( .A(n127), .B(n135), .Y(n124) );
  AOI2BB2XLM U219 ( .B0(n124), .B1(n139), .A0N(\memory[8][7] ), .A1N(n124), 
        .Y(n221) );
  AOI2BB2XLM U220 ( .B0(n124), .B1(n140), .A0N(\memory[8][6] ), .A1N(n124), 
        .Y(n220) );
  AOI2BB2XLM U221 ( .B0(n124), .B1(n141), .A0N(\memory[8][5] ), .A1N(n124), 
        .Y(n219) );
  AOI2BB2XLM U222 ( .B0(n124), .B1(n142), .A0N(\memory[8][4] ), .A1N(n124), 
        .Y(n218) );
  AOI2BB2XLM U223 ( .B0(n124), .B1(n143), .A0N(\memory[8][3] ), .A1N(n124), 
        .Y(n217) );
  AOI2BB2XLM U224 ( .B0(n124), .B1(n144), .A0N(\memory[8][2] ), .A1N(n124), 
        .Y(n216) );
  AOI2BB2XLM U225 ( .B0(n124), .B1(n145), .A0N(\memory[8][1] ), .A1N(n124), 
        .Y(n215) );
  AOI2BB2XLM U226 ( .B0(n124), .B1(n146), .A0N(\memory[8][0] ), .A1N(n124), 
        .Y(n214) );
  NAND2BXLM U227 ( .AN(n126), .B(n125), .Y(n137) );
  NOR2XLM U228 ( .A(n127), .B(n137), .Y(n128) );
  AOI2BB2XLM U229 ( .B0(n128), .B1(n139), .A0N(\memory[9][7] ), .A1N(n128), 
        .Y(n213) );
  AOI2BB2XLM U230 ( .B0(n128), .B1(n140), .A0N(\memory[9][6] ), .A1N(n128), 
        .Y(n212) );
  AOI2BB2XLM U231 ( .B0(n128), .B1(n141), .A0N(\memory[9][5] ), .A1N(n128), 
        .Y(n211) );
  AOI2BB2XLM U232 ( .B0(n128), .B1(n142), .A0N(\memory[9][4] ), .A1N(n128), 
        .Y(n210) );
  AOI2BB2XLM U233 ( .B0(n128), .B1(n143), .A0N(\memory[9][3] ), .A1N(n128), 
        .Y(n209) );
  AOI2BB2XLM U234 ( .B0(n128), .B1(n144), .A0N(\memory[9][2] ), .A1N(n128), 
        .Y(n208) );
  AOI2BB2XLM U235 ( .B0(n128), .B1(n145), .A0N(\memory[9][1] ), .A1N(n128), 
        .Y(n207) );
  AOI2BB2XLM U236 ( .B0(n128), .B1(n146), .A0N(\memory[9][0] ), .A1N(n128), 
        .Y(n206) );
  NOR2XLM U237 ( .A(n130), .B(n135), .Y(n129) );
  AOI2BB2XLM U238 ( .B0(n129), .B1(n139), .A0N(\memory[10][7] ), .A1N(n129), 
        .Y(n205) );
  AOI2BB2XLM U239 ( .B0(n129), .B1(n140), .A0N(\memory[10][6] ), .A1N(n129), 
        .Y(n204) );
  AOI2BB2XLM U240 ( .B0(n129), .B1(n141), .A0N(\memory[10][5] ), .A1N(n129), 
        .Y(n203) );
  AOI2BB2XLM U241 ( .B0(n129), .B1(n142), .A0N(\memory[10][4] ), .A1N(n129), 
        .Y(n202) );
  AOI2BB2XLM U242 ( .B0(n129), .B1(n143), .A0N(\memory[10][3] ), .A1N(n129), 
        .Y(n201) );
  AOI2BB2XLM U243 ( .B0(n129), .B1(n144), .A0N(\memory[10][2] ), .A1N(n129), 
        .Y(n200) );
  AOI2BB2XLM U244 ( .B0(n129), .B1(n145), .A0N(\memory[10][1] ), .A1N(n129), 
        .Y(n199) );
  AOI2BB2XLM U245 ( .B0(n129), .B1(n146), .A0N(\memory[10][0] ), .A1N(n129), 
        .Y(n198) );
  NOR2XLM U246 ( .A(n130), .B(n137), .Y(n131) );
  AOI2BB2XLM U247 ( .B0(n131), .B1(n139), .A0N(\memory[11][7] ), .A1N(n131), 
        .Y(n197) );
  AOI2BB2XLM U248 ( .B0(n131), .B1(n140), .A0N(\memory[11][6] ), .A1N(n131), 
        .Y(n196) );
  AOI2BB2XLM U249 ( .B0(n131), .B1(n141), .A0N(\memory[11][5] ), .A1N(n131), 
        .Y(n195) );
  AOI2BB2XLM U250 ( .B0(n131), .B1(n142), .A0N(\memory[11][4] ), .A1N(n131), 
        .Y(n194) );
  AOI2BB2XLM U251 ( .B0(n131), .B1(n143), .A0N(\memory[11][3] ), .A1N(n131), 
        .Y(n193) );
  AOI2BB2XLM U252 ( .B0(n131), .B1(n144), .A0N(\memory[11][2] ), .A1N(n131), 
        .Y(n192) );
  AOI2BB2XLM U253 ( .B0(n131), .B1(n145), .A0N(\memory[11][1] ), .A1N(n131), 
        .Y(n191) );
  AOI2BB2XLM U254 ( .B0(n131), .B1(n146), .A0N(\memory[11][0] ), .A1N(n131), 
        .Y(n190) );
  NOR2XLM U255 ( .A(n133), .B(n135), .Y(n132) );
  AOI2BB2XLM U256 ( .B0(n132), .B1(n139), .A0N(\memory[12][7] ), .A1N(n132), 
        .Y(n189) );
  AOI2BB2XLM U257 ( .B0(n132), .B1(n140), .A0N(\memory[12][6] ), .A1N(n132), 
        .Y(n188) );
  AOI2BB2XLM U258 ( .B0(n132), .B1(n141), .A0N(\memory[12][5] ), .A1N(n132), 
        .Y(n187) );
  AOI2BB2XLM U259 ( .B0(n132), .B1(n142), .A0N(\memory[12][4] ), .A1N(n132), 
        .Y(n186) );
  AOI2BB2XLM U260 ( .B0(n132), .B1(n143), .A0N(\memory[12][3] ), .A1N(n132), 
        .Y(n185) );
  AOI2BB2XLM U261 ( .B0(n132), .B1(n144), .A0N(\memory[12][2] ), .A1N(n132), 
        .Y(n184) );
  AOI2BB2XLM U262 ( .B0(n132), .B1(n145), .A0N(\memory[12][1] ), .A1N(n132), 
        .Y(n183) );
  AOI2BB2XLM U263 ( .B0(n132), .B1(n146), .A0N(\memory[12][0] ), .A1N(n132), 
        .Y(n182) );
  NOR2XLM U264 ( .A(n133), .B(n137), .Y(n134) );
  AOI2BB2XLM U265 ( .B0(n134), .B1(n139), .A0N(\memory[13][7] ), .A1N(n134), 
        .Y(n181) );
  AOI2BB2XLM U266 ( .B0(n134), .B1(n140), .A0N(\memory[13][6] ), .A1N(n134), 
        .Y(n180) );
  AOI2BB2XLM U267 ( .B0(n134), .B1(n141), .A0N(\memory[13][5] ), .A1N(n134), 
        .Y(n179) );
  AOI2BB2XLM U268 ( .B0(n134), .B1(n142), .A0N(\memory[13][4] ), .A1N(n134), 
        .Y(n178) );
  AOI2BB2XLM U269 ( .B0(n134), .B1(n143), .A0N(\memory[13][3] ), .A1N(n134), 
        .Y(n177) );
  AOI2BB2XLM U270 ( .B0(n134), .B1(n144), .A0N(\memory[13][2] ), .A1N(n134), 
        .Y(n176) );
  AOI2BB2XLM U271 ( .B0(n134), .B1(n145), .A0N(\memory[13][1] ), .A1N(n134), 
        .Y(n175) );
  AOI2BB2XLM U272 ( .B0(n134), .B1(n146), .A0N(\memory[13][0] ), .A1N(n134), 
        .Y(n174) );
  NOR2XLM U273 ( .A(n138), .B(n135), .Y(n136) );
  AOI2BB2XLM U274 ( .B0(n136), .B1(n139), .A0N(\memory[14][7] ), .A1N(n136), 
        .Y(n173) );
  AOI2BB2XLM U275 ( .B0(n136), .B1(n140), .A0N(\memory[14][6] ), .A1N(n136), 
        .Y(n172) );
  AOI2BB2XLM U276 ( .B0(n136), .B1(n141), .A0N(\memory[14][5] ), .A1N(n136), 
        .Y(n171) );
  AOI2BB2XLM U277 ( .B0(n136), .B1(n142), .A0N(\memory[14][4] ), .A1N(n136), 
        .Y(n170) );
  AOI2BB2XLM U278 ( .B0(n136), .B1(n143), .A0N(\memory[14][3] ), .A1N(n136), 
        .Y(n169) );
  AOI2BB2XLM U279 ( .B0(n136), .B1(n144), .A0N(\memory[14][2] ), .A1N(n136), 
        .Y(n168) );
  AOI2BB2XLM U280 ( .B0(n136), .B1(n145), .A0N(\memory[14][1] ), .A1N(n136), 
        .Y(n167) );
  AOI2BB2XLM U281 ( .B0(n136), .B1(n146), .A0N(\memory[14][0] ), .A1N(n136), 
        .Y(n166) );
  NOR2XLM U282 ( .A(n138), .B(n137), .Y(n147) );
  AOI2BB2XLM U283 ( .B0(n147), .B1(n139), .A0N(\memory[15][7] ), .A1N(n147), 
        .Y(n165) );
  AOI2BB2XLM U284 ( .B0(n147), .B1(n140), .A0N(\memory[15][6] ), .A1N(n147), 
        .Y(n164) );
  AOI2BB2XLM U285 ( .B0(n147), .B1(n141), .A0N(\memory[15][5] ), .A1N(n147), 
        .Y(n163) );
  AOI2BB2XLM U286 ( .B0(n147), .B1(n142), .A0N(\memory[15][4] ), .A1N(n147), 
        .Y(n162) );
  AOI2BB2XLM U287 ( .B0(n147), .B1(n143), .A0N(\memory[15][3] ), .A1N(n147), 
        .Y(n161) );
  AOI2BB2XLM U288 ( .B0(n147), .B1(n144), .A0N(\memory[15][2] ), .A1N(n147), 
        .Y(n160) );
  AOI2BB2XLM U289 ( .B0(n147), .B1(n145), .A0N(\memory[15][1] ), .A1N(n147), 
        .Y(n159) );
  AOI2BB2XLM U290 ( .B0(n147), .B1(n146), .A0N(\memory[15][0] ), .A1N(n147), 
        .Y(n158) );
endmodule


module register_0 ( clk, reset, D, Q );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset;


  DFFRQX1M \Q_reg[0]  ( .D(D[0]), .CK(clk), .RN(reset), .Q(Q[0]) );
endmodule


module register_7 ( clk, reset, D, Q );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset;


  DFFRQX1M \Q_reg[0]  ( .D(D[0]), .CK(clk), .RN(reset), .Q(Q[0]) );
endmodule


module bus_synchronizer_0 ( clk, reset, asynchronous_data, synchronous_data );
  input [0:0] asynchronous_data;
  output [0:0] synchronous_data;
  input clk, reset;
  wire   \output_ports[0][0] ;

  register_0 U0_register ( .clk(clk), .reset(reset), .D(asynchronous_data[0]), 
        .Q(\output_ports[0][0] ) );
  register_7 \register_instance[1].U_register  ( .clk(clk), .reset(reset), .D(
        \output_ports[0][0] ), .Q(synchronous_data[0]) );
endmodule


module register_3 ( clk, reset, D, Q );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset;


  DFFRQX1M \Q_reg[0]  ( .D(D[0]), .CK(clk), .RN(reset), .Q(Q[0]) );
endmodule


module register_4 ( clk, reset, D, Q );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset;


  DFFRQX1M \Q_reg[0]  ( .D(D[0]), .CK(clk), .RN(reset), .Q(Q[0]) );
endmodule


module bus_synchronizer_2 ( clk, reset, asynchronous_data, synchronous_data );
  input [0:0] asynchronous_data;
  output [0:0] synchronous_data;
  input clk, reset;
  wire   \output_ports[0][0] ;

  register_4 U0_register ( .clk(clk), .reset(reset), .D(asynchronous_data[0]), 
        .Q(\output_ports[0][0] ) );
  register_3 \register_instance[1].U_register  ( .clk(clk), .reset(reset), .D(
        \output_ports[0][0] ), .Q(synchronous_data[0]) );
endmodule


module data_synchronizer_0 ( clk, reset, asynchronous_data_valid, 
        asynchronous_data, Q_pulse_generator, synchronous_data_valid, 
        synchronous_data );
  input [7:0] asynchronous_data;
  output [7:0] synchronous_data;
  input clk, reset, asynchronous_data_valid;
  output Q_pulse_generator, synchronous_data_valid;
  wire   n10, synchronized_enable, pulse_generator_output, n2, n3, n4, n5, n6,
         n7, n8, n9, n1;

  bus_synchronizer_2 U_bus_synchronizer ( .clk(clk), .reset(reset), 
        .asynchronous_data(asynchronous_data_valid), .synchronous_data(
        synchronized_enable) );
  DFFRQX1M Q_pulse_generator_reg ( .D(synchronized_enable), .CK(clk), .RN(
        reset), .Q(n10) );
  DFFRQX1M synchronous_data_valid_reg ( .D(pulse_generator_output), .CK(clk), 
        .RN(reset), .Q(synchronous_data_valid) );
  DFFRQX1M \synchronous_data_reg[7]  ( .D(n9), .CK(clk), .RN(reset), .Q(
        synchronous_data[7]) );
  DFFRQX1M \synchronous_data_reg[6]  ( .D(n8), .CK(clk), .RN(reset), .Q(
        synchronous_data[6]) );
  DFFRQX1M \synchronous_data_reg[5]  ( .D(n7), .CK(clk), .RN(reset), .Q(
        synchronous_data[5]) );
  DFFRQX1M \synchronous_data_reg[4]  ( .D(n6), .CK(clk), .RN(reset), .Q(
        synchronous_data[4]) );
  DFFRQX1M \synchronous_data_reg[3]  ( .D(n5), .CK(clk), .RN(reset), .Q(
        synchronous_data[3]) );
  DFFRQX1M \synchronous_data_reg[2]  ( .D(n4), .CK(clk), .RN(reset), .Q(
        synchronous_data[2]) );
  DFFRQX1M \synchronous_data_reg[1]  ( .D(n3), .CK(clk), .RN(reset), .Q(
        synchronous_data[1]) );
  DFFRQX1M \synchronous_data_reg[0]  ( .D(n2), .CK(clk), .RN(reset), .Q(
        synchronous_data[0]) );
  NOR2BXLM U3 ( .AN(synchronized_enable), .B(n10), .Y(pulse_generator_output)
         );
  CLKINVX1M U4 ( .A(pulse_generator_output), .Y(n1) );
  AO22XLM U5 ( .A0(pulse_generator_output), .A1(asynchronous_data[7]), .B0(n1), 
        .B1(synchronous_data[7]), .Y(n9) );
  AO22XLM U6 ( .A0(pulse_generator_output), .A1(asynchronous_data[6]), .B0(n1), 
        .B1(synchronous_data[6]), .Y(n8) );
  AO22XLM U7 ( .A0(pulse_generator_output), .A1(asynchronous_data[5]), .B0(n1), 
        .B1(synchronous_data[5]), .Y(n7) );
  AO22XLM U8 ( .A0(pulse_generator_output), .A1(asynchronous_data[4]), .B0(n1), 
        .B1(synchronous_data[4]), .Y(n6) );
  AO22XLM U9 ( .A0(pulse_generator_output), .A1(asynchronous_data[3]), .B0(n1), 
        .B1(synchronous_data[3]), .Y(n5) );
  AO22XLM U10 ( .A0(pulse_generator_output), .A1(asynchronous_data[2]), .B0(n1), .B1(synchronous_data[2]), .Y(n4) );
  AO22XLM U11 ( .A0(pulse_generator_output), .A1(asynchronous_data[1]), .B0(n1), .B1(synchronous_data[1]), .Y(n3) );
  AO22XLM U12 ( .A0(pulse_generator_output), .A1(asynchronous_data[0]), .B0(n1), .B1(synchronous_data[0]), .Y(n2) );
endmodule


module UART_transmitter_FSM ( clk, reset, parity_enable, data_valid, 
        serial_enable, bit_select, serial_data_index, busy );
  output [1:0] bit_select;
  output [2:0] serial_data_index;
  input clk, reset, parity_enable, data_valid;
  output serial_enable, busy;
  wire   \serial_data_transmission_state[3] , N22, N23, N24, N25, n1, n2, n3,
         n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  DFFRQX1M \serial_data_transmission_state_reg[0]  ( .D(N22), .CK(clk), .RN(
        reset), .Q(serial_data_index[0]) );
  DFFRQX1M \serial_data_transmission_state_reg[1]  ( .D(N23), .CK(clk), .RN(
        reset), .Q(serial_data_index[1]) );
  DFFRQX1M \serial_data_transmission_state_reg[2]  ( .D(N24), .CK(clk), .RN(
        reset), .Q(serial_data_index[2]) );
  DFFRQX1M \serial_data_transmission_state_reg[3]  ( .D(N25), .CK(clk), .RN(
        reset), .Q(\serial_data_transmission_state[3] ) );
  DFFRQX1M \current_state_reg[2]  ( .D(next_state[2]), .CK(clk), .RN(reset), 
        .Q(current_state[2]) );
  DFFRQX1M \current_state_reg[0]  ( .D(next_state[0]), .CK(clk), .RN(reset), 
        .Q(current_state[0]) );
  DFFRQX1M \current_state_reg[1]  ( .D(next_state[1]), .CK(clk), .RN(reset), 
        .Q(current_state[1]) );
  CLKINVX1M U3 ( .A(serial_data_index[1]), .Y(n10) );
  CLKINVX1M U4 ( .A(current_state[2]), .Y(n1) );
  OAI21XLM U5 ( .A0(current_state[0]), .A1(current_state[1]), .B0(n1), .Y(n6)
         );
  OAI31XLM U6 ( .A0(current_state[0]), .A1(current_state[1]), .A2(n1), .B0(n6), 
        .Y(busy) );
  NAND2XLM U7 ( .A(n1), .B(current_state[1]), .Y(n7) );
  CLKINVX1M U8 ( .A(n7), .Y(bit_select[1]) );
  NAND2XLM U9 ( .A(data_valid), .B(n1), .Y(n2) );
  CLKINVX1M U10 ( .A(current_state[0]), .Y(n8) );
  NAND4XLM U11 ( .A(\serial_data_transmission_state[3] ), .B(parity_enable), 
        .C(bit_select[1]), .D(n8), .Y(n3) );
  OAI31XLM U12 ( .A0(current_state[0]), .A1(current_state[1]), .A2(n2), .B0(n3), .Y(next_state[0]) );
  AOI221XLM U13 ( .A0(\serial_data_transmission_state[3] ), .A1(
        current_state[1]), .B0(current_state[0]), .B1(current_state[1]), .C0(
        n6), .Y(serial_enable) );
  CLKINVX1M U14 ( .A(serial_enable), .Y(n11) );
  NOR2XLM U15 ( .A(serial_data_index[0]), .B(n11), .Y(N22) );
  NAND2XLM U16 ( .A(n11), .B(n3), .Y(next_state[1]) );
  NAND2XLM U17 ( .A(serial_data_index[1]), .B(serial_data_index[0]), .Y(n5) );
  CLKINVX1M U18 ( .A(serial_data_index[2]), .Y(n4) );
  CLKINVX1M U19 ( .A(serial_data_index[0]), .Y(n9) );
  NOR3XLM U20 ( .A(n10), .B(n9), .C(n4), .Y(n14) );
  AOI211XLM U21 ( .A0(n5), .A1(n4), .B0(n14), .C0(n11), .Y(N24) );
  AO21XLM U22 ( .A0(current_state[0]), .A1(current_state[1]), .B0(n6), .Y(
        bit_select[0]) );
  CLKINVX1M U23 ( .A(\serial_data_transmission_state[3] ), .Y(n13) );
  AOI221XLM U24 ( .A0(parity_enable), .A1(n8), .B0(n13), .B1(n8), .C0(n7), .Y(
        next_state[2]) );
  AOI221XLM U25 ( .A0(serial_data_index[1]), .A1(serial_data_index[0]), .B0(
        n10), .B1(n9), .C0(n11), .Y(N23) );
  CLKINVX1M U26 ( .A(n14), .Y(n12) );
  AOI221XLM U27 ( .A0(\serial_data_transmission_state[3] ), .A1(n14), .B0(n13), 
        .B1(n12), .C0(n11), .Y(N25) );
endmodule


module serializer ( clk, reset, parallel_data, serial_enable, 
        serial_data_index, serial_data );
  input [7:0] parallel_data;
  input [2:0] serial_data_index;
  input clk, reset, serial_enable;
  output serial_data;
  wire   n8, n1, n2, n3, n4, n5, n6, n7, n9, n10;

  DFFRQX1M serial_data_reg ( .D(n8), .CK(clk), .RN(reset), .Q(serial_data) );
  AOI22XLM U2 ( .A0(serial_data_index[2]), .A1(parallel_data[4]), .B0(
        parallel_data[0]), .B1(n3), .Y(n5) );
  AOI22XLM U3 ( .A0(serial_data_index[1]), .A1(n2), .B0(n1), .B1(n4), .Y(n9)
         );
  OAI2B1XLM U4 ( .A1N(serial_data), .A0(serial_enable), .B0(n10), .Y(n8) );
  CLKINVX1M U5 ( .A(serial_data_index[2]), .Y(n3) );
  AOI22XLM U6 ( .A0(serial_data_index[2]), .A1(parallel_data[7]), .B0(
        parallel_data[3]), .B1(n3), .Y(n2) );
  AOI22XLM U7 ( .A0(serial_data_index[2]), .A1(parallel_data[5]), .B0(
        parallel_data[1]), .B1(n3), .Y(n1) );
  CLKINVX1M U8 ( .A(serial_data_index[1]), .Y(n4) );
  AOI22XLM U9 ( .A0(serial_data_index[2]), .A1(parallel_data[6]), .B0(
        parallel_data[2]), .B1(n3), .Y(n6) );
  AOI221XLM U10 ( .A0(n6), .A1(serial_data_index[1]), .B0(n5), .B1(n4), .C0(
        serial_data_index[0]), .Y(n7) );
  AOI32XLM U11 ( .A0(serial_data_index[0]), .A1(serial_enable), .A2(n9), .B0(
        n7), .B1(serial_enable), .Y(n10) );
endmodule


module parity_calculator ( clk, reset, parity_type, parity_enable, data_valid, 
        parallel_data, parity_bit );
  input [7:0] parallel_data;
  input clk, reset, parity_type, parity_enable, data_valid;
  output parity_bit;
  wire   n8, n1, n2, n3, n4, n5, n6, n7;

  DFFRQX1M parity_bit_reg ( .D(n8), .CK(clk), .RN(reset), .Q(parity_bit) );
  NAND2XLM U2 ( .A(data_valid), .B(parity_enable), .Y(n7) );
  XOR3XLM U3 ( .A(parity_type), .B(parallel_data[4]), .C(parallel_data[2]), 
        .Y(n5) );
  XOR2XLM U4 ( .A(parallel_data[0]), .B(parallel_data[5]), .Y(n1) );
  XOR3XLM U5 ( .A(parallel_data[1]), .B(parallel_data[6]), .C(n1), .Y(n2) );
  XOR3XLM U6 ( .A(parallel_data[7]), .B(parallel_data[3]), .C(n2), .Y(n4) );
  NOR2XLM U7 ( .A(n5), .B(n4), .Y(n3) );
  AOI211XLM U8 ( .A0(n5), .A1(n4), .B0(n7), .C0(n3), .Y(n6) );
  AO21XLM U9 ( .A0(n7), .A1(parity_bit), .B0(n6), .Y(n8) );
endmodule


module output_multiplexer ( bit_select, serial_data, parity_bit, mux_out );
  input [1:0] bit_select;
  input serial_data, parity_bit;
  output mux_out;
  wire   n5, n1, n3, n4;

  CLKINVX1M U3 ( .A(n5), .Y(n1) );
  INVX8M U4 ( .A(n1), .Y(mux_out) );
  AOI31XLM U5 ( .A0(n4), .A1(bit_select[0]), .A2(bit_select[1]), .B0(n3), .Y(
        n5) );
  CLKINVX1M U6 ( .A(parity_bit), .Y(n4) );
  AOI21XLM U7 ( .A0(bit_select[1]), .A1(serial_data), .B0(bit_select[0]), .Y(
        n3) );
endmodule


module UART_transmitter ( clk, reset, parity_type, parity_enable, data_valid, 
        parallel_data, TX_out, busy );
  input [7:0] parallel_data;
  input clk, reset, parity_type, parity_enable, data_valid;
  output TX_out, busy;
  wire   serial_enable, serial_data, parity_bit;
  wire   [1:0] bit_select;
  wire   [2:0] serial_data_index;

  UART_transmitter_FSM U_UART_transmitter_FSM ( .clk(clk), .reset(reset), 
        .parity_enable(parity_enable), .data_valid(data_valid), 
        .serial_enable(serial_enable), .bit_select(bit_select), 
        .serial_data_index(serial_data_index), .busy(busy) );
  serializer U_serializer ( .clk(clk), .reset(reset), .parallel_data(
        parallel_data), .serial_enable(serial_enable), .serial_data_index(
        serial_data_index), .serial_data(serial_data) );
  parity_calculator U_parity_calculator ( .clk(clk), .reset(reset), 
        .parity_type(parity_type), .parity_enable(parity_enable), .data_valid(
        data_valid), .parallel_data(parallel_data), .parity_bit(parity_bit) );
  output_multiplexer U_output_multiplexer ( .bit_select(bit_select), 
        .serial_data(serial_data), .parity_bit(parity_bit), .mux_out(TX_out)
         );
endmodule


module UART_receiver_FSM ( clk, reset, parity_enable, prescale, serial_data, 
        start_bit_error, parity_bit_error, stop_bit_error, edge_count, 
        edge_count_done, start_bit_check_enable, parity_bit_check_enable, 
        stop_bit_check_enable, edge_counter_and_data_sampler_enable, 
        deserializer_enable, data_index, data_valid );
  input [5:0] prescale;
  input [4:0] edge_count;
  output [2:0] data_index;
  input clk, reset, parity_enable, serial_data, start_bit_error,
         parity_bit_error, stop_bit_error, edge_count_done;
  output start_bit_check_enable, parity_bit_check_enable,
         stop_bit_check_enable, edge_counter_and_data_sampler_enable,
         deserializer_enable, data_valid;
  wire   \data_transmission_state[3] , n31, n32, n33, n34, n1, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56;
  wire   [2:0] current_state;
  wire   [2:0] next_state;

  DFFRQX1M \current_state_reg[0]  ( .D(next_state[0]), .CK(clk), .RN(reset), 
        .Q(current_state[0]) );
  DFFRQX1M \current_state_reg[2]  ( .D(next_state[2]), .CK(clk), .RN(reset), 
        .Q(current_state[2]) );
  DFFRQX1M \current_state_reg[1]  ( .D(next_state[1]), .CK(clk), .RN(reset), 
        .Q(current_state[1]) );
  DFFRQX1M \data_transmission_state_reg[2]  ( .D(n31), .CK(clk), .RN(reset), 
        .Q(data_index[2]) );
  DFFRQX1M \data_transmission_state_reg[3]  ( .D(n34), .CK(clk), .RN(reset), 
        .Q(\data_transmission_state[3] ) );
  DFFRQX1M \data_transmission_state_reg[0]  ( .D(n33), .CK(clk), .RN(reset), 
        .Q(data_index[0]) );
  DFFRQX1M \data_transmission_state_reg[1]  ( .D(n32), .CK(clk), .RN(reset), 
        .Q(data_index[1]) );
  AOI32XLM U3 ( .A0(n14), .A1(n13), .A2(n12), .B0(prescale[5]), .B1(n11), .Y(
        n20) );
  NOR2BXLM U4 ( .AN(n38), .B(n46), .Y(deserializer_enable) );
  NOR3XLM U5 ( .A(n43), .B(n55), .C(n46), .Y(parity_bit_check_enable) );
  OAI22XLM U6 ( .A0(edge_count_done), .A1(n53), .B0(serial_data), .B1(n35), 
        .Y(n36) );
  NAND3XLM U7 ( .A(prescale[3]), .B(prescale[2]), .C(prescale[4]), .Y(n10) );
  CLKINVX1M U8 ( .A(edge_count[4]), .Y(n15) );
  NOR2XLM U9 ( .A(n15), .B(prescale[5]), .Y(n9) );
  AOI32XLM U10 ( .A0(prescale[2]), .A1(n10), .A2(prescale[3]), .B0(prescale[4]), .B1(n10), .Y(n6) );
  CLKINVX1M U11 ( .A(prescale[2]), .Y(n1) );
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
  OAI21XLM U19 ( .A0(n10), .A1(n9), .B0(n8), .Y(n46) );
  CLKINVX1M U20 ( .A(current_state[0]), .Y(n43) );
  CLKINVX1M U21 ( .A(current_state[1]), .Y(n29) );
  NAND3XLM U22 ( .A(current_state[2]), .B(n43), .C(n29), .Y(n45) );
  NOR2XLM U23 ( .A(n46), .B(n45), .Y(stop_bit_check_enable) );
  NOR2XLM U24 ( .A(n29), .B(current_state[2]), .Y(n42) );
  CLKINVX1M U25 ( .A(n42), .Y(n55) );
  CLKINVX1M U26 ( .A(\data_transmission_state[3] ), .Y(n49) );
  NOR3XLM U27 ( .A(prescale[3]), .B(prescale[2]), .C(prescale[1]), .Y(n14) );
  AOI221XLM U28 ( .A0(prescale[2]), .A1(prescale[3]), .B0(prescale[1]), .B1(
        prescale[3]), .C0(n14), .Y(n26) );
  NOR2XLM U29 ( .A(current_state[0]), .B(n55), .Y(n38) );
  AOI32XLM U30 ( .A0(prescale[1]), .A1(n38), .A2(n18), .B0(edge_count[1]), 
        .B1(n38), .Y(n25) );
  CLKINVX1M U31 ( .A(edge_count[0]), .Y(n22) );
  CLKINVX1M U32 ( .A(prescale[5]), .Y(n13) );
  NAND2XLM U33 ( .A(prescale[4]), .B(n15), .Y(n12) );
  CLKINVX1M U34 ( .A(prescale[4]), .Y(n16) );
  NAND2XLM U35 ( .A(edge_count[4]), .B(n16), .Y(n11) );
  AOI221XLM U36 ( .A0(prescale[4]), .A1(edge_count[4]), .B0(n16), .B1(n15), 
        .C0(n14), .Y(n17) );
  AOI221XLM U37 ( .A0(prescale[1]), .A1(edge_count[1]), .B0(n18), .B1(
        edge_count[1]), .C0(n17), .Y(n19) );
  OAI211XLM U38 ( .A0(n22), .A1(prescale[0]), .B0(n20), .C0(n19), .Y(n21) );
  AOI21XLM U39 ( .A0(n22), .A1(prescale[0]), .B0(n21), .Y(n23) );
  OAI21XLM U40 ( .A0(n26), .A1(edge_count[3]), .B0(n23), .Y(n24) );
  AOI211XLM U41 ( .A0(n26), .A1(edge_count[3]), .B0(n25), .C0(n24), .Y(n50) );
  NAND2XLM U42 ( .A(n50), .B(data_index[0]), .Y(n48) );
  OAI221XLM U43 ( .A0(n49), .A1(n50), .B0(data_index[0]), .B1(n50), .C0(n48), 
        .Y(n27) );
  CLKINVX1M U44 ( .A(n27), .Y(n33) );
  CLKINVX1M U45 ( .A(current_state[2]), .Y(n30) );
  NOR3XLM U46 ( .A(current_state[1]), .B(n30), .C(n43), .Y(data_valid) );
  NAND3XLM U47 ( .A(\data_transmission_state[3] ), .B(n38), .C(parity_enable), 
        .Y(n28) );
  OAI21XLM U48 ( .A0(stop_bit_error), .A1(n45), .B0(n28), .Y(n37) );
  NAND2XLM U49 ( .A(current_state[0]), .B(n30), .Y(n53) );
  AOI31XLM U50 ( .A0(n43), .A1(n30), .A2(n29), .B0(data_valid), .Y(n35) );
  AO21XLM U51 ( .A0(edge_count_done), .A1(n37), .B0(n36), .Y(next_state[0]) );
  NAND2BXLM U52 ( .AN(n48), .B(data_index[1]), .Y(n52) );
  CLKINVX1M U53 ( .A(data_index[2]), .Y(n40) );
  OAI211XLM U54 ( .A0(n52), .A1(n40), .B0(\data_transmission_state[3] ), .C0(
        n50), .Y(n39) );
  OAI31XLM U55 ( .A0(n52), .A1(n40), .A2(\data_transmission_state[3] ), .B0(
        n39), .Y(n34) );
  CLKINVX1M U56 ( .A(edge_count_done), .Y(n41) );
  AOI221XLM U57 ( .A0(parity_enable), .A1(n43), .B0(n49), .B1(n43), .C0(n41), 
        .Y(n56) );
  OAI2B11XLM U58 ( .A1N(parity_bit_error), .A0(n43), .B0(n42), .C0(n56), .Y(
        n44) );
  AOI32XLM U59 ( .A0(edge_count_done), .A1(n44), .A2(stop_bit_error), .B0(n45), 
        .B1(n44), .Y(next_state[2]) );
  NAND3XLM U60 ( .A(n55), .B(n53), .C(n45), .Y(
        edge_counter_and_data_sampler_enable) );
  NOR3XLM U61 ( .A(current_state[1]), .B(n46), .C(n53), .Y(
        start_bit_check_enable) );
  OAI211XLM U62 ( .A0(n49), .A1(n50), .B0(n48), .C0(data_index[1]), .Y(n47) );
  OAI21XLM U63 ( .A0(n48), .A1(data_index[1]), .B0(n47), .Y(n32) );
  OAI211XLM U64 ( .A0(n50), .A1(n49), .B0(data_index[2]), .C0(n52), .Y(n51) );
  OAI21XLM U65 ( .A0(data_index[2]), .A1(n52), .B0(n51), .Y(n31) );
  NOR3XLM U66 ( .A(current_state[1]), .B(start_bit_error), .C(n53), .Y(n54) );
  OAI2BB2XLM U67 ( .B0(n56), .B1(n55), .A0N(edge_count_done), .A1N(n54), .Y(
        next_state[1]) );
endmodule


module data_sampler ( clk, reset, serial_data, prescale, enable, edge_count, 
        sampled_bit );
  input [4:0] prescale;
  input [4:0] edge_count;
  input clk, reset, serial_data, enable;
  output sampled_bit;
  wire   sample_enable, n12, n13, n14, n15, n1, n2, n3, n4, n5, n6, n7, n8, n9,
         n10, n11, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n46;
  wire   [2:0] samples;

  DFFRQX1M sample_enable_reg ( .D(n12), .CK(clk), .RN(reset), .Q(sample_enable) );
  DFFRQX1M \samples_reg[2]  ( .D(n15), .CK(clk), .RN(reset), .Q(samples[2]) );
  DFFRQX1M \samples_reg[1]  ( .D(n14), .CK(clk), .RN(reset), .Q(samples[1]) );
  DFFRQX1M \samples_reg[0]  ( .D(n13), .CK(clk), .RN(reset), .Q(samples[0]) );
  OAI21XLM U3 ( .A0(n33), .A1(n32), .B0(n31), .Y(n43) );
  NOR2BXLM U4 ( .AN(sample_enable), .B(n27), .Y(sampled_bit) );
  CLKINVX1M U5 ( .A(enable), .Y(n46) );
  NOR3XLM U6 ( .A(prescale[3]), .B(prescale[2]), .C(prescale[1]), .Y(n4) );
  XOR2XLM U7 ( .A(prescale[4]), .B(edge_count[4]), .Y(n16) );
  NOR2XLM U8 ( .A(n4), .B(n16), .Y(n10) );
  NOR2XLM U9 ( .A(prescale[2]), .B(prescale[1]), .Y(n1) );
  AOI2B1XLM U10 ( .A1N(n1), .A0(prescale[3]), .B0(n4), .Y(n35) );
  CLKINVX1M U11 ( .A(n35), .Y(n9) );
  CLKINVX1M U12 ( .A(prescale[0]), .Y(n28) );
  NOR2XLM U13 ( .A(prescale[1]), .B(n28), .Y(n3) );
  AOI21XLM U14 ( .A0(prescale[1]), .A1(prescale[2]), .B0(n1), .Y(n36) );
  XOR2XLM U15 ( .A(edge_count[2]), .B(n36), .Y(n33) );
  MXI2XLM U16 ( .A(n28), .B(prescale[0]), .S0(edge_count[0]), .Y(n25) );
  NAND2XLM U17 ( .A(n25), .B(enable), .Y(n30) );
  CLKINVX1M U18 ( .A(prescale[1]), .Y(n37) );
  MXI2XLM U19 ( .A(n37), .B(prescale[1]), .S0(edge_count[1]), .Y(n23) );
  MXI2XLM U20 ( .A(n28), .B(prescale[0]), .S0(n23), .Y(n29) );
  OAI21XLM U21 ( .A0(n3), .A1(n33), .B0(n29), .Y(n2) );
  AOI211XLM U22 ( .A0(n3), .A1(n33), .B0(n30), .C0(n2), .Y(n8) );
  AOI21XLM U23 ( .A0(n16), .A1(n4), .B0(n10), .Y(n44) );
  NOR3XLM U24 ( .A(prescale[2]), .B(prescale[1]), .C(n28), .Y(n6) );
  NOR2XLM U25 ( .A(edge_count[3]), .B(n9), .Y(n34) );
  AOI21XLM U26 ( .A0(edge_count[3]), .A1(n9), .B0(n34), .Y(n38) );
  OAI211XLM U27 ( .A0(n44), .A1(n35), .B0(n6), .C0(n38), .Y(n5) );
  OAI31XLM U28 ( .A0(n44), .A1(n6), .A2(n38), .B0(n5), .Y(n7) );
  OAI211XLM U29 ( .A0(n10), .A1(n9), .B0(n8), .C0(n7), .Y(n11) );
  MX2XLM U30 ( .A(serial_data), .B(samples[1]), .S0(n11), .Y(n14) );
  NOR4XLM U31 ( .A(n16), .B(n23), .C(n25), .D(n46), .Y(n21) );
  CLKINVX1M U32 ( .A(edge_count[3]), .Y(n19) );
  CLKINVX1M U33 ( .A(prescale[2]), .Y(n18) );
  OAI22XLM U34 ( .A0(prescale[3]), .A1(n19), .B0(n18), .B1(edge_count[2]), .Y(
        n17) );
  AOI221XLM U35 ( .A0(n19), .A1(prescale[3]), .B0(n18), .B1(edge_count[2]), 
        .C0(n17), .Y(n20) );
  NAND2XLM U36 ( .A(n21), .B(n20), .Y(n22) );
  MX2XLM U37 ( .A(serial_data), .B(samples[2]), .S0(n22), .Y(n15) );
  NAND3XLM U38 ( .A(n23), .B(enable), .C(n33), .Y(n24) );
  NOR4XLM U39 ( .A(n44), .B(n38), .C(n25), .D(n24), .Y(n26) );
  MX2XLM U40 ( .A(samples[0]), .B(serial_data), .S0(n26), .Y(n13) );
  AOI222XLM U41 ( .A0(samples[1]), .A1(samples[0]), .B0(samples[1]), .B1(
        samples[2]), .C0(samples[0]), .C1(samples[2]), .Y(n27) );
  NAND2XLM U42 ( .A(prescale[1]), .B(n28), .Y(n32) );
  AOI211XLM U43 ( .A0(n33), .A1(n32), .B0(n30), .C0(n29), .Y(n31) );
  AOI2BB1XLM U44 ( .A0N(n44), .A1N(n35), .B0(n34), .Y(n41) );
  OAI21BXLM U45 ( .A0(n37), .A1(prescale[0]), .B0N(n36), .Y(n40) );
  OAI21XLM U46 ( .A0(n44), .A1(n38), .B0(n40), .Y(n39) );
  OAI21XLM U47 ( .A0(n41), .A1(n40), .B0(n39), .Y(n42) );
  AOI211XLM U48 ( .A0(n44), .A1(edge_count[3]), .B0(n43), .C0(n42), .Y(n45) );
  AO21XLM U49 ( .A0(sample_enable), .A1(n46), .B0(n45), .Y(n12) );
endmodule


module deserializer ( clk, reset, enable, data_index, sampled_bit, 
        parallel_data );
  input [2:0] data_index;
  output [7:0] parallel_data;
  input clk, reset, enable, sampled_bit;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n1, n2, n3, n4, n5, n6, n7,
         n8, n9, n10, n11, n12, n13, n14, n15, n16, n25, n26;

  DFFRQX1M \parallel_data_reg[7]  ( .D(n24), .CK(clk), .RN(reset), .Q(
        parallel_data[7]) );
  DFFRQX1M \parallel_data_reg[6]  ( .D(n23), .CK(clk), .RN(reset), .Q(
        parallel_data[6]) );
  DFFRQX1M \parallel_data_reg[5]  ( .D(n22), .CK(clk), .RN(reset), .Q(
        parallel_data[5]) );
  DFFRQX1M \parallel_data_reg[4]  ( .D(n21), .CK(clk), .RN(reset), .Q(
        parallel_data[4]) );
  DFFRQX1M \parallel_data_reg[3]  ( .D(n20), .CK(clk), .RN(reset), .Q(
        parallel_data[3]) );
  DFFRQX1M \parallel_data_reg[2]  ( .D(n19), .CK(clk), .RN(reset), .Q(
        parallel_data[2]) );
  DFFRQX1M \parallel_data_reg[1]  ( .D(n18), .CK(clk), .RN(reset), .Q(
        parallel_data[1]) );
  DFFRQX1M \parallel_data_reg[0]  ( .D(n17), .CK(clk), .RN(reset), .Q(
        parallel_data[0]) );
  NAND2BXLM U2 ( .AN(data_index[0]), .B(enable), .Y(n15) );
  NAND2XLM U3 ( .A(n5), .B(n4), .Y(n14) );
  OAI21XLM U4 ( .A0(n8), .A1(n10), .B0(n1), .Y(n22) );
  NAND2XLM U5 ( .A(data_index[0]), .B(enable), .Y(n6) );
  NAND2BXLM U6 ( .AN(n6), .B(sampled_bit), .Y(n8) );
  CLKINVX1M U7 ( .A(data_index[1]), .Y(n5) );
  NAND2XLM U8 ( .A(data_index[2]), .B(n5), .Y(n10) );
  OAI21XLM U9 ( .A0(n6), .A1(n10), .B0(parallel_data[5]), .Y(n1) );
  CLKINVX1M U10 ( .A(data_index[2]), .Y(n4) );
  NAND2XLM U11 ( .A(data_index[1]), .B(n4), .Y(n12) );
  OAI21XLM U12 ( .A0(n6), .A1(n12), .B0(parallel_data[3]), .Y(n2) );
  OAI21XLM U13 ( .A0(n8), .A1(n12), .B0(n2), .Y(n20) );
  NAND2XLM U14 ( .A(data_index[1]), .B(data_index[2]), .Y(n25) );
  OAI21XLM U15 ( .A0(n6), .A1(n25), .B0(parallel_data[7]), .Y(n3) );
  OAI21XLM U16 ( .A0(n8), .A1(n25), .B0(n3), .Y(n24) );
  OAI21XLM U17 ( .A0(n6), .A1(n14), .B0(parallel_data[1]), .Y(n7) );
  OAI21XLM U18 ( .A0(n8), .A1(n14), .B0(n7), .Y(n18) );
  NAND2BXLM U19 ( .AN(n15), .B(sampled_bit), .Y(n26) );
  OAI21XLM U20 ( .A0(n15), .A1(n10), .B0(parallel_data[4]), .Y(n9) );
  OAI21XLM U21 ( .A0(n26), .A1(n10), .B0(n9), .Y(n21) );
  OAI21XLM U22 ( .A0(n15), .A1(n12), .B0(parallel_data[2]), .Y(n11) );
  OAI21XLM U23 ( .A0(n26), .A1(n12), .B0(n11), .Y(n19) );
  OAI21XLM U24 ( .A0(n15), .A1(n14), .B0(parallel_data[0]), .Y(n13) );
  OAI21XLM U25 ( .A0(n26), .A1(n14), .B0(n13), .Y(n17) );
  OAI21XLM U26 ( .A0(n15), .A1(n25), .B0(parallel_data[6]), .Y(n16) );
  OAI21XLM U27 ( .A0(n26), .A1(n25), .B0(n16), .Y(n23) );
endmodule


module edge_counter ( clk, reset, prescale, enable, edge_count, 
        edge_count_done );
  input [5:0] prescale;
  output [4:0] edge_count;
  input clk, reset, enable;
  output edge_count_done;
  wire   N14, N15, N16, N17, N18, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11,
         n12, n13, n14, n15;

  DFFRQX1M \edge_count_reg[4]  ( .D(N18), .CK(clk), .RN(reset), .Q(
        edge_count[4]) );
  DFFRQX1M \edge_count_reg[3]  ( .D(N17), .CK(clk), .RN(reset), .Q(
        edge_count[3]) );
  DFFRQX1M \edge_count_reg[2]  ( .D(N16), .CK(clk), .RN(reset), .Q(
        edge_count[2]) );
  DFFRQX1M \edge_count_reg[1]  ( .D(N15), .CK(clk), .RN(reset), .Q(
        edge_count[1]) );
  DFFRQX1M \edge_count_reg[0]  ( .D(N14), .CK(clk), .RN(reset), .Q(
        edge_count[0]) );
  AOI21XLM U3 ( .A0(prescale[5]), .A1(edge_count[4]), .B0(prescale[4]), .Y(n1)
         );
  CLKINVX1M U4 ( .A(edge_count[3]), .Y(n10) );
  AOI211XLM U5 ( .A0(prescale[4]), .A1(prescale[5]), .B0(n1), .C0(n10), .Y(n3)
         );
  CLKINVX1M U6 ( .A(edge_count[0]), .Y(n8) );
  CLKINVX1M U7 ( .A(edge_count[1]), .Y(n7) );
  CLKINVX1M U8 ( .A(edge_count[2]), .Y(n5) );
  NOR3XLM U9 ( .A(n8), .B(n7), .C(n5), .Y(n11) );
  OAI21XLM U10 ( .A0(prescale[5]), .A1(prescale[4]), .B0(prescale[3]), .Y(n2)
         );
  OAI211XLM U11 ( .A0(prescale[3]), .A1(n3), .B0(n11), .C0(n2), .Y(n4) );
  NOR4XLM U12 ( .A(prescale[2]), .B(prescale[1]), .C(prescale[0]), .D(n4), .Y(
        edge_count_done) );
  NAND2BXLM U13 ( .AN(edge_count_done), .B(enable), .Y(n12) );
  NOR2XLM U14 ( .A(edge_count[0]), .B(n12), .Y(N14) );
  NAND2XLM U15 ( .A(edge_count[0]), .B(edge_count[1]), .Y(n6) );
  AOI211XLM U16 ( .A0(n6), .A1(n5), .B0(n11), .C0(n12), .Y(N16) );
  AOI221XLM U17 ( .A0(edge_count[0]), .A1(edge_count[1]), .B0(n8), .B1(n7), 
        .C0(n12), .Y(N15) );
  CLKINVX1M U18 ( .A(n11), .Y(n9) );
  AOI221XLM U19 ( .A0(edge_count[3]), .A1(n11), .B0(n10), .B1(n9), .C0(n12), 
        .Y(N17) );
  NAND2XLM U20 ( .A(edge_count[3]), .B(n11), .Y(n13) );
  CLKINVX1M U21 ( .A(n13), .Y(n15) );
  CLKINVX1M U22 ( .A(edge_count[4]), .Y(n14) );
  AOI221XLM U23 ( .A0(edge_count[4]), .A1(n15), .B0(n14), .B1(n13), .C0(n12), 
        .Y(N18) );
endmodule


module start_bit_checker ( clk, reset, enable, sampled_bit, start_bit_error );
  input clk, reset, enable, sampled_bit;
  output start_bit_error;
  wire   N4;

  DFFRQX1M start_bit_error_reg ( .D(N4), .CK(clk), .RN(reset), .Q(
        start_bit_error) );
  AND2X1M U3 ( .A(sampled_bit), .B(enable), .Y(N4) );
endmodule


module parity_bit_checker ( clk, reset, parity_type, enable, sampled_bit, 
        parallel_data, parity_bit_error );
  input [7:0] parallel_data;
  input clk, reset, parity_type, enable, sampled_bit;
  output parity_bit_error;
  wire   N10, n1, n2, n3, n4, n5, n6;

  DFFRHQX8M parity_bit_error_reg ( .D(N10), .CK(clk), .RN(reset), .Q(
        parity_bit_error) );
  XOR2XLM U3 ( .A(parallel_data[3]), .B(parallel_data[1]), .Y(n1) );
  XOR3XLM U4 ( .A(parity_type), .B(parallel_data[0]), .C(n1), .Y(n6) );
  XOR2XLM U5 ( .A(parallel_data[4]), .B(parallel_data[2]), .Y(n2) );
  XOR3XLM U6 ( .A(parallel_data[7]), .B(parallel_data[6]), .C(n2), .Y(n3) );
  XOR3XLM U7 ( .A(parallel_data[5]), .B(sampled_bit), .C(n3), .Y(n5) );
  OAI21XLM U8 ( .A0(n6), .A1(n5), .B0(enable), .Y(n4) );
  AOI21XLM U9 ( .A0(n6), .A1(n5), .B0(n4), .Y(N10) );
endmodule


module stop_bit_checker ( clk, reset, enable, sampled_bit, stop_bit_error );
  input clk, reset, enable, sampled_bit;
  output stop_bit_error;
  wire   N5;

  DFFRQX1M stop_bit_error_reg ( .D(N5), .CK(clk), .RN(reset), .Q(
        stop_bit_error) );
  NOR2BXLM U3 ( .AN(enable), .B(sampled_bit), .Y(N5) );
endmodule


module UART_receiver ( clk, reset, parity_type, parity_enable, prescale, 
        serial_data, data_valid, parallel_data, parity_error, frame_error );
  input [5:0] prescale;
  output [7:0] parallel_data;
  input clk, reset, parity_type, parity_enable, serial_data;
  output data_valid, parity_error, frame_error;
  wire   start_bit_error, stop_bit_error, edge_count_done,
         start_bit_check_enable, parity_bit_check_enable,
         stop_bit_check_enable, edge_counter_and_data_sampler_enable,
         deserializer_enable, sampled_bit, n1;
  wire   [4:0] edge_count;
  wire   [2:0] data_index;

  UART_receiver_FSM U_UART_receiver_FSM ( .clk(clk), .reset(n1), 
        .parity_enable(parity_enable), .prescale(prescale), .serial_data(
        serial_data), .start_bit_error(start_bit_error), .parity_bit_error(
        parity_error), .stop_bit_error(stop_bit_error), .edge_count(edge_count), .edge_count_done(edge_count_done), .start_bit_check_enable(
        start_bit_check_enable), .parity_bit_check_enable(
        parity_bit_check_enable), .stop_bit_check_enable(stop_bit_check_enable), .edge_counter_and_data_sampler_enable(edge_counter_and_data_sampler_enable), 
        .deserializer_enable(deserializer_enable), .data_index(data_index), 
        .data_valid(data_valid) );
  data_sampler U_data_sampler ( .clk(clk), .reset(n1), .serial_data(
        serial_data), .prescale(prescale[5:1]), .enable(
        edge_counter_and_data_sampler_enable), .edge_count(edge_count), 
        .sampled_bit(sampled_bit) );
  deserializer U_deserializer ( .clk(clk), .reset(n1), .enable(
        deserializer_enable), .data_index(data_index), .sampled_bit(
        sampled_bit), .parallel_data(parallel_data) );
  edge_counter U_edge_counter ( .clk(clk), .reset(n1), .prescale(prescale), 
        .enable(edge_counter_and_data_sampler_enable), .edge_count(edge_count), 
        .edge_count_done(edge_count_done) );
  start_bit_checker U_start_bit_checker ( .clk(clk), .reset(n1), .enable(
        start_bit_check_enable), .sampled_bit(sampled_bit), .start_bit_error(
        start_bit_error) );
  parity_bit_checker U_parity_bit_checker ( .clk(clk), .reset(n1), 
        .parity_type(parity_type), .enable(parity_bit_check_enable), 
        .sampled_bit(sampled_bit), .parallel_data(parallel_data), 
        .parity_bit_error(parity_error) );
  stop_bit_checker U_stop_bit_checker ( .clk(clk), .reset(n1), .enable(
        stop_bit_check_enable), .sampled_bit(sampled_bit), .stop_bit_error(
        stop_bit_error) );
  BUFX2M U1 ( .A(reset), .Y(n1) );
  OR2X8M U2 ( .A(start_bit_error), .B(stop_bit_error), .Y(frame_error) );
endmodule


module UART ( transmitter_clk, receiver_clk, reset, parity_type, parity_enable, 
        prescale, transmitter_parallel_data_valid, transmitter_parallel_data, 
        serial_data_receiver, serial_data_transmitter, transmitter_busy, 
        receiver_parallel_data_valid, receiver_parallel_data, 
        parity_error_receiver, frame_error_receiver );
  input [5:0] prescale;
  input [7:0] transmitter_parallel_data;
  output [7:0] receiver_parallel_data;
  input transmitter_clk, receiver_clk, reset, parity_type, parity_enable,
         transmitter_parallel_data_valid, serial_data_receiver;
  output serial_data_transmitter, transmitter_busy,
         receiver_parallel_data_valid, parity_error_receiver,
         frame_error_receiver;


  UART_transmitter U_UART_transmitter ( .clk(transmitter_clk), .reset(reset), 
        .parity_type(parity_type), .parity_enable(parity_enable), .data_valid(
        transmitter_parallel_data_valid), .parallel_data(
        transmitter_parallel_data), .TX_out(serial_data_transmitter), .busy(
        transmitter_busy) );
  UART_receiver U_UART_receiver ( .clk(receiver_clk), .reset(reset), 
        .parity_type(parity_type), .parity_enable(parity_enable), .prescale(
        prescale), .serial_data(serial_data_receiver), .data_valid(
        receiver_parallel_data_valid), .parallel_data(receiver_parallel_data), 
        .parity_error(parity_error_receiver), .frame_error(
        frame_error_receiver) );
endmodule


module clock_divider ( reference_clk, reset, clk_divider_enable, 
        division_ratio, output_clk );
  input [5:0] division_ratio;
  input reference_clk, reset, clk_divider_enable;
  output output_clk;
  wire   divided_clk, odd_toggle, n16, n17, n18, n19, n20, n21, n22, n1, n2,
         n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38;
  wire   [4:0] counter;

  DFFSQX2M odd_toggle_reg ( .D(n22), .CK(reference_clk), .SN(reset), .Q(
        odd_toggle) );
  DFFRQX1M \counter_reg[0]  ( .D(n21), .CK(reference_clk), .RN(reset), .Q(
        counter[0]) );
  DFFRQX1M \counter_reg[1]  ( .D(n20), .CK(reference_clk), .RN(reset), .Q(
        counter[1]) );
  DFFRQX1M \counter_reg[2]  ( .D(n19), .CK(reference_clk), .RN(reset), .Q(
        counter[2]) );
  DFFRQX1M \counter_reg[3]  ( .D(n18), .CK(reference_clk), .RN(reset), .Q(
        counter[3]) );
  DFFRQX1M \counter_reg[4]  ( .D(n17), .CK(reference_clk), .RN(reset), .Q(
        counter[4]) );
  DFFRQX1M divided_clk_reg ( .D(n16), .CK(reference_clk), .RN(reset), .Q(
        divided_clk) );
  MX2XLM U25 ( .A(reference_clk), .B(divided_clk), .S0(1'b1), .Y(output_clk)
         );
  CLKINVX1M U3 ( .A(n10), .Y(n11) );
  CLKINVX1M U4 ( .A(n33), .Y(n32) );
  AOI211XLM U5 ( .A0(n25), .A1(n24), .B0(n32), .C0(n38), .Y(n19) );
  CLKINVX1M U6 ( .A(counter[2]), .Y(n25) );
  NAND2XLM U7 ( .A(counter[0]), .B(counter[1]), .Y(n24) );
  NAND3XLM U8 ( .A(counter[0]), .B(counter[1]), .C(counter[2]), .Y(n33) );
  NOR3XLM U9 ( .A(division_ratio[3]), .B(division_ratio[1]), .C(
        division_ratio[2]), .Y(n9) );
  CLKINVX1M U10 ( .A(counter[3]), .Y(n34) );
  NOR2XLM U11 ( .A(division_ratio[4]), .B(n34), .Y(n2) );
  AOI21XLM U12 ( .A0(division_ratio[4]), .A1(n34), .B0(n2), .Y(n15) );
  NAND2XLM U13 ( .A(division_ratio[4]), .B(n34), .Y(n1) );
  CLKINVX1M U14 ( .A(counter[4]), .Y(n36) );
  XOR2XLM U15 ( .A(n36), .B(division_ratio[5]), .Y(n10) );
  CLKINVX1M U16 ( .A(counter[0]), .Y(n31) );
  AOI2BB2XLM U17 ( .B0(division_ratio[2]), .B1(counter[1]), .A0N(counter[1]), 
        .A1N(division_ratio[2]), .Y(n6) );
  AOI21XLM U18 ( .A0(division_ratio[1]), .A1(n31), .B0(n6), .Y(n23) );
  AOI31XLM U19 ( .A0(n9), .A1(n1), .A2(n10), .B0(n23), .Y(n8) );
  AOI2BB2XLM U20 ( .B0(division_ratio[3]), .B1(counter[2]), .A0N(counter[2]), 
        .A1N(division_ratio[3]), .Y(n12) );
  CLKINVX1M U21 ( .A(division_ratio[1]), .Y(n13) );
  OAI211XLM U22 ( .A0(division_ratio[2]), .A1(n12), .B0(counter[0]), .C0(n13), 
        .Y(n5) );
  NOR2XLM U23 ( .A(division_ratio[1]), .B(division_ratio[2]), .Y(n3) );
  OAI2B2XLM U24 ( .A1N(n12), .A0(n3), .B0(n2), .B1(n10), .Y(n4) );
  AOI21XLM U26 ( .A0(n6), .A1(n5), .B0(n4), .Y(n7) );
  OAI211XLM U27 ( .A0(n9), .A1(n15), .B0(n8), .C0(n7), .Y(n26) );
  CLKINVX1M U28 ( .A(division_ratio[0]), .Y(n29) );
  AOI211XLM U29 ( .A0(counter[0]), .A1(n13), .B0(n12), .C0(n11), .Y(n14) );
  AOI31XLM U30 ( .A0(n23), .A1(n15), .A2(n14), .B0(odd_toggle), .Y(n28) );
  AOI222XLM U31 ( .A0(n26), .A1(n29), .B0(n26), .B1(odd_toggle), .C0(
        division_ratio[0]), .C1(n28), .Y(n38) );
  OAI21XLM U32 ( .A0(n29), .A1(n26), .B0(odd_toggle), .Y(n27) );
  OAI31XLM U33 ( .A0(n29), .A1(n28), .A2(odd_toggle), .B0(n27), .Y(n22) );
  NOR2XLM U35 ( .A(counter[0]), .B(n38), .Y(n21) );
  CLKINVX1M U36 ( .A(counter[1]), .Y(n30) );
  AOI221XLM U37 ( .A0(counter[0]), .A1(counter[1]), .B0(n31), .B1(n30), .C0(
        n38), .Y(n20) );
  AOI221XLM U38 ( .A0(counter[3]), .A1(n32), .B0(n34), .B1(n33), .C0(n38), .Y(
        n18) );
  NOR2XLM U39 ( .A(n34), .B(n33), .Y(n37) );
  CLKINVX1M U40 ( .A(n37), .Y(n35) );
  AOI221XLM U41 ( .A0(counter[4]), .A1(n37), .B0(n36), .B1(n35), .C0(n38), .Y(
        n17) );
  AOI2BB2XLM U42 ( .B0(divided_clk), .B1(n38), .A0N(n38), .A1N(divided_clk), 
        .Y(n16) );
endmodule


module register_1 ( clk, reset, D, Q );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset;


  DFFRQX1M \Q_reg[0]  ( .D(D[0]), .CK(clk), .RN(reset), .Q(Q[0]) );
endmodule


module register_2 ( clk, reset, D, Q );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset;


  DFFRQX1M \Q_reg[0]  ( .D(D[0]), .CK(clk), .RN(reset), .Q(Q[0]) );
endmodule


module bus_synchronizer_1 ( clk, reset, asynchronous_data, synchronous_data );
  input [0:0] asynchronous_data;
  output [0:0] synchronous_data;
  input clk, reset;
  wire   \output_ports[0][0] ;

  register_2 U0_register ( .clk(clk), .reset(reset), .D(asynchronous_data[0]), 
        .Q(\output_ports[0][0] ) );
  register_1 \register_instance[1].U_register  ( .clk(clk), .reset(reset), .D(
        \output_ports[0][0] ), .Q(synchronous_data[0]) );
endmodule


module data_synchronizer_1 ( clk, reset, asynchronous_data_valid, 
        asynchronous_data, Q_pulse_generator, synchronous_data_valid, 
        synchronous_data );
  input [7:0] asynchronous_data;
  output [7:0] synchronous_data;
  input clk, reset, asynchronous_data_valid;
  output Q_pulse_generator, synchronous_data_valid;
  wire   synchronized_enable, pulse_generator_output, n1, n10, n11, n12, n13,
         n14, n15, n16, n17;

  bus_synchronizer_1 U_bus_synchronizer ( .clk(clk), .reset(reset), 
        .asynchronous_data(asynchronous_data_valid), .synchronous_data(
        synchronized_enable) );
  DFFRQX1M Q_pulse_generator_reg ( .D(synchronized_enable), .CK(clk), .RN(
        reset), .Q(Q_pulse_generator) );
  DFFRQX1M synchronous_data_valid_reg ( .D(pulse_generator_output), .CK(clk), 
        .RN(reset), .Q(synchronous_data_valid) );
  DFFRQX1M \synchronous_data_reg[7]  ( .D(n10), .CK(clk), .RN(reset), .Q(
        synchronous_data[7]) );
  DFFRQX1M \synchronous_data_reg[6]  ( .D(n11), .CK(clk), .RN(reset), .Q(
        synchronous_data[6]) );
  DFFRQX1M \synchronous_data_reg[5]  ( .D(n12), .CK(clk), .RN(reset), .Q(
        synchronous_data[5]) );
  DFFRQX1M \synchronous_data_reg[4]  ( .D(n13), .CK(clk), .RN(reset), .Q(
        synchronous_data[4]) );
  DFFRQX1M \synchronous_data_reg[3]  ( .D(n14), .CK(clk), .RN(reset), .Q(
        synchronous_data[3]) );
  DFFRQX1M \synchronous_data_reg[2]  ( .D(n15), .CK(clk), .RN(reset), .Q(
        synchronous_data[2]) );
  DFFRQX1M \synchronous_data_reg[1]  ( .D(n16), .CK(clk), .RN(reset), .Q(
        synchronous_data[1]) );
  DFFRQX1M \synchronous_data_reg[0]  ( .D(n17), .CK(clk), .RN(reset), .Q(
        synchronous_data[0]) );
  NOR2BXLM U3 ( .AN(synchronized_enable), .B(Q_pulse_generator), .Y(
        pulse_generator_output) );
  CLKINVX1M U4 ( .A(pulse_generator_output), .Y(n1) );
  AO22XLM U5 ( .A0(pulse_generator_output), .A1(asynchronous_data[5]), .B0(n1), 
        .B1(synchronous_data[5]), .Y(n12) );
  AO22XLM U6 ( .A0(pulse_generator_output), .A1(asynchronous_data[0]), .B0(n1), 
        .B1(synchronous_data[0]), .Y(n17) );
  AO22XLM U7 ( .A0(pulse_generator_output), .A1(asynchronous_data[4]), .B0(n1), 
        .B1(synchronous_data[4]), .Y(n13) );
  AO22XLM U8 ( .A0(pulse_generator_output), .A1(asynchronous_data[7]), .B0(n1), 
        .B1(synchronous_data[7]), .Y(n10) );
  AO22XLM U9 ( .A0(pulse_generator_output), .A1(asynchronous_data[6]), .B0(n1), 
        .B1(synchronous_data[6]), .Y(n11) );
  AO22XLM U10 ( .A0(pulse_generator_output), .A1(asynchronous_data[2]), .B0(n1), .B1(synchronous_data[2]), .Y(n15) );
  AO22XLM U11 ( .A0(pulse_generator_output), .A1(asynchronous_data[3]), .B0(n1), .B1(synchronous_data[3]), .Y(n14) );
  AO22XLM U12 ( .A0(pulse_generator_output), .A1(asynchronous_data[1]), .B0(n1), .B1(synchronous_data[1]), .Y(n16) );
endmodule


module reset_synchronizer_1 ( clk, reset, reset_synchronized );
  input clk, reset;
  output reset_synchronized;
  wire   \Q[0] ;

  DFFRQX1M \Q_reg[0]  ( .D(1'b1), .CK(clk), .RN(reset), .Q(\Q[0] ) );
  DFFRQX2M \Q_reg[1]  ( .D(\Q[0] ), .CK(clk), .RN(reset), .Q(
        reset_synchronized) );
endmodule


module register_5 ( clk, reset, D, Q );
  input [0:0] D;
  output [0:0] Q;
  input clk, reset;


  DFFRQX1M \Q_reg[0]  ( .D(D[0]), .CK(clk), .RN(reset), .Q(Q[0]) );
endmodule


module register_6 ( clk, reset, D, Q );
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


module system_top ( reference_clk, UART_clk, reset, serial_data_in, 
        serial_data_out, parity_error, frame_error );
  input reference_clk, UART_clk, reset, serial_data_in;
  output serial_data_out, parity_error, frame_error;
  wire   reference_reset_synchronized, ALU_result_valid,
         register_file_read_data_valid, UART_transmitter_busy_synchronized,
         transmitter_Q_pulse_generator_synchronized,
         receiver_parallel_data_valid_synchronized, ALU_enable, ALU_clk_enable,
         transmitter_parallel_data_valid, register_file_write_enable,
         register_file_read_enable, ALU_clk, UART_transmitter_busy,
         transmitter_Q_pulse_generator, receiver_parallel_data_valid,
         UART_reset_synchronized, UART_transmitter_clk,
         transmitter_parallel_data_valid_synchronized, n2;
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

  reset_synchronizer_0 U_reference_reset_synchronizer ( .clk(reference_clk), 
        .reset(reset), .reset_synchronized(reference_reset_synchronized) );
  system_controller U_system_controller ( .clk(reference_clk), .reset(n2), 
        .ALU_result_valid(ALU_result_valid), .ALU_result(ALU_result), 
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
        .register_file_read_enable(register_file_read_enable) );
  clock_gating_cell U_clock_gating_cell ( .clk(reference_clk), .clk_enable(
        ALU_clk_enable), .gated_clock(ALU_clk) );
  ALU U_ALU ( .clk(ALU_clk), .reset(n2), .A(ALU_operand_A), .B(ALU_operand_B), 
        .ALU_function(ALU_function), .enable(ALU_enable), .ALU_result_valid(
        ALU_result_valid), .ALU_result(ALU_result) );
  register_file U_register_file ( .clk(reference_clk), .reset(n2), .address(
        register_file_address), .write_enable(register_file_write_enable), 
        .write_data(register_file_write_data), .read_enable(
        register_file_read_enable), .read_data(register_file_read_data), 
        .read_data_valid(register_file_read_data_valid), .register0(
        ALU_operand_A), .register1(ALU_operand_B), .register2({
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        UART_parity_configuration[1:0]}), .register3({SYNOPSYS_UNCONNECTED__6, 
        SYNOPSYS_UNCONNECTED__7, UART_prescale_configuration[5:0]}) );
  bus_synchronizer_0 U_busy_bit_synchronizer ( .clk(reference_clk), .reset(n2), 
        .asynchronous_data(UART_transmitter_busy), .synchronous_data(
        UART_transmitter_busy_synchronized) );
  bus_synchronizer_3 U_Q_pulse_generator_bit_synchronizer ( .clk(reference_clk), .reset(n2), .asynchronous_data(transmitter_Q_pulse_generator), 
        .synchronous_data(transmitter_Q_pulse_generator_synchronized) );
  data_synchronizer_0 U_UART_receiver_data_synchronizer ( .clk(reference_clk), 
        .reset(n2), .asynchronous_data_valid(receiver_parallel_data_valid), 
        .asynchronous_data(receiver_parallel_data), .synchronous_data_valid(
        receiver_parallel_data_valid_synchronized), .synchronous_data(
        receiver_parallel_data_synchronized) );
  reset_synchronizer_1 U_UART_reset_synchronizer ( .clk(UART_clk), .reset(
        reset), .reset_synchronized(UART_reset_synchronized) );
  UART U_UART ( .transmitter_clk(UART_transmitter_clk), .receiver_clk(UART_clk), .reset(UART_reset_synchronized), .parity_type(UART_parity_configuration[1]), 
        .parity_enable(UART_parity_configuration[0]), .prescale(
        UART_prescale_configuration[5:0]), .transmitter_parallel_data_valid(
        transmitter_parallel_data_valid_synchronized), 
        .transmitter_parallel_data(transmitter_parallel_data_synchronized), 
        .serial_data_receiver(serial_data_in), .serial_data_transmitter(
        serial_data_out), .transmitter_busy(UART_transmitter_busy), 
        .receiver_parallel_data_valid(receiver_parallel_data_valid), 
        .receiver_parallel_data(receiver_parallel_data), 
        .parity_error_receiver(parity_error), .frame_error_receiver(
        frame_error) );
  clock_divider U_clock_divider ( .reference_clk(UART_clk), .reset(
        UART_reset_synchronized), .clk_divider_enable(1'b1), .division_ratio(
        UART_prescale_configuration[5:0]), .output_clk(UART_transmitter_clk)
         );
  data_synchronizer_1 U_UART_transmitter_data_synchronizer ( .clk(
        UART_transmitter_clk), .reset(UART_reset_synchronized), 
        .asynchronous_data_valid(transmitter_parallel_data_valid), 
        .asynchronous_data(transmitter_parallel_data), .Q_pulse_generator(
        transmitter_Q_pulse_generator), .synchronous_data_valid(
        transmitter_parallel_data_valid_synchronized), .synchronous_data(
        transmitter_parallel_data_synchronized) );
  CLKBUFX4M U3 ( .A(reference_reset_synchronized), .Y(n2) );
endmodule

