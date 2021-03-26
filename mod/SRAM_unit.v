//file name: SRAM_unit.v
//function : 
//author   : HateHanzo
module SRAM_unit(
        clk   , 
        wen   , 
        cen   , 
        addr  , 
        wdata , 
        rdata  
);

//parametr
parameter  DLY         = 1              ;
parameter  ADDR        = 9              ;
localparam DEPTH       = 1 << ADDR      ;

//input output
input                      clk    ;
input                      wen    ;
input                      cen    ;
input [ADDR-1:0]           addr   ;
input                      wdata  ;
output                     rdata  ;
//-----------------------------
//--signal
//-----------------------------
reg    mem[DEPTH-1:0]  ;
reg    rdata           ;


//-----------------------------
//--main circuit
//-----------------------------

//sram write
always@(posedge clk)
begin
  if( (!cen) && (!wen) )
    mem[addr] <= # DLY wdata ;
  else ;
end

//sram read
always@(posedge clk)
begin
  if( (!cen) && wen )
    rdata <= # DLY mem[addr] ;
  else ;
end


endmodule





