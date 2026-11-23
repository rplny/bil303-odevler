module dortten_bire_mux (
    input  logic [7:0] kaynak0,
    input  logic [7:0] kaynak1,
    input  logic [7:0] kaynak2,
    input  logic [7:0] kaynak3,
    input  logic [1:0] secim,
    output logic [7:0] cikis
);

    always_comb begin
        case (secim)
            2'b00: cikis = kaynak0;
            2'b01: cikis = kaynak1;
            2'b10: cikis = kaynak2;
            2'b11: cikis = kaynak3;
            
            default: cikis = 8'h00;
        endcase
    end

endmodule
