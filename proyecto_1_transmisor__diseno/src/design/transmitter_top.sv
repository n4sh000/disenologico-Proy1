module transmitter_top (
    input logic [2:0] error_pos,
    input logic [3:0] datos,
    output logic [6:0] hamming_error,
    output logic [6:0] seg
);

    logic [6:0] hamming_correcto;

    codification mod_codificador(
        .i(datos),
        .h(hamming_correcto)
    );

    error_generator mod_error(
        .error_pos(error_pos),
        .datos(hamming_correcto),
        .datos_error(hamming_error)
    );

    seven_seg mod_7seg(
        .datos(datos),
        .seg(seg)
    );

endmodule