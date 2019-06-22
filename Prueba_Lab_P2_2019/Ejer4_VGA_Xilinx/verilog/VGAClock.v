module VGAClock(
    input clk, // 100MHZ
    output vga_clk
);

    DCM_SP #(
        .CLKFX_DIVIDE(8),
        .CLKFX_MULTIPLY(2),
        .CLKIN_PERIOD(10)
    ) vga_clock_dcm (
        .CLKIN(clk),
        .CLKFX(vga_clk),
        .CLKFB(1'b0),
        .PSEN(1'b0),
        .RST(1'b0)
    );

endmodule
