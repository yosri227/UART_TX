module parity  // FOR PARITY CALCULATION  

// PORTS I/O DECLARATION
(
input           clk,
input           rest,
input  [7:0]    p_data,
input           par_typ,
input           data_valid,
output reg      par_bit
);

// SEQUENTIAL ALWAYS 
always @(posedge clk or negedge rest)
begin
if (!rest)
  begin
 par_bit<=1'b0;
 end
else if (data_valid)
     begin
       if(par_typ)
         par_bit <= ~^ p_data;
       else
         par_bit<=^p_data;
     end
else
  begin
       if(par_typ)
         par_bit <= ~^ p_data;
       else
         par_bit<=^p_data;
     end
   end
   endmodule 