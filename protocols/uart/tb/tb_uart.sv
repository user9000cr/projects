`timescale 1ns/1ps

module tb_uart;
    reg clk = 0;
    reg reset = 1;
    wire tx;
    
    uart u(.clk(clk), .reset(reset), .tx(tx));

    /* verilator lint_off STMTDLY */
    always #5 clk = ~clk;

    initial begin
        #10 reset = 0;
        #100 $finish;
    end
    /* verilator lint_off STMTDLY */

endmodule
