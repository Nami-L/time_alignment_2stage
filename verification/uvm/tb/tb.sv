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
// time_alignment_2stage_uvc_if t_a_2_vif(clk_i,reset_i);

//INSTANCIAR EL DUT

time_alignment_2stage dut(
     .clk_i(),          // Reloj del sistema
     .reset_i(),        // reset_i (activo en alto)
     .msb_i(), // Bits de la etapa 1 (MSBs)
     .lsb_i(), // Bits de la etapa 2 (LSBs)
     .dout_o()    // Salida alineada: {MSBs, LSBs}
);

initial begin
$timeformat(-9,0,"ns",10);
//uvm_config_db#(virtual t_a_2_vif)::set(null,"uvm_test_top.m_env.m_adder_agent","vif",t_a_2_vif);

run_test();
end


endmodule:tb