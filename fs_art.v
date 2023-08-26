// finite state machine for u_art_tx
///////////// Moore FSM /////////////
module fs_art (
input               clk,
input               rest,
input               par_en,  
input               data_valid,
input               ser_done,
output  reg         ser_en,
output  reg   [1:0] mux_sel,
output  reg         busy
); 
// local parameters
localparam ideal=2'b00,
              s1=2'b01,
              s2=2'b10,
              s3=2'b11;
              
               
  // cuurent state & next state 
  
  reg [1:0] current_state;
  reg [1:0] next_state;
  
  // state transition
  always @(posedge clk or negedge rest)
  begin 
  if(!rest)
  begin
    current_state<=ideal; 
  end
  else
  begin
   current_state<=next_state;  
  end         
  end
  
  // state transition
  always @(*)
  begin
              busy=1'b0;
              mux_sel=2'b0;
              next_state=ideal;
              ser_en=1'b0;
   case(current_state)
    ideal:begin
          if(data_valid)
            begin
              next_state=s1;
              ser_en=1'b1;
              mux_sel=2'b0;
            end
          else
            begin
              busy=1'b0;
              mux_sel=2'b0;
              next_state=ideal;
              ser_en=1'b0;
            end
          end
     s1: begin
              busy=1'b1;
              mux_sel=2'b01;
              next_state=s2;
              ser_en=1'b1;
            end
       s2: begin
              busy=1'b1;
              if(ser_done && par_en)
                begin
                  next_state=s3;
                   ser_en=1'b0;
                   mux_sel=2'b11;
                end
              else if(ser_done && ! par_en)
                begin
                  next_state=ideal;
                   ser_en=1'b0;
                   mux_sel=2'b00;
                end
              else
                begin
                  next_state=s2;
                   ser_en=1'b1;
                   mux_sel=2'b10;
                end
           end
        s3: begin
          if(data_valid)
            begin
              busy=1'b1;
              next_state=s1;
              ser_en=1'b1;
            end
          else
            begin
            busy=1'b1;
              next_state=ideal;
              ser_en=1'b0;  
            end 
          end
          endcase 
        end
endmodule
  
  
  
  
  
  
  
  
  
  
  
  
  
  
      