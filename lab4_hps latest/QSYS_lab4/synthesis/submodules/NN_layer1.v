module NN_layer1(

input clk,
input reset_n,
input waitrequest,
input ready,
input readdatavalid,
input [15:0] readdata,

output [31:0] toHexLed,
output chipselect,
output [1:0] byteenable,
output reg done,
output reg read_n,
output reg write_n,

output reg [15:0] writedata,
output reg [31:0] address
);

localparam BASE_ADDR_READ   = 32'h0;
localparam BASE_ADDR_WRITE  = 32'h190;
localparam MAX_COUNT_TIMER          = 17'd100000;
//localparam MAX_COUNT_TIMER          = 2'b11;
localparam WAIT_READY_ST = 0;
localparam READY_ST = 1;
localparam RESET_ST = 2;
localparam IDLE_ST = 3;
localparam READ_SDRAM_ST = 4;
localparam WAIT_READ_ST = 5;
localparam WRITE_NODES_ST  = 6;

reg [31:0]  address_read = BASE_ADDR_READ;
reg [31:0]  address_write = BASE_ADDR_WRITE;
reg [16:0]  Timer = 0;
reg [3:0] State = WAIT_READY_ST;

reg [13:0] read_count = 0;
reg [13:0] count_write = 0;

reg [7:0] wren =  8'b00000011;
wire wren_a1, wren_a2, wren_a3, wren_a4;
wire wren_b1, wren_b2, wren_b3, wren_b4;
assign wren_b1 = 0;
assign wren_b2 = 0;
assign wren_b3 = 0;
assign wren_b4 = 0;
//assign wren_a1 = wren[1];
//assign wren_a2 = wren[3];
//assign wren_a3 = wren[5];
//assign wren_a4 = wren[7];
assign wren_a1 = (State == WAIT_READ_ST && readdatavalid) ? 1 : 0;
assign wren_a2 = 0;
assign wren_a3 = 0;
assign wren_a4 = 0;

wire [15:0] q_a1, q_a2, q_a3, q_a4, q_b1, q_b2, q_b3, q_b4;

reg [13:0] address_weights = 13'b0;
wire [13:0] address_ram;
wire [15:0] data_a1, data_a2, data_a3, data_a4;
assign data_a1 = readdata;
assign data_a2 = (State == WAIT_READ_ST && readdatavalid) ? readdata: 3'b101;
assign data_a3 = (State == WAIT_READ_ST && readdatavalid) ? readdata: 3'b101;
assign data_a4 = (State == WAIT_READ_ST && readdatavalid) ? readdata: 3'b101;

wire address_choose;
assign address_choose = (wren[0] ^ wren[1]) | (wren[2] ^ wren[3]) | (wren[4] ^ wren[5]) | (wren[6] ^ wren[7]);
wire ram_last;
assign ram_last = wren[7] && wren[0];
assign address_ram = address_weights;

assign chipselect = 1'b1;
assign byteenable = 2'b11;
assign toHexLed = {{8{1'b0}}, State, waitrequest, readdatavalid,read_count};
mem_on_chip on_chip_weights1(.data_a(data_a1), .data_b(data_a1), .address_a(address_ram), .address_b(address_ram), .wren_a(wren_a1), .wren_b(wren_b1), .q_a(q_a1), .q_b(q_b1), .clock(clk));
mem_on_chip on_chip_weights2(.data_a(data_a2), .data_b(data_a2), .address_a(address_ram), .address_b(address_ram), .wren_a(wren_a2), .wren_b(wren_b2), .q_a(q_a2), .q_b(q_b2), .clock(clk));
mem_on_chip on_chip_weights3(.data_a(data_a3), .data_b(data_a3), .address_a(address_ram), .address_b(address_ram), .wren_a(wren_a3), .wren_b(wren_b3), .q_a(q_a3), .q_b(q_b3), .clock(clk));
mem_on_chip on_chip_weights4(.data_a(data_a4), .data_b(data_a4), .address_a(address_ram), .address_b(address_ram), .wren_a(wren_a4), .wren_b(wren_b4), .q_a(q_a4), .q_b(q_b4), .clock(clk));

//on_chip_pixels on_chip_pixels(.data_a(data_a_pixels), .data_b(data_b_pixels), .address_a(address_a_pixels), .address_b(address_b_pixels), .wren_a(wren_a_pixels), .wren_b(wren_b_pixels), .q_a(q_a_pixels), .q_b(q_b_pixels), .clock(clk));

//on_chip_nodes on_chip_nodes(.data(data_nodes), .address(address_nodes), .wren(wren_nodes), .q(q_nodes), .clock(clk));

//reg_16 reg_16(.clock(clk), .reset(reset_reg), .a(weights_add), .b(weights_out));

always @(posedge clk) begin
	if(!reset_n || State == RESET_ST) begin
//        if(weigts_read == 1'b1) begin
//            State <= READ_PIXELS_ST;
//        end else begin
            State <= WAIT_READY_ST;
//        end
	end else begin
		case (State)
			WAIT_READY_ST: begin
				if(Timer > MAX_COUNT_TIMER) begin
				 	State <= READY_ST;
				end else begin
					State <= WAIT_READY_ST;
				end
			end
			READY_ST: begin
				if(ready) begin
					State <= READ_SDRAM_ST;
				end else begin
					State <= WAIT_READY_ST;
				end
			end
			IDLE_ST: begin
                if(ready) begin
                    State <= RESET_ST;
                end else begin
    				State <= IDLE_ST;
                end
			end
			READ_SDRAM_ST: begin
				if(!waitrequest) begin
					State <= WAIT_READ_ST;
				end else begin
					State <= READ_SDRAM_ST;
				end
			end
			WAIT_READ_ST: begin
				if(readdatavalid && read_count < 'h188) begin //14'b100110010001111110
					State <= READ_SDRAM_ST;
				end else if (readdatavalid && read_count == 'h188) begin
					State <= WRITE_NODES_ST;
				end else begin
					State <= WAIT_READ_ST;
				end
			end
            WRITE_NODES_ST: begin
                if(!waitrequest && count_write < 199) begin
                    State <= WRITE_NODES_ST;
                end else if (!waitrequest && count_write == 199) begin
                    State <= IDLE_ST;
                end
            end
			default: begin
				State <= RESET_ST;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (!reset_n || State == RESET_ST)  begin
				Timer <= 0;
		//  **************************
				address_read    <= BASE_ADDR_READ;
				address_write   <= BASE_ADDR_WRITE;
				address_weights <= 14'b0;
		//  **************************
				read_count      <= 0;
                count_write <= 0;
				wren <= 8'b00000011;
	end
	else begin
				Timer           <= (State == WAIT_READY_ST) ? Timer + 17'd1 : 0;
		//  **************************
				address_read    <= (State == WAIT_READ_ST && readdatavalid)     ? address_read + 32'h2 : address_read;
				address_write   <= (State == WRITE_NODES_ST && !waitrequest)   ? address_write + 32'h2 : address_write;
				if (State == WAIT_READ_ST && readdatavalid) begin
					address_weights <= address_weights + 1;
				end else if (State == WRITE_NODES_ST && count_write == 0) begin
                    address_weights <= 0;
                end else if (State == WRITE_NODES_ST && !waitrequest) begin
                    address_weights <= address_weights + 1;
                end
		//  **************************
				read_count      <= (State == WAIT_READ_ST && readdatavalid) ? read_count + 18'd1 : read_count;
                count_write <= (State == WRITE_NODES_ST && !waitrequest) ? count_write + 1'b1 : count_write;
				wren <= (State == WAIT_READ_ST && readdatavalid) ? {wren[6:0], wren[7]} : wren;

	end // else
end// always clk

always @ (*) begin
    done    = (State == IDLE_ST)            ? 1'b1 : 0;
    read_n  = (State == READ_SDRAM_ST)      ? 0 : 1'b1;
    write_n = (State == WRITE_NODES_ST)    ? 0 : 1'b1;
//  **************************
    address = (State == WRITE_NODES_ST) ? address_write : address_read;
    writedata = q_a1;
end

endmodule
