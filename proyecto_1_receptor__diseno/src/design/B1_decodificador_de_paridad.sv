module B1_decodificador_de_paridad( 
    //input entrada, logic 1 o 0, output saluda 
    input logic i3, 
    input logic i2, 
    input logic i1, 
    input logic c2, 
    input logic i0, 
    input logic c1, 
    input logic c0, 
    output logic [2:0] posicion 
); 

logic [2:0] sindrome;

// cálculo del síndrome
assign sindrome[0] = c0 ^ i0 ^ i1 ^ i3;
assign sindrome[1] = c1 ^ i0 ^ i2 ^ i3;
assign sindrome[2] = c2 ^ i1 ^ i2 ^ i3;

// desplazar posiciones
assign posicion = (sindrome == 3'b000) ? 3'b111 : sindrome - 1;

endmodule