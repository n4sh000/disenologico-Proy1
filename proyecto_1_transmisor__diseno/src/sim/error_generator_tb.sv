`timescale 1ns/1ps

module error_generator_tb;

    logic [2:0] error_pos;
    logic [6:0] datos;
    logic [6:0] datos_error;

    logic [6:0] expected;

    // DUT
    error_generator dut (
        .error_pos(error_pos),
        .datos(datos),
        .datos_error(datos_error)
    );

    // Modelo esperado
    always_comb begin
        if (error_pos == 3'b000)
            expected = datos;
        else
            expected = datos ^ (7'b1 << (error_pos - 1));
    end

    initial begin
        $display("INICIO TEST");

        // Probar TODOS los datos (7 bits) y todas las posiciones
        for (int d = 0; d < 128; d++) begin
            datos = d;

            for (int p = 0; p < 8; p++) begin
                error_pos = p;
                #5;

                if (datos_error !== expected) begin
                    $error("FALLO: datos=%b pos=%0d | salida=%b esperado=%b",
                            datos, error_pos, datos_error, expected);
                end
            end
        end

        $display("TEST COMPLETADO SIN ERRORES");
        $finish;
    end

    initial begin
        $dumpfile("error_generator_tb.vcd");  // For waveform viewing
        $dumpvars(0, error_generator_tb);
    end

endmodule