module stupid_NN(

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
// ***************
localparam WAIT_READY_ST    = 4'd0;
localparam READY_ST         = 4'd1;
localparam READ_WEIGHT_ST   = 4'd2;
localparam WAIT_WEIGHT_ST   = 4'd3;
localparam READ_PIX_ST      = 4'd4;
localparam WAIT_PIX_ST      = 4'd5;
localparam CALC_ST          = 4'd6;
localparam WRITE_NODE_ST    = 4'd7;
localparam IDLE_ST          = 4'd8;
localparam RESET_ST         = 4'd9;
localparam CONTINUE_ST      = 4'd10;
// ***************
localparam BASE_ADDR_WEIGHT = 32'hF1C492;
localparam BASE_ADDR_PIX = 32'h28292;
localparam BASE_ADDR_NODE = 32'h132A2;
// ***************
reg [31:0] address_weight = BASE_ADDR_WEIGHT;
reg [31:0] address_pix = BASE_ADDR_PIX;
reg [31:0] address_node = BASE_ADDR_NODE;
// ***************
reg [3:0] State = 0;
reg [10:0] count_pix = 0;
reg [8:0] count_node = 0;
// ***************
assign toHexLed = {{28{1'b0}}, State};
assign chipselect = 1;
assign byteenable = 2'b11;
// ***************
reg signed [31:0] sum = 0;
reg signed [15:0] weight = 0;
reg signed [15:0] pix = 0;
// ***************
reg [16:0]  Timer = 0;
localparam MAX_COUNT_TIMER          = 17'd100000;
// #################################################################################################################### State machine
always @(posedge clk) begin
  if (!reset_n || State == RESET_ST) begin State <= WAIT_READY_ST; end
  else begin
    case(State)
      WAIT_READY_ST:  begin State = (Timer > MAX_COUNT_TIMER)   ? READY_ST : WAIT_READY_ST; end
      READY_ST:       begin State = (ready)                     ? READ_WEIGHT_ST : WAIT_READY_ST; end
      // ***************
      READ_WEIGHT_ST: begin State = (!waitrequest)              ? WAIT_WEIGHT_ST : READ_WEIGHT_ST; end
      WAIT_WEIGHT_ST: begin State = (readdatavalid)             ? READ_PIX_ST : WAIT_WEIGHT_ST; end
      // ***************
      READ_PIX_ST:    begin State = (!waitrequest)              ? WAIT_PIX_ST : READ_PIX_ST; end
      WAIT_PIX_ST:    begin State = (readdatavalid)             ? CALC_ST : WAIT_PIX_ST; end
      // ***************
      CALC_ST:        begin State = (count_pix < 784)           ? READ_WEIGHT_ST : WRITE_NODE_ST; end
      WRITE_NODE_ST:  begin State = (!waitrequest)              ? CONTINUE_ST : WRITE_NODE_ST; end
      CONTINUE_ST:    begin State = (count_node < 200)          ? READ_WEIGHT_ST : IDLE_ST; end
      // ***************
      IDLE_ST:        begin State = (!ready) ? WAIT_READY_ST : IDLE_ST; end
      RESET_ST:       begin State <= WAIT_READY_ST; end
      default:        begin State <= IDLE_ST; end
    endcase
  end
end
// =================================================================================================================== Other Regs
                                                                                            // i think one reg didnt have an else stmt in orig
always @ (posedge clk) begin
    if (!reset_n || State == RESET_ST || State == IDLE_ST)  begin
        Timer <= 0;
    //  **************************
        address_weight  <= BASE_ADDR_WEIGHT;
        address_pix     <= BASE_ADDR_PIX;
        address_node    <= BASE_ADDR_NODE;
        // ***************
        count_pix       <= 0;
        count_node      <= 0;
        // ***************
        sum             <= 0;
        weight          <= 0;
        pix             <= 0;
    //  **************************
    end
    else begin
        Timer <= (State == WAIT_READY_ST) ? Timer + 17'd1 : 17'b0;
    //  **************************
        if      (State == IDLE_ST)                              begin address_weight <= BASE_ADDR_WEIGHT; end
        else if (State == WAIT_WEIGHT_ST && readdatavalid)      begin address_weight <= address_weight + 32'h2; end
        else                                                    begin address_weight <= address_weight; end
        // ***************
        if      (State == CONTINUE_ST)                          begin address_pix <= BASE_ADDR_PIX; end
        else if (State == WAIT_PIX_ST && readdatavalid)         begin address_pix <= address_pix + 32'h2; end
        else                                                    begin address_pix <= address_pix; end
        // ***************
        if      (State == IDLE_ST)                              begin address_node <= BASE_ADDR_NODE; end
        else if (State == WRITE_NODE_ST && !waitrequest)        begin address_node <= address_node + 32'h2; end
        else                                                    begin address_node <= address_node; end
        // ************************************************************
        // ************************************************************
        if      (State == WAIT_PIX_ST && readdatavalid) begin count_pix <= count_pix + 11'd1; end
        else if (State == WRITE_NODE_ST)                begin count_pix <= 0; end
        else                                            begin count_pix <= count_pix; end
        // ***************
        if      (State == IDLE_ST)                              begin count_node <= 0; end
        else if (State == WRITE_NODE_ST && !waitrequest)        begin count_node <= count_node + 9'd1; end
        else                                                    begin count_node <= count_node; end
        // ************************************************************
        // ************************************************************
        if        (State == CALC_ST && (pix[0] == 1'b1 || pix[8] == 1'b1)) begin sum <= sum + {{16{weight[15]}}, weight}; end // && pix[0] == 1
        else if   (State == CONTINUE_ST)            begin sum <= 0; end
        else                                        begin sum <= sum; end
        // ************************************************************
        weight  <= (State == WAIT_WEIGHT_ST && readdatavalid)   ? readdata : weight;
        pix     <= (State == WAIT_PIX_ST && readdatavalid)      ? readdata : pix; //{readdata[7:0],readdata[15:8]}
    end // else
end
// #################################################################################################################  Combinational Logic
always @ (*) begin
    done    = (State == IDLE_ST)                                     ? 1'b1 : 1'b0;
    read_n  = (State == READ_WEIGHT_ST || State == READ_PIX_ST)      ? 1'b0 : 1'b1;
    write_n = (State == WRITE_NODE_ST)                               ? 1'b0 : 1'b1;
    // **************************
    if        (State == READ_WEIGHT_ST || State == WAIT_WEIGHT_ST)   begin address = address_weight; end
    else if   (State == READ_PIX_ST || State == WAIT_PIX_ST)         begin address = address_pix; end
    else                                                             begin address = address_node; end
    // ***************
    writedata = sum[15:0]; //{sum[7:0],sum[15:8]}
end
endmodule
