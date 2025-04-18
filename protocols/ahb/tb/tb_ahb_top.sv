`timescale 1ns/1ps

module tb_ahb_top;

    logic        clk;
    logic        rst_n;
    logic [31:0] HADDR, HWDATA, HRDATA;
    logic        HWRITE, HSEL, HREADY, HREADYOUT;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz
    end

    // Reset
    initial begin
        rst_n = 0;
        #20 rst_n = 1;
    end

    // DUTs
    ahb_master master (
        .HCLK(clk),
        .HRESETn(rst_n),
        .HADDR(HADDR),
        .HWRITE(HWRITE),
        .HWDATA(HWDATA),
        .HRDATA(HRDATA),
        .HSEL(HSEL),
        .HREADY(HREADY),
        .HREADYOUT(HREADYOUT)
    );

    ahb_slave slave (
        .HCLK(clk),
        .HRESETn(rst_n),
        .HADDR(HADDR),
        .HWRITE(HWRITE),
        .HWDATA(HWDATA),
        .HRDATA(HRDATA),
        .HSEL(HSEL),
        .HREADY(HREADY),
        .HREADYOUT(HREADYOUT)
    );

    // Dump VCD
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_ahb_top);
        #200 $finish;
    end

endmodule

