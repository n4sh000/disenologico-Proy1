`timescale 1ns/1ps

module codification_tb;

    // Señales de prueba
    logic [3:0] i;
    logic [6:0] h;

    // Instancia del DUT (Device Under Test)
    codification dut (
        .i(i),
        .h(h)
    );

    // Proceso de estímulos
    initial begin
        $display(" i    |    h ");
        $display("--------------");

        // Probar todas las combinaciones (0 a 15)
        for (int k = 0; k < 16; k++) begin
            i = k;
            #10; // esperar 10 ns
            $display("%b  |  %b", i, h);
        end

        $finish;
    end

    initial begin
        $dumpfile("codification_tb.vcd");  // For waveform viewing
        $dumpvars(0, codification_tb);
    end

endmodule