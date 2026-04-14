`timescale 1ns/1ps

module transmitter_top_tb;

    logic [2:0] error_pos;
    logic [3:0] datos;
    logic [6:0] hamming_error;
    logic [6:0] seg;

    // Señales internas esperadas
    logic [6:0] hamming_correcto;
    logic [6:0] expected_hamming_error;
    logic [6:0] expected_seg;
    logic [2:0] c;

    // DUT
    transmitter_top dut (
        .error_pos(error_pos),
        .datos(datos),
        .hamming_error(hamming_error),
        .seg(seg)
    );

    // Modelo esperado del codificador (Hamming 7,4)
    always_comb begin
        c[0] = datos[0] ^ datos[1] ^ datos[3];
        c[1] = datos[0] ^ datos[2] ^ datos[3];
        c[2] = datos[1] ^ datos[2] ^ datos[3];

        hamming_correcto = {datos[3], datos[2], datos[1], c[2],
                            datos[0], c[1], c[0]};
    end

    // Modelo esperado del error
    always_comb begin
        if (error_pos == 3'b000)
            expected_hamming_error = hamming_correcto;
        else
            expected_hamming_error = hamming_correcto ^ (7'b1 << (error_pos - 1));
    end

    // Modelo esperado del 7 segmentos
    always_comb begin
        case (datos)
            4'h0: expected_seg = 7'b111_1110;
            4'h1: expected_seg = 7'b011_0000;
            4'h2: expected_seg = 7'b110_1101;
            4'h3: expected_seg = 7'b111_1001;
            4'h4: expected_seg = 7'b011_0011;
            4'h5: expected_seg = 7'b101_1011;
            4'h6: expected_seg = 7'b101_1111;
            4'h7: expected_seg = 7'b111_0000;
            4'h8: expected_seg = 7'b111_1111;
            4'h9: expected_seg = 7'b111_1011;
            4'hA: expected_seg = 7'b111_0111;
            4'hB: expected_seg = 7'b001_1111;
            4'hC: expected_seg = 7'b100_1110;
            4'hD: expected_seg = 7'b011_1101;
            4'hE: expected_seg = 7'b100_1111;
            4'hF: expected_seg = 7'b100_0111;
            default: expected_seg = 7'b000_0000;
        endcase
    end

    initial begin
        $display("INICIO TEST TOP");

        for (int d = 0; d < 16; d++) begin
            datos = d;

            for (int p = 0; p < 8; p++) begin
                error_pos = p;
                #5;

                // Verificar Hamming con error
                if (hamming_error !== expected_hamming_error) begin
                    $error("ERROR HAMMING: datos=%b pos=%0d | salida=%b esperado=%b",
                            datos, error_pos, hamming_error, expected_hamming_error);
                end

                // Verificar 7 segmentos
                if (seg !== expected_seg) begin
                    $error("ERROR 7SEG: datos=%h | seg=%b esperado=%b",
                            datos, seg, expected_seg);
                end

            end
        end

        $display("TEST COMPLETADO SIN ERRORES");
        $finish;
    end

    initial begin
            $dumpfile("transmitter_top_tb.vcd");  // For waveform viewing
            $dumpvars(0, transmitter_top_tb);
    end


endmodule