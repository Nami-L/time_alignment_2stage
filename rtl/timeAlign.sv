//Verilog HDL for "ASIC_2024", "timeAlign" "functional"

module timeAlign (
    input logic clk_i,          // Reloj del sistema
    input logic reset_i,        // reset_i (activo en alto)
    input logic [2:0] msb_i, // Bits de la etapa 1 (MSBs)
    input logic [2:0] lsb_i, // Bits de la etapa 2 (LSBs)
    output logic [5:0] dout_o   // Salida alineada: {MSBs, LSBs}
);

    // Registro para almacenar los MSBs de la etapa 1
    logic [2:0] msb_reg;

    always_ff @ (posedge clk_i or posedge reset_i) begin
        if (reset_i) begin
            msb_reg <= 3'b000; // reset_i del registro
            dout_o    <= 6'b000000;
        end else begin
            // Almacena los MSBs actuales
            msb_reg <= msb_i;
            // Combina los MSBs del ciclo anterior con los LSBs actuales
            dout_o <= {msb_reg, lsb_i};
        end
    end

endmodule
