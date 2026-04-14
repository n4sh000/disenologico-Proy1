module B2_corrector_de_error(
    input  logic [2:0] posicion,
    input  logic [6:0] codigo,
    output logic [6:0] codigo_corregido
);

always_comb begin

    codigo_corregido = codigo; // por defecto no cambia nada

    case(posicion)

        3'b000: codigo_corregido[0] = ~codigo[0];
        3'b001: codigo_corregido[1] = ~codigo[1];
        3'b010: codigo_corregido[2] = ~codigo[2];
        3'b011: codigo_corregido[3] = ~codigo[3];
        3'b100: codigo_corregido[4] = ~codigo[4];
        3'b101: codigo_corregido[5] = ~codigo[5];
        3'b110: codigo_corregido[6] = ~codigo[6];

        default: ; // no cambia nada

    endcase

end

endmodule