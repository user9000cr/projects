`timescale 1ns/1ps

module uart_tx (
  input logic       clk,
  input logic       rst_n,
  input logic [7:0] tx_data_in, // Byte of data to be sent
  input logic       tx_start_in, // Indication to start the transmission
  output logic      tx_busy_out, // High while busy
  output logic      tx_data_out // Bit of output data
);

  logic [7:0] tx_data_in_serial;

  typedef enum logic [1:0] {IDLE, START, SEND_DATA, STOP} state_t;
  state_t current_state, next_state;

  // FSM sequential logic
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      current_state <= IDLE;
    end else begin
      current_state <= next_state;
    end
  end

  // FSM combinational logic
  always_comb begin
    next_state  = current_state;
    tx_busy_out = 1'b1;

    case (current_state)
      // set initial values, if tx_start_in then move to start state
      IDLE: 
        tx_data_out = 1'b1;
        tx_busy_out = 1'b0;
        if (tx_start_in) begin
          state             = START;
        end

      // send the first bit (0) and move to send_data state
      START:
        tx_data_out = 1'b0;
        tx_busy_out = 1'b1;
        state       = SEND_DATA;

      SEND_DATA:
        tx_data_out = tx_data_in_serial >> 1;
      STOP:

    endcase
  end

  always @(posedge clk or posedge rst_n) begin
    if(rst_n) tx <= 1'b0;
      else tx <= ~tx;
  end

endmodule
