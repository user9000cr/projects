`timescale 1ns/1ps

module ahb_master (
    input  logic        HCLK,
    input  logic        HRESETn,
    output logic [31:0] HADDR,
    output logic        HWRITE,
    output logic [31:0] HWDATA,
    input  logic [31:0] HRDATA,
    output logic        HSEL,
    output logic        HREADY,
    input  logic        HREADYOUT
);

    typedef enum logic [1:0] {IDLE, WRITE, READ, DONE} state_t;
    state_t state;

    always_ff @(posedge HCLK or negedge HRESETn) begin
        if (!HRESETn) begin
            state   <= IDLE;
            HADDR   <= 0;
            HWDATA  <= 0;
            HWRITE  <= 0;
            HSEL    <= 0;
        end else begin
            case (state)
                IDLE: begin
                    HADDR  <= 32'h0000_0004;
                    HWDATA <= 32'hDEADBEEF;
                    HWRITE <= 1;
                    HSEL   <= 1;
                    state  <= WRITE;
                end
                WRITE: begin
                    if (HREADYOUT) begin
                        HWRITE <= 0;
                        state  <= READ;
                    end
                end
                READ: begin
                    if (HREADYOUT) begin
                        state <= DONE;
                    end
                end
                DONE: begin
                    HSEL <= 0;
                end
            endcase
        end
    end

    assign HREADY = 1;

endmodule

