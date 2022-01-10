module Digital_Clock(

    input clk,

    input time_set,

    input inc_hr,

    input inc_min,

    input rst,

    output reg [6:0] outsegh1,outsegh2,

    output reg [6:0] outsegm1,outsegm2,

    output reg [6:0] outsegs1,outsegs2

    );

  

parameter zero=0;

parameter one=1;  

reg [26:0]cnt=0;

reg clk_1hz=0;

reg [5:0] outh,outm,outs;

reg [3:0] hr1,hr2,min1,min2,sec1,sec2;

 

always@(posedge clk)

begin

    if(cnt==24999999)

    begin

        clk_1hz<=~clk_1hz;

        cnt<=zero;

    end

   else  

    cnt<=cnt+1;

end

 

 

always@(posedge clk_1hz,posedge rst)

begin

    if(rst==1)

    begin

        outh<=zero;

        outm<=zero;

        outs<=zero;

    end

  

else

begin

    if(time_set==0)

    begin

            if(outs!=6'd59)

            begin

                outs<=outs+1;

            end

          

            if(outs==6'd59)

            begin

                outs<=zero;

                outm<=outm+1;

            end

          

            if(outm==6'd59)

            begin

                outm<=zero;

                outh<=outh+1;

            end

 

            if(outh==6'd23)

            outh<=zero;

    end

  

   else if(time_set==1)

    begin

            if(inc_hr==1)

            begin

                if(outh==6'd23)

                outh<=zero;

                else

                outh<=outh+1;

            end

 

            if(inc_min==1)

            begin

                if(outm==6'd59)

                outm<=zero;

                else

                outm<=outm+1;

         end

     end

  end

end

 

always@(posedge clk)

begin

    bcd1 (outh,hr2,hr1);

    bcd27seg1 (hr1,outsegh1);

    bcd27seg2 (hr2,outsegh2);

end

 

 

always@(posedge clk)

begin

    bcd2 (outm,min2,min1);

    bcd27seg3 (min1,outsegm1);

    bcd27seg4 (min2,outsegm2);

end

 

 

always@(posedge clk)

begin

    bcd3 (outs,sec2,sec1);

    bcd27seg5 (sec1,outsegs1);

    bcd27seg6 (sec2,outsegs2);

end

 

 

task bcd1;

input [5:0] bin;

output [3:0] bcd1;

output [3:0] bcd0;

 

 

  case (bin)

     6'd0 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0000; end

     6'd1 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0001; end

     6'd2 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0010; end

     6'd3 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0011; end

     6'd4 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0100; end

     6'd5 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0101; end

     6'd6 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0110; end

     6'd7 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0111; end

     6'd8 : begin bcd1 <= 4'b0000; bcd0 <= 4'b1000; end

     6'd9 : begin bcd1 <= 4'b0000; bcd0 <= 4'b1001; end

    6'd10 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0000; end

    6'd11 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0001; end

    6'd12 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0010; end

    6'd13 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0011; end

    6'd14 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0100; end

    6'd15 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0101; end

    6'd16 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0110; end

    6'd17 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0111; end

    6'd18 : begin bcd1 <= 4'b0001; bcd0 <= 4'b1000; end

    6'd19 : begin bcd1 <= 4'b0001; bcd0 <= 4'b1001; end

    6'd20 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0000; end

    6'd21 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0001; end

    6'd22 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0010; end

    6'd23 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0011; end

    6'd24 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0100; end

    6'd25 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0101; end

    6'd26 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0110; end

    6'd27 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0111; end

    6'd28 : begin bcd1 <= 4'b0010; bcd0 <= 4'b1000; end

    6'd29 : begin bcd1 <= 4'b0010; bcd0 <= 4'b1001; end

    6'd30 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0000; end

    6'd31 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0001; end

    6'd32 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0010; end

    6'd33 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0011; end

    6'd34 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0100; end

    6'd35 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0101; end

    6'd36 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0110; end

    6'd37 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0111; end

    6'd38 : begin bcd1 <= 4'b0011; bcd0 <= 4'b1000; end

    6'd39 : begin bcd1 <= 4'b0011; bcd0 <= 4'b1001; end

    6'd40 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0000; end

    6'd41 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0001; end

    6'd42 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0010; end

    6'd43 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0011; end

    6'd44 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0100; end

    6'd45 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0101; end

    6'd46 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0110; end

    6'd47 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0111; end

    6'd48 : begin bcd1 <= 4'b0100; bcd0 <= 4'b1000; end

    6'd49 : begin bcd1 <= 4'b0100; bcd0 <= 4'b1001; end

    6'd50 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0000; end

    6'd51 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0001; end

    6'd52 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0010; end

    6'd53 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0011; end

    6'd54 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0100; end

    6'd55 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0101; end

    6'd56 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0110; end

    6'd57 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0111; end

    6'd58 : begin bcd1 <= 4'b0101; bcd0 <= 4'b1000; end

    6'd59 : begin bcd1 <= 4'b0101; bcd0 <= 4'b1001; end

    6'd60 : begin bcd1 <= 4'b0110; bcd0 <= 4'b0000; end

  

    endcase

 

  endtask

 

 

  task bcd27seg1;

  input [3:0] bcd;

  output [6:0] seg7;

 

      case(bcd)

          
          5'h00: seg7 <= 7'b1000000;

        5'h01: seg7 <= 7'b1111001;  

        5'h02: seg7 <= 7'b0100100;  

        5'h03: seg7 <= 7'b0110000;   

        5'h04: seg7 <= 7'b0011001;

        5'h05: seg7 <= 7'b0010010; 

        5'h06: seg7 <= 7'b0000010;   

        5'h07: seg7 <= 7'b1111000;  

        5'h08: seg7 <= 7'b00000000;

        5'h09: seg7 <= 7'b0010000; 
      

      endcase

    endtask

  

  

  task bcd27seg2;

  input [3:0] bcd;

  output [6:0] seg7;

 

      case(bcd)

          
          5'h00: seg7 <= 7'b1000000;

        5'h01: seg7 <= 7'b1111001;  

        5'h02: seg7 <= 7'b0100100;  

        5'h03: seg7 <= 7'b0110000;   

        5'h04: seg7 <= 7'b0011001;

        5'h05: seg7 <= 7'b0010010; 

        5'h06: seg7 <= 7'b0000010;   

        5'h07: seg7 <= 7'b1111000;  

        5'h08: seg7 <= 7'b00000000;

        5'h09: seg7 <= 7'b0010000;   

      

      endcase

    endtask

 

task bcd2;

input [5:0] bin;

output [3:0] bcd1;

output [3:0] bcd0;

case (bin)
     6'd0 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0000; end
     6'd1 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0001; end
     6'd2 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0010; end
     6'd3 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0011; end
     6'd4 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0100; end
     6'd5 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0101; end
     6'd6 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0110; end
     6'd7 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0111; end
     6'd8 : begin bcd1 <= 4'b0000; bcd0 <= 4'b1000; end
     6'd9 : begin bcd1 <= 4'b0000; bcd0 <= 4'b1001; end
    6'd10 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0000; end
    6'd11 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0001; end
    6'd12 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0010; end
    6'd13 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0011; end
    6'd14 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0100; end
    6'd15 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0101; end
    6'd16 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0110; end
    6'd17 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0111; end
    6'd18 : begin bcd1 <= 4'b0001; bcd0 <= 4'b1000; end
    6'd19 : begin bcd1 <= 4'b0001; bcd0 <= 4'b1001; end
    6'd20 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0000; end
    6'd21 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0001; end
    6'd22 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0010; end
    6'd23 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0011; end
    6'd24 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0100; end
    6'd25 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0101; end
    6'd26 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0110; end
    6'd27 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0111; end
    6'd28 : begin bcd1 <= 4'b0010; bcd0 <= 4'b1000; end
    6'd29 : begin bcd1 <= 4'b0010; bcd0 <= 4'b1001; end
    6'd30 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0000; end
    6'd31 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0001; end
    6'd32 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0010; end
    6'd33 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0011; end
    6'd34 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0100; end
    6'd35 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0101; end
    6'd36 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0110; end
    6'd37 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0111; end
    6'd38 : begin bcd1 <= 4'b0011; bcd0 <= 4'b1000; end
    6'd39 : begin bcd1 <= 4'b0011; bcd0 <= 4'b1001; end
    6'd40 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0000; end
    6'd41 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0001; end
    6'd42 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0010; end
    6'd43 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0011; end
    6'd44 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0100; end
    6'd45 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0101; end
    6'd46 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0110; end
    6'd47 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0111; end
    6'd48 : begin bcd1 <= 4'b0100; bcd0 <= 4'b1000; end
    6'd49 : begin bcd1 <= 4'b0100; bcd0 <= 4'b1001; end
    6'd50 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0000; end
    6'd51 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0001; end
    6'd52 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0010; end
    6'd53 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0011; end
    6'd54 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0100; end
    6'd55 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0101; end
    6'd56 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0110; end
    6'd57 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0111; end
    6'd58 : begin bcd1 <= 4'b0101; bcd0 <= 4'b1000; end
    6'd59 : begin bcd1 <= 4'b0101; bcd0 <= 4'b1001; end
    6'd60 : begin bcd1 <= 4'b0110; bcd0 <= 4'b0000; end
   
    endcase
endtask
 
 
  task bcd27seg3;
  input [3:0] bcd;
  output [6:0] seg7;
 
      case(bcd)
          
          5'h00: seg7 <= 7'b1000000;

        5'h01: seg7 <= 7'b1111001;  

        5'h02: seg7 <= 7'b0100100;  

        5'h03: seg7 <= 7'b0110000;   

        5'h04: seg7 <= 7'b0011001;

        5'h05: seg7 <= 7'b0010010; 

        5'h06: seg7 <= 7'b0000010;   

        5'h07: seg7 <= 7'b1111000;  

        5'h08: seg7 <= 7'b00000000;

        5'h09: seg7 <= 7'b0010000;   
       
      endcase
    endtask
   
   
  task bcd27seg4;
  input [3:0] bcd;
  output [6:0] seg7;
 
      case(bcd)
          5'h00: seg7 <= 7'b1000000;

        5'h01: seg7 <= 7'b1111001;  

        5'h02: seg7 <= 7'b0100100;  

        5'h03: seg7 <= 7'b0110000;   

        5'h04: seg7 <= 7'b0011001;

        5'h05: seg7 <= 7'b0010010; 

        5'h06: seg7 <= 7'b0000010;   

        5'h07: seg7 <= 7'b1111000;  

        5'h08: seg7 <= 7'b00000000;

        5'h09: seg7 <= 7'b0010000; 
       
      endcase
    endtask
   
   
task bcd3;
input [5:0] bin;
output [3:0] bcd1;
output [3:0] bcd0;
 
  case (bin)
     6'd0 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0000; end
     6'd1 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0001; end
     6'd2 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0010; end
     6'd3 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0011; end
     6'd4 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0100; end
     6'd5 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0101; end
     6'd6 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0110; end
     6'd7 : begin bcd1 <= 4'b0000; bcd0 <= 4'b0111; end
     6'd8 : begin bcd1 <= 4'b0000; bcd0 <= 4'b1000; end
     6'd9 : begin bcd1 <= 4'b0000; bcd0 <= 4'b1001; end
    6'd10 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0000; end
    6'd11 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0001; end
    6'd12 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0010; end
    6'd13 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0011; end
    6'd14 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0100; end
    6'd15 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0101; end
    6'd16 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0110; end
    6'd17 : begin bcd1 <= 4'b0001; bcd0 <= 4'b0111; end
    6'd18 : begin bcd1 <= 4'b0001; bcd0 <= 4'b1000; end
    6'd19 : begin bcd1 <= 4'b0001; bcd0 <= 4'b1001; end
    6'd20 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0000; end
    6'd21 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0001; end
    6'd22 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0010; end
    6'd23 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0011; end
    6'd24 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0100; end
    6'd25 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0101; end
    6'd26 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0110; end
    6'd27 : begin bcd1 <= 4'b0010; bcd0 <= 4'b0111; end
    6'd28 : begin bcd1 <= 4'b0010; bcd0 <= 4'b1000; end
    6'd29 : begin bcd1 <= 4'b0010; bcd0 <= 4'b1001; end
    6'd30 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0000; end
    6'd31 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0001; end
    6'd32 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0010; end
    6'd33 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0011; end
    6'd34 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0100; end
    6'd35 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0101; end
    6'd36 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0110; end
    6'd37 : begin bcd1 <= 4'b0011; bcd0 <= 4'b0111; end
    6'd38 : begin bcd1 <= 4'b0011; bcd0 <= 4'b1000; end
    6'd39 : begin bcd1 <= 4'b0011; bcd0 <= 4'b1001; end
    6'd40 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0000; end
    6'd41 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0001; end
    6'd42 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0010; end
    6'd43 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0011; end
    6'd44 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0100; end
    6'd45 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0101; end
    6'd46 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0110; end
    6'd47 : begin bcd1 <= 4'b0100; bcd0 <= 4'b0111; end
    6'd48 : begin bcd1 <= 4'b0100; bcd0 <= 4'b1000; end
    6'd49 : begin bcd1 <= 4'b0100; bcd0 <= 4'b1001; end
    6'd50 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0000; end
    6'd51 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0001; end
    6'd52 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0010; end
    6'd53 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0011; end
    6'd54 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0100; end
    6'd55 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0101; end
    6'd56 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0110; end
    6'd57 : begin bcd1 <= 4'b0101; bcd0 <= 4'b0111; end
    6'd58 : begin bcd1 <= 4'b0101; bcd0 <= 4'b1000; end
    6'd59 : begin bcd1 <= 4'b0101; bcd0 <= 4'b1001; end
    6'd60 : begin bcd1 <= 4'b0110; bcd0 <= 4'b0000; end
   
    endcase
 
  endtask
 
  task bcd27seg5;
  input [3:0] bcd;
  output [6:0] seg7;
 
      case(bcd)
         
          5'h00: seg7 <= 7'b1000000;

        5'h01: seg7 <= 7'b1111001;  

        5'h02: seg7 <= 7'b0100100;  

        5'h03: seg7 <= 7'b0110000;   

        5'h04: seg7 <= 7'b0011001;

        5'h05: seg7 <= 7'b0010010; 

        5'h06: seg7 <= 7'b0000010;   

        5'h07: seg7 <= 7'b1111000;  

        5'h08: seg7 <= 7'b00000000;

        5'h09: seg7 <= 7'b0010000;  
        endcase
    endtask
   
  task bcd27seg6;
  input [3:0] bcd;
  output [6:0] seg7;
 
      case(bcd)
          
          5'h00: seg7 <= 7'b1000000;

        5'h01: seg7 <= 7'b1111001;  

        5'h02: seg7 <= 7'b0100100;  

        5'h03: seg7 <= 7'b0110000;   

        5'h04: seg7 <= 7'b0011001;

        5'h05: seg7 <= 7'b0010010; 

        5'h06: seg7 <= 7'b0000010;   

        5'h07: seg7 <= 7'b1111000;  

        5'h08: seg7 <= 7'b00000000;

        5'h09: seg7 <= 7'b0010000; 
     
      endcase
    endtask
 
endmodule