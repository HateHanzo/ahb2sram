module ahb_master(
    hclk       ,
    rst_n      ,
    ahb_readyi ,
    ahb_rdata  ,
    
    ahb_write  ,
    ahb_addr   ,
    ahb_wdata  ,
    ahb_trans  ,
    ahb_size   ,
    ahb_burst
);

//parameter
parameter DLY    = 1      ;
parameter SINGLE = 3'b000 ;
parameter INCR4  = 3'b011 ;
parameter INCR8  = 3'b101 ;
parameter WORD   = 3'b010 ;
parameter HALF   = 3'b001 ;
parameter BYTE   = 3'b000 ;
parameter NONSEQ = 2'b10  ;
parameter SEQ    = 2'b11  ;
parameter IDLE   = 2'b00  ;


//input output
input          hclk       ;
input          rst_n      ;
input          ahb_readyi ;
input   [31:0] ahb_rdata  ;

output          ahb_write  ;
output   [31:0] ahb_addr   ;
output   [31:0] ahb_wdata  ;
output   [1 :0] ahb_trans  ;
output   [2 :0] ahb_size   ;
output   [2 :0] ahb_burst  ;

reg          ahb_write  ;
reg   [31:0] ahb_addr   ;
reg   [31:0] ahb_wdata  ;
reg   [1 :0] tmp_trans  ;
reg   [2 :0] ahb_size   ;
reg   [2 :0] ahb_burst  ;


initial begin
    ahb_addr  = 32'h0  ;
    ahb_write = 1'b0   ;
    tmp_trans = IDLE   ;
    ahb_size  = BYTE   ;
    ahb_burst = SINGLE ;
    ahb_wdata = 32'h0  ;
end

wire ahb_trans = rst_n ? tmp_trans : 2'b00 ;
    
task IOW(input [31:0] addr, input [31:0] wdata);
begin
    @(negedge hclk)
    wait(ahb_readyi)
    @(posedge hclk)
        begin
            #1;
            ahb_addr  = addr   ;
            ahb_write = 1'b1   ;
            tmp_trans = NONSEQ ;
            ahb_size  = WORD   ;
            ahb_burst = SINGLE ;
        end
    
    @(negedge hclk)
    wait(ahb_readyi)
    @(posedge hclk)
        begin
            #1;
            ahb_addr  = 32'h0  ;
            ahb_write = 1'b0   ;
            tmp_trans = IDLE   ;
            ahb_size  = BYTE   ;
            ahb_wdata = wdata  ;
        end
    
    @(negedge hclk)
    wait(ahb_readyi)
    @(posedge hclk)
        begin
            #1;
            ahb_wdata = 32'h0  ;
            $display("write add = %h,wdata = %h",addr,wdata);
        end
end
endtask

task IOR(input [31:0] addr, output [31:0] rdata);
begin
    @(negedge hclk)
    wait(ahb_readyi)
    @(posedge hclk)
        begin
            #1;
            ahb_addr  = addr   ;
            ahb_write = 1'b0   ;
            tmp_trans = NONSEQ ;
            ahb_size  = WORD   ;
            ahb_burst = SINGLE ;
        end
    
    @(negedge hclk)
    wait(ahb_readyi)
    @(posedge hclk)
        begin
            #1;
            ahb_addr  = addr   ;
            ahb_write = 1'b0   ;
            tmp_trans = IDLE   ;
            ahb_size  = BYTE   ;
        end
    
    @(negedge hclk)
    wait(ahb_readyi)
    @(posedge hclk)
        begin
            #1;
            rdata = ahb_rdata  ;
            $display("read add = %h,rdata = %h",addr,ahb_rdata);
        end
end
endtask





endmodule
