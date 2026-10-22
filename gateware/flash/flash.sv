module top (
    input clk,

    output flash_csn,
    output flash_mosi,
    output flash_wpn,
    output flash_resetn,
    input  flash_miso,

    input [1:0] button,

    output usb_tx
);
    assign resetn = button[0];
    assign flash_csn = 0;
    assign flash_wpn = 1;
    assign flash_resetn = resetn;

    wire flash_sck;
    wire tristate = 1'b0;
    USRMCLK u1 (.USRMCLKI(flash_sck), .USRMCLKTS(tristate));
endmodule
