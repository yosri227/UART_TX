module tx_top // TOP MODULE OF UART_TX

// PORTS (I/O) DECLARATION 
(
input [7:0] p_data,
input       data_valid,
input       par_en,
input       par_typ,
input       clk,
input       rst,
output      busy_reg,
output      out_tx
);

// internal signals 
wire enable;
wire done ;
wire data_ser;
wire bit_par;
wire busy_wir;
wire [1:0] sel_mux;

// SERALISER UNIT
serliser  u1 (
.clk(clk),
.rest(rst),
.data_valid(data_valid),
.p_data(p_data),
.ser_en(enable),
.ser_done(done),
.ser_data(data_ser)
);

// FSM UNIT
fs_art  u2 (
.clk(clk),
.rest(rst),
.par_en(par_en),  
.data_valid(data_valid),
.ser_done(done),
.ser_en(enable),
.mux_sel(sel_mux),
.busy(busy_wir)
);

// PARITY CALCULATOR 
parity u3(
.clk(clk),
.rest(rst),
.p_data(p_data),
.par_typ(par_typ),
.data_valid(data_valid),
.par_bit(bit_par)
);

// MUX
mux_art u4 (
.sel(sel_mux),
.clk (clk),
.rst(rst),
.ser_data(data_ser),
.par_bit(bit_par),
.out_tx_reg(out_tx),
.busy(busy_wir),
.busy_reg(busy_reg)
);

endmodule 