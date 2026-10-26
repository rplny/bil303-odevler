module alu4 (
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic [1:0] secim,
    output logic [3:0] cikis
);
    always_comb begin
        case (secim)
            2'b00: cikis = a + b;
            2'b01: cikis = a - b;
            2'b10: cikis = a & b;
            2'b11: cikis = a | b;
            default: cikis = 4'h0;
        endcase
    end
endmodule
