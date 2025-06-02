module tb;

  `include "uvm_macros.svh"
    import uvm_pkg::*;

  import top_test_pkg::*;




//DEFINICION DEL RELOJ  

    localparam time  CLK_PERIOD =10ns ;
    logic clk_i = 0;
    always #(CLK_PERIOD/2) clk_i = ~clk_i;

//DEFINICION DEL RESET
logic reset_i =1;
initial begin
repeat(2) @(posedge clk_i);
reset_i= 1;
@(posedge clk_i);
reset_i=0;
end


//DEFININICION DE LA INTERFAZ
 timeAlign_uvc_if timeAlign_vif(clk_i,reset_i);

//INSTANCIAR EL DUT

timeAlign dut(
     .clk_i(),          // Reloj del sistema
     .reset_i(),        // reset_i (activo en alto)
     .msb_i(), // Bits de la etapa 1 (MSBs)
     .lsb_i(), // Bits de la etapa 2 (LSBs)
     .dout_o()    // Salida alineada: {MSBs, LSBs}
);

initial begin
$timeformat(-9,0,"ns",10);
uvm_config_db#(virtual timeAlign_uvc_if)::set(null,"uvm_test_top.m_env.m_timeAlign_agent","vif",timeAlign_vif);

run_test();
end


endmodule:tb