`timescale 1ns/1ns
module tx_top_tb ();
  // all inputs are reg
  // all outputs are wire 
  
reg [7:0]  p_data_tb;
reg        data_valid_tb;
reg        par_en_tb;
reg        par_typ_tb;
reg        clk_tb;
reg        rst_tb;
wire       busy_reg_tb;
wire       out_tx_tb;

// intial block 
  initial 
  begin
  $dumpfile("tx_top.vcd") ;
  $dumpvars ;
  //initial values
  clk_tb=1'b0;
  p_data_tb=8'b0;
  par_en_tb=1'b0;
  par_typ_tb=1'b0;
  data_valid_tb=1'b0;
  rst_tb=1'b0;
  #3 // CASE ONE
   p_data_tb=8'b10101110;
  par_en_tb=1'b1;
  par_typ_tb=1'b1;
  data_valid_tb=1'b1;
  rst_tb=1'b1;
  #12
  data_valid_tb=1'b0;
  #90 // CASE TWO
  p_data_tb=8'b11101110;
  par_en_tb=1'b1;
  par_typ_tb=1'b0;
  data_valid_tb=1'b1;
  #12
  data_valid_tb=1'b0;
  // #88 // CASE THREE
  //p_data_tb=8'b10101010;
  //par_en_tb=1'b0;
  //par_typ_tb=1'b0;
  //data_valid_tb=1'b1;
  //#12
//  data_valid_tb=1'b0;

  #200
  $stop;  
 end
  // Clock Generator  
 always #5 clk_tb = !clk_tb ;
   
  // mapping 
tx_top  dut (
.p_data(p_data_tb),
.data_valid(data_valid_tb),
.par_en(par_en_tb),
.par_typ(par_typ_tb),
.clk(clk_tb),
.rst(rst_tb),
.busy_reg(busy_reg_tb),
.out_tx(out_tx_tb)
);   

endmodule 
   
  


