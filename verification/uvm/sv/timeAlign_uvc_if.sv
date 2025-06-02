`ifndef TIMEALIGN_UVC_IF_SV
`define TIMEALIGN_UVC_IF_SV

interface timeAlign_uvc_if
(
    input logic clk_i,
    input logic reset_i
);

    
     logic [2:0] msb_i; // Bits de la etapa 1 (MSBs)
     logic [2:0] lsb_i; // Bits de la etapa 2 (LSBs)
     logic [5:0] dout_o;    // Salida alineada: {MSBs, LSBs}

     initial begin
       msb_i  = 'd0;
       lsb_i  = 'd0;

     end

//                                [interface dut_if]
//     +--------+         writes         +-------+         reads         +----------+
//     | Driver | ---------------------> | DUT   | --------------------> | Monitor  |
//     +--------+   rst, data_in         +-------+     data_out          +----------+


//EL DRIVER CONTROLA ESTAS SEÑALES, POR LO TANTO ESAS SEÑALES
//SON SALIDS DEL DRIVER QUE ENTRAS AL DUT
clocking cb_drv @(posedge clk_i);
    default input #1ns output #1ns;
     output  msb_i; // Bits de la etapa 1 (MSBs)
     output  lsb_i; // Bits de la etapa 2 (LSBs)
endclocking: cb_drv

//EL MONITOR LEE LO QUE TENGA LA SALIDA DEL DUT, POR LO TANTO
//ES UNA ENTRADA
clocking cb_mon @(posedge clk_i);
    default input #1ns output #1ns;

input  dout_o;    // Salida alineada: {MSBs, LSBs}

endclocking: cb_mon

  clocking cb_drv_neg @(negedge clk_i);
    default input #1ns output #1ns;

input  dout_o;    // Salida alineada: {MSBs, LSBs}

endclocking: cb_drv_neg


endinterface:timeAlign_uvc_if


`endif // TIMEALIGN_UVC_IF_SV

