`timescale 1ns/1ps

module ahb_slave (
    input  logic        HCLK,
    input  logic        HRESETn,
    input  logic [31:0] HADDR,
    input  logic        HWRITE,
    input  logic [31:0] HWDATA,
    output logic [31:0] HRDATA,
    input  logic        HSEL,
    input  logic        HREADY,
    output logic        HREADYOUT
);

    logic [31:0] mem [0:15];

    always_ff @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn) begin
            HRDATA <= 0;
            HREADYOUT <= 1;
        end else if (HSEL && HREADY) begin
            if (HWRITE) begin
                mem[HADDR[5:2]] <= HWDATA;
            end else begin
                HRDATA <= mem[HADDR[5:2]];
            end
        end
    end

endmodule

