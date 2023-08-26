module mux_art  // FOR SELECTION

//PORTS I/O DECLARATION
(
input [1:0] sel,
input       clk,
input       rst,
input       busy,
input       ser_data,
input       par_bit,
output  reg   busy_reg,
output  reg out_tx_reg
);
// internal signals
reg  out_tx;

// sequential always 
always @(posedge clk or negedge rst)
begin
  if(!rst)
    begin
    out_tx_reg<=1'b1;
    busy_reg<=1'b0;
  end
  else
    begin
    out_tx_reg<= out_tx;
    busy_reg<= busy;
    end
end

// COMBINATIONAL ALWAYS 
always @(*)
begin
  case (sel)
  2'b00:out_tx=1'b1; // IDEAL & STOP BIT
  2'b01:out_tx= 1'b0; // START BIT
  2'b10:out_tx=ser_data; // SERIALIZER DATA 
  2'b11:out_tx=par_bit;  // PARITY BIT
  default: out_tx=1'b1;
endcase
end 
endmodule 
