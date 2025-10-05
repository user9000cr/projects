`timescale 1ns/1ps

module uart(input logic clk, input logic reset, output reg tx);
    always @(posedge clk or posedge reset) begin
        if(reset) tx <= 1'b0;
        else tx <= ~tx;
    end
endmodule
