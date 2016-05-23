module sdram_master_lab4(
input       clk,
input       reset_n,
input       waitrequest,
input       ready,
input       readdatavalid,
input       [15:0]  readdata,
output      [31:0] toHexLed,                   // outputs readdata
// #############################
output reg  chipselect,                       // always 1
output reg  [1:0]   byteenable,               // always 'b11
output reg  done,                             // 0 or 1
output reg  read_n,                           // 0 or 1
output reg  write_n,                          // 0 or 1
output reg  [15:0] writedata,                 // writes result 2 pixs at a time
output reg  [31:0] address = 0
);
// #################################### STATES
localparam WAIT_ST  = 0; 
localparam READY_ST = 1; 
localparam RESET_ST = 2; 
localparam IDLE_ST  = 3; 
//  ###########
localparam READ_INITIAL_ST  = 4; 
localparam READ_2NUMS_ST  = 5; 
localparam SHIFT_ST = 6;
localparam WRITE_RESULT_ST = 7;
localparam CONTINUE_ST = 8;
// #################################### BASE_ADDRS
localparam BASE_ADDR_READ  = 32'h0;  
localparam BASE_ADDR_WRITE = 32'h40_000;  
// ####################################  MAXS
localparam MAX_COUNT_TIMER = 'd99_999;
localparam MAX_COUNT_INITIAL_READ = 'd513;     // (512*2 +4)/2- 1 = 16 bit numbers in a row     
localparam MAX_COUNT_IMAGE_WHOLE = 'd131071;//20_000;     // (512x512) / 2  -1 = 16 bit numbers in whole image
// ###################################  ARRAY LIMITS
// ################################### VARIABLES
reg [4:0]   State = RESET_ST;
reg [4:0]   State_next = RESET_ST;
reg [16:0]  Timer = 0;
//  *************
reg [31:0]  address_read = BASE_ADDR_READ;
reg [31:0]  address_write = BASE_ADDR_WRITE;
reg  [31:0] address_next = 0;
reg [17:0]  Read_count = 0;
// ######################################## ARRAYS
reg [15:0] Buffer = 0;
reg [8223:0] Sdramframe = 0;
// ######################################## ASSIGN LOGIC
assign toHexLed = {{11{1'b1}}, State, Buffer};
// ######################################## SEQUENTIAL LOGIC
//  ############################## always update constant regs 
always @ (posedge clk) begin
    chipselect  <= 1'b1;
    byteenable  <= 2'b11;
end 
//  ############################## always update 1 bit signals
always @ (posedge clk) begin
    if (reset_n == 0 || State == RESET_ST) begin
        done        <= 0;
        read_n      <= 1'b1;
        write_n     <= 1'b1; 
    end 
    else begin
        done        <= (State == IDLE_ST) ? 1 : 0;
        read_n      <= (State == READ_INITIAL_ST || State == READ_2NUMS_ST) ? 0 : 1'b1;
        write_n     <= (State == WRITE_RESULT_ST) ? 0 : 1'b1; 
    end
end 
//  ############################## always update multiple bit signals w/o next regs
always @ (posedge clk) begin
    if (reset_n == 0 || State == RESET_ST) begin
        Timer       <= 0;
        writedata   <= 0;
        //  *************
        address_read <= BASE_ADDR_READ;
        address_write <= BASE_ADDR_WRITE;
        //  *************
        Read_count  <= 0;
        Buffer <= Buffer;
        Sdramframe <= 0;
    end 
    else begin
        Timer           <= (State == WAIT_ST) ? Timer + 17'd1 : 0;
        writedata       <= Sdramframe[8223:8208]; 
        //  *************
        address <= address_next;
        address_read    <= ((State == READ_INITIAL_ST || State == READ_2NUMS_ST) && (waitrequest == 0)) ? address_read + 'h2 : address_read;
        address_write   <= ((State == WRITE_RESULT_ST) && (waitrequest == 0))                             ? address_write + 'h2 : address_write;
        //  *************        
        Read_count  <= ((State == READ_INITIAL_ST|| State == READ_2NUMS_ST) && (waitrequest == 0))                           ? Read_count + 'd1: Read_count;
        Buffer      <= ((( State == READ_INITIAL_ST)|| State == READ_2NUMS_ST) && (Read_count < MAX_COUNT_IMAGE_WHOLE) && (readdatavalid)) ? readdata : Buffer; // && (Read_count < MAX_COUNT_INITIAL_READ + 1)
        Sdramframe  <= ((( State == READ_INITIAL_ST)|| State == READ_2NUMS_ST) && (Read_count < MAX_COUNT_IMAGE_WHOLE) && (readdatavalid)) ? {Sdramframe[8207:0],Buffer} : Sdramframe;
    end
end 




//  ############################## # always update multiple bit signals w/ next reg
always @ (posedge clk) begin
    if (reset_n == 0 || State == RESET_ST)  begin        State       <= WAIT_ST;    end 
    else                                    begin        State       <= State_next; end
end 

// ################################################# COMBINATIONAL LOGIC
//  ############################## always update next state
always @ (*) begin
    case (State)
        WAIT_ST:    begin State_next = (Timer > MAX_COUNT_TIMER) ? READY_ST : WAIT_ST; end 
        READY_ST:   begin State_next = (ready) ? READ_INITIAL_ST : WAIT_ST; end
        IDLE_ST:    begin State_next = IDLE_ST; end
        RESET_ST:   begin State_next = WAIT_ST; end
        //  ###########
        READ_INITIAL_ST:    begin State_next = ((Read_count > MAX_COUNT_INITIAL_READ) && (waitrequest == 0)) ? SHIFT_ST : READ_INITIAL_ST; end
        READ_2NUMS_ST:      begin State_next = (waitrequest == 0) ? SHIFT_ST : READ_2NUMS_ST; end
        SHIFT_ST:           begin State_next = WRITE_RESULT_ST; end
        WRITE_RESULT_ST:    begin State_next = (waitrequest == 0) ? CONTINUE_ST : WRITE_RESULT_ST; end
        CONTINUE_ST:        begin State_next = (Read_count > MAX_COUNT_IMAGE_WHOLE) ? IDLE_ST : READ_2NUMS_ST; end
        default:            begin State_next = RESET_ST; end
    endcase
end 
//  ############################## always update addr
always @ (*) begin
    case (State)
        READ_INITIAL_ST:    begin address_next = address_read; end
        READ_2NUMS_ST:      begin address_next = address_read; end
        WRITE_RESULT_ST:    begin address_next = address_write; end
        default:            begin address_next = address; end
    endcase
end 
// ################################################## END
endmodule

