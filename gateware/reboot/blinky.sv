module top (
    input  wire        clk,
    input  wire  [1:0] button,

    output logic [4:0] led,
    output logic       programn
);
    // Delay until the pin levels have been stabilized after boot
    reg [10:0] counter = 0;

    always @(posedge clk) begin
        if (counter[10] == 0) begin
            counter <= counter + 1;
        end
    end

    assign led = 5'b11111;
    assign programn = button[1] | ~counter[10];
endmodule
