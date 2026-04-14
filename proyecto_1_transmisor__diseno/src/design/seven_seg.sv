module seven_seg (
    input logic [3:0] datos,
    output logic [6:0] seg
);

    assign seg[6] = (~datos[3] & datos[2] & datos[0]) |
                (~datos[3] & datos[1]) |
                ( datos[3] & ~datos[2] & ~datos[1]) |
                ( datos[3] & ~datos[0]) |
                (~datos[2] & ~datos[0]) |
                ( datos[2] & datos[1]);

    assign seg[5] = (~datos[2] & ~datos[1]) |
            (~datos[2] & ~datos[0]) |
            (~datos[3] & ~datos[1] & ~datos[0]) |
            (~datos[3] &  datos[1] &  datos[0]) |
            ( datos[3] & ~datos[1] &  datos[0]);


    assign seg[4] = (~datos[2] & ~datos[1]) |
             (~datos[2] &  datos[0]) |
             (~datos[1] &  datos[0]) |
             (~datos[3] &  datos[2]) |
             ( datos[3] & ~datos[2]);


    assign seg[3] = (~datos[3] & datos[1] & ~datos[0]) |
                ( datos[3] & ~datos[1]) |
                (~datos[2] & ~datos[1] & ~datos[0]) |
                (~datos[2] &  datos[1] &  datos[0]) |
                ( datos[2] & ~datos[1] &  datos[0]) |
                ( datos[2] &  datos[1] & ~datos[0]);


    assign seg[2] = ( datos[3] & datos[2]) |
                ( datos[3] & datos[1]) |
                (~datos[2] & ~datos[0]) |
                ( datos[1] & ~datos[0]);


    assign seg[1] = (~datos[3] & datos[2] & ~datos[1]) |
                ( datos[3] & ~datos[2]) |
                ( datos[3] & datos[1]) |
                ( datos[2] & ~datos[0]) |
                (~datos[1] & ~datos[0]);


    assign seg[0] = (~datos[3] & datos[2] & ~datos[1]) |
                ( datos[3] & ~datos[2]) |
                ( datos[3] & datos[0]) |
                (~datos[2] & datos[1]) |
                ( datos[1] & ~datos[0]);

endmodule