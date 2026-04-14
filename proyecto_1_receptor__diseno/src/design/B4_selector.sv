module B4_selector(

    input  logic switch,
    input  logic [6:0] codigo_corregido,
    input  logic [2:0] posicion,

    output logic [3:0] valor_display 

);

logic [3:0] palabra;

assign palabra = {codigo_corregido[6], codigo_corregido[5], codigo_corregido[4], codigo_corregido[2]};

always_comb begin
    if (switch == 0) begin
        valor_display = palabra;              // mostrar palabra
    end
    else begin
        valor_display = {1'b0, posicion};     // mostrar posición (3 bits → 4 bits)
    end
end

endmodule