module codification (
    input logic [3:0] i,
    output logic [6:0] h
);

    logic [2:0] c;

    assign c[0] = i[0] ^ i[1] ^ i[3];
    assign c[1] = i[0] ^ i[2] ^ i[3];
    assign c[2] = i[1] ^ i[2] ^ i[3];

    assign h = {i[3], i[2], i[1], c[2], i[0], c[1], c[0]};


    
endmodule