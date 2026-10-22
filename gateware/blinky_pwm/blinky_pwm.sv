module top (
    output logic [4:0] led,
    input  logic [1:0] button,
    input  wire        clk
);
    // Delay counters
    logic [28:0] clkb;
    // button 0 is used to enable/disable and restart the counter LEDs
    wire b0 = button[0];
    // button 1 is used to disable PWM dimming of LEDs
    wire b1 = button[1];

    // Capture rising edge button trigger and falling edge button trigger
    wire enable;
    reg r_toggle = 0;
    reg f_toggle = 0;

    always @(posedge b0) r_toggle <= !r_toggle;
    always @(negedge b0) f_toggle <= !f_toggle;

    // XOR gate creates a toggle state that flips on every push and release
    assign enable = r_toggle ^ f_toggle;

    initial begin
      clkb = 0;
      gpio[4] = 0;
    end

    // Primary Clock Domain
    always_ff @(posedge clk) begin
      if (enable) begin
        clkb <= clkb + 1'b1; // count clocks
      end
      else begin
        clkb <= 0; // reset clock counter
      end
    end

    // LED Output / PWM Dimming
    always_ff @(negedge clk) begin
      if ((clkb[3:2] != 2'b11) && (b1)) // use same clock counter for PWM
        led <= 0;
      else
        led <= clkb[28:24];  // simpler way to decimate clock counter using MSBs
    end

endmodule
