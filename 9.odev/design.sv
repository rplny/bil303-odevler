module ieee_coz (
    input  logic [31:0] giris,
    output logic        isaret,
    output logic [7:0]  us,
    output logic [22:0] kesir,
    output logic        sifir,
    output logic        altnormal,
    output logic        normal,
    output logic        sonsuz,
    output logic        nan
);

    assign isaret = giris[31];
    assign us     = giris[30:23];
    assign kesir  = giris[22:0];

    always_comb begin
        sifir     = 1'b0;
        altnormal = 1'b0;
        normal    = 1'b0;
        sonsuz    = 1'b0;
        nan       = 1'b0;

        if (us == 8'h00) begin
            if (kesir == 23'd0)
                sifir = 1'b1;
            else
                altnormal = 1'b1;
        end else if (us == 8'hFF) begin
            if (kesir == 23'd0)
                sonsuz = 1'b1;
            else
                nan = 1'b1;
        end else begin
            normal = 1'b1;
        end
    end

endmodule
