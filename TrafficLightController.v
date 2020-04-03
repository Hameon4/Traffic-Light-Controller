`timescale 1ns / 1ps


module traffic_lights(

    input clk,
    input reset,
    input [7:0] emg_sensor,
    output reg [1:0] Street1,
    output reg [1:0] Street2,
    output reg [1:0] Street3,
    output reg [1:0] Street4
    );

    reg [7:0] state;

    parameter
    s0 = 8'b00000001,
    s1 = 8'b00000010,
    s2 = 8'b00000100,
    s3 = 8'b00001000;


    always @(posedge clk or posedge reset)
    if(reset == 1) begin
    state <= s0; end

    else begin
    case(state)


	//normal traffic
    s0: if(emg_sensor == 8'b00000000) begin
        state <= s1; end

	//emergency priority
        else if(emg_sensor [3:0] == 4'b0100) begin
        state <= s1; end

        else if(emg_sensor [3:0] == 4'b1000) begin
        state <= s0; end

        else if(emg_sensor [3:0] == 4'b0010) begin
        state <= s2; end

         else if (emg_sensor [3:0] == 4'b0001) begin
         state <= s3; end


        //state s0 to s0
        else if(emg_sensor == 8'b01000000) begin
        state <= s0; end

        //state s0 to s1
        else if (emg_sensor == 8'b10000000) begin
        state <= s1; end

        //state s0 to s2
        else if( emg_sensor == 8'b00010000) begin
        state <= s2; end

        //state s0 to s3
        else if (emg_sensor == 8'b00100000) begin
        state <= s3; end


        //normal traffic
    s1:  if(emg_sensor == 8'b00000000) begin
        state <= s2; end

	//emergency priority
         else if(emg_sensor [3:0] == 4'b0100) begin
         state <= s1; end

         else if (emg_sensor [3:0] == 4'b1000) begin
         state <= s0;  end

        else if (emg_sensor [3:0] == 4'b0010) begin
        state <= s2; end

        else if(emg_sensor [3:0] == 4'b0001) begin
        state <= s3; end


        //state s1 to s1
        else if(emg_sensor == 8'b10000000) begin
        state <= s1; end

        //state s1 to s0
        else if (emg_sensor == 8'b01000000) begin
        state <= s0; end

        //state s1 to s2
        else if (emg_sensor == 8'b00010000) begin
        state <= s2; end

        //state s1 to s3
        else if (emg_sensor == 8'b00100000) begin
        state <= s3; end


           //normal traffic
    s2:    if(emg_sensor == 8'b00000000) begin
            state <= s3; end

    	   //emergency priority
           else if(emg_sensor [3:0] == 4'b0010) begin
           state <= s2; end

           else if (emg_sensor [3:0] == 4'b1000) begin
           state <= s0; end

           else if(emg_sensor [3:0] == 4'b0100) begin
           state <= s1; end

           else if(emg_sensor [3:0] == 4'b0001) begin
           state <= s3; end

            //state s2 to s2
            else if(emg_sensor == 8'b00010000) begin
            state <= s2; end

            //state s2 to s0
            else if (emg_sensor == 8'b01000000) begin
            state <= s0; end

            //state s2 to s1
            else if (emg_sensor == 8'b10000000) begin
            state <= s1; end

            //state s2 to s3
            else if (emg_sensor == 8'b00100000) begin
            state <= s3; end



            //normal traffic
       s3:  if(emg_sensor == 8'b00000000) begin
            state <= s0; end

	    //emergency priority
            else if(emg_sensor [3:0] == 4'b0001) begin
            state <= s3; end

            else if (emg_sensor [3:0] == 4'b1000) begin
            state <= s0; end

            else if (emg_sensor [3:0] == 4'b0010) begin
            state <= s2; end

            else if (emg_sensor [3:0] == 4'b0100) begin
            state <= s1; end


            //state s3 to s0
            else if (emg_sensor == 8'b01000000) begin
            state <= s0; end

            //state s3 to s1
            else if (emg_sensor == 8'b10000000) begin
            state <= s1; end

            //state s3 to s2
            else if (emg_sensor == 8'b00010000) begin
            state <= s2; end

            //state s3 to s3
            else if (emg_sensor == 8'b00100000) begin
            state <= s3; end


    endcase
    end

    always @ *
    begin
        case(state) //11 = green, 00 = red
        s0: begin Street1 <= 8'b11; Street2 <= 6'b00; Street3 <= 4'b00; Street4 <= 2'b00; end
        s1: begin Street1 <= 8'b00; Street2 <= 6'b11; Street3 <= 4'b00; Street4 <= 2'b00; end
        s2: begin Street1 <= 8'b00; Street2 <= 6'b00; Street3 <= 4'b11; Street4 <= 2'b00; end
        s3: begin Street1 <= 8'b00; Street2 <= 6'b00; Street3 <= 4'b00; Street4 <= 2'b11; end
        endcase
        end
endmodule


////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps


module traffic_lights_tb();

    reg clk, reset;
    reg [7:0] emg_sensor;
    wire [1:0] Street1, Street2, Street3, Street4;

    traffic_lights uut(

        .clk(clk),
        .reset(reset),
        .emg_sensor(emg_sensor),
        .Street1(Street1),
        .Street2(Street2),
        .Street3(Street3),
        .Street4(Street4)
        );

        initial
            begin
                    clk = 0;
                    reset = 1;
                #1  reset = 0;


	        emg_sensor = 8'b00000000;
                #3  clk = 1;
                #1  clk = 0;

                emg_sensor = 8'b00000000;
                #1  clk = 1;
                #1  clk = 0;

                emg_sensor = 8'b00001000;
                #1  clk = 1;
                #1  clk = 0;

                emg_sensor = 8'b00000000;
                #1  clk = 1;
                #1  clk = 0;

                emg_sensor = 8'b01000000;
                #10  clk = 1;
                #1  clk = 0;


            #10 $stop;
            end
endmodule
