module error_generator (
    input logic [2:0] error_pos,
    input logic [6:0] datos,
    output logic [6:0] datos_error
);

    logic [6:0] mascara;

    assign mascara = (error_pos == 3'b000) ? 7'b0000000:  7'b0000001 << (error_pos-1);

    assign datos_error = datos ^ mascara;

endmodule