module B3_despliegue_led(

    input  logic [6:0] codigo_corregido,
    output logic [3:0] led

);

// mandar la palabra a los leds
assign led =~{codigo_corregido[6], codigo_corregido[5], codigo_corregido[4], codigo_corregido[2]};

endmodule