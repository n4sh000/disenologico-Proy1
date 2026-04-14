`timescale 1ns/1ps

module seven_seg_tb;

    logic [3:0] datos;
    logic [6:0] seg;
    logic [6:0] expected;

    // DUT
    seven_seg dut (
        .datos(datos),
        .seg(seg)
    );

    // Modelo esperado
    always_comb begin
        case (datos)
            4'h0: expected = 7'b111_1110;
            4'h1: expected = 7'b011_0000;
            4'h2: expected = 7'b110_1101;
            4'h3: expected = 7'b111_1001;
            4'h4: expected = 7'b011_0011;
            4'h5: expected = 7'b101_1011;
            4'h6: expected = 7'b101_1111;
            4'h7: expected = 7'b111_0000;
            4'h8: expected = 7'b111_1111;
            4'h9: expected = 7'b111_1011;
            4'hA: expected = 7'b111_0111;
            4'hB: expected = 7'b001_1111;
            4'hC: expected = 7'b100_1110;
            4'hD: expected = 7'b011_1101;
            4'hE: expected = 7'b100_1111;
            4'hF: expected = 7'b100_0111;
            default: expected = 7'b000_0000;
        endcase
    end

    initial begin
        $display("INICIO TEST 7-SEG");

        // Probar todos los valores (0 a 15)
        for (int i = 0; i < 16; i++) begin
            datos = i;
            #5;

            if (seg !== expected) begin
                $error("ERROR: datos=%h | seg=%b | esperado=%b",
                        datos, seg, expected);
            end
        end

        $display("TEST COMPLETADO SIN ERRORES");
        $finish;
    end

    initial begin
            $dumpfile("seven_seg_tb.vcd");  // For waveform viewing
            $dumpvars(0, seven_seg_tb);
    end

endmodule