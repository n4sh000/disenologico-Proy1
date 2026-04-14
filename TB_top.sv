`timescale 1ns/1ps

module TB_top;

    // entradas
    logic i3, i2, i1, c2, i0, c1, c0;
    logic switch;

    // salidas
    logic [2:0] posicion;
    logic [6:0] codigo_corregido;
    logic [3:0] led;
    logic [6:0] segments;

    // instancias
    top #(
        .DEBUG(0),
        .DEBUG_SWITCH(0)
    ) uut (
        .i3(i3),
        .i2(i2),
        .i1(i1),
        .c2(c2),
        .i0(i0),
        .c1(c1),
        .c0(c0),
        .switch(switch),
        .posicion(posicion),
        .codigo_corregido(codigo_corregido),
        .led(led),
        .segments(segments)
    );

    // prueba
    initial begin

        $display("=== test de top ===");

        // Entrada
        {i3,i2,i1,c2,i0,c1,c0} = 7'b1111001;
        #10;

        // Resultados
        $display("Codigo recibido:        %b", {i3,i2,i1,c2,i0,c1,c0});
        $display("Posicion error:         %b", posicion);
        $display("Codigo corregido:       %b", codigo_corregido);
        $display("Palabra (LEDs):   %b", {
            codigo_corregido[6],
            codigo_corregido[5],
            codigo_corregido[4],
            codigo_corregido[2]
        });

        // switch = palabra
        switch = 0; 
        #10;
        $display("--- Switch=   %b", switch);

        #10;
        $display("Palabra 7segs: %h", {
            codigo_corregido[6],
            codigo_corregido[5],
            codigo_corregido[4],
            codigo_corregido[2]
        });

        // switch = posicion
        switch = 1; 
        #10;
        $display("--- Switch=   %b", switch);

        #10;
        $display("Posicion 7segs:   %h", posicion);

        $display("=== fin del test ===");
        $finish;

    end

endmodule