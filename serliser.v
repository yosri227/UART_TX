module serliser // FOR  TRANSFORMING DATA FROM PARALLEL TO SERIAL 

// PORTS I/O DECLARATION
(
input              clk,
input              rest,
input              data_valid,
input        [7:0] p_data,
input              ser_en,
output   reg       ser_done,
output   reg       ser_data
);

// internal signals 
reg  [3:0] counter;
reg [3:0]i;
reg [7:0] cap_data;
wire check;

// ASIGN STATMENTS
assign check=(counter==4'b1000)?1'b1:1'b0; 

// SEQUENTIAL ALWAYS 
always @(posedge clk or negedge rest)
begin
  if(!rest)
    begin
      ser_done<=1'b0;
      ser_data<=1'b0;
      cap_data<=8'b0;
      counter<='b0;
      i<=1'b0;
    end
    else if(data_valid)
      begin
        cap_data<= p_data;
      end
    else if(!check && ser_en)
      begin
        ser_done<=1'b0;
        counter<=counter+1'b1;
        ser_data<=cap_data[i];
        i<=i+1'b1;
      end
    else 
      begin
         counter<='b0;
         ser_done<=1'b1;
         ser_data<=ser_data;
         i<=1'b0;
       
      end
end

endmodule 
