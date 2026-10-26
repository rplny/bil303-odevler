module alu64 (
    input  logic [63:0] a,
    input  logic [63:0] b,
    input  logic [1:0]  secim,
    output logic [63:0] cikis
);
    always_comb begin
        case (secim)
            2'b00: cikis = a + b;
            2'b01: cikis = a - b;
            2'b10: cikis = a & b;
            2'b11: cikis = a | b;
            default: cikis = 64'h0;
        endcase
    end
endmodule
//https://www.edaplayground.com/x/iACA Playground EDA linki
