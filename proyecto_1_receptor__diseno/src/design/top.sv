module top #(
    parameter DEBUG = 0,  // 0 = normal (TB/hardware), 1 = código interno
    parameter DEBUG_SWITCH = 1  // 0 = palabra, 1 = posicion
)(

    input  logic i3,
    input  logic i2,
    input  logic i1,
    input  logic c2,
    input  logic i0,
    input  logic c1,
    input  logic c0,

    input logic switch,

    output logic [2:0] posicion, 
    output logic [6:0] codigo_corregido,
    output logic [3:0] led,

    output logic [6:0] segments
);

logic [6:0] codigo;
logic [3:0] valor_display;
logic switch_int;


assign codigo = (DEBUG) 
              ? 7'b1111001
              : {i3,i2,i1,c2,i0,c1,c0};


assign switch_int = (DEBUG) ? DEBUG_SWITCH : switch;



// Decodificador
B1_decodificador_de_paridad decodificador(
    .i3(codigo[6]),
    .i2(codigo[5]),
    .i1(codigo[4]),
    .c2(codigo[3]),
    .i0(codigo[2]),
    .c1(codigo[1]),
    .c0(codigo[0]),
    .posicion(posicion)
);

// Corrector
B2_corrector_de_error corrector(
    .posicion(posicion),
    .codigo(codigo),
    .codigo_corregido(codigo_corregido)
);

// Selector
B4_selector selector(
    .switch(switch_int),  
    .codigo_corregido(codigo_corregido),
    .posicion(posicion),
    .valor_display(valor_display)
);

// LEDs
B3_despliegue_led despliegue(
    .codigo_corregido(codigo_corregido),
    .led(led)
);

// 7 segmentos
B5_7segmentos display(
    .valor(valor_display),
    .segments(segments)
);

endmodule