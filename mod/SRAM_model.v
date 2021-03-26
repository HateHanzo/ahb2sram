//file name: SRAM_model.v
//function : SRAM_model for stimulation
//author   : HateHanzo
module SRAM_model(
        clk   , 
        wen   , 
        cen   , 
        addr  , 
        wdata , 
        rdata 
);

//parametr
parameter DLY         = 1              ;
parameter ADDR        = 9              ;
parameter DEPTH       = 1 <<ADDR       ;

//input output
input                      clk    ;
input  [31:0]              wen    ;
input                      cen    ;
input  [ADDR-1:0]          addr   ;
input  [31:0]              wdata  ;
output [31:0]              rdata  ;

//-----------------------------
//--signal
//-----------------------------


//-----------------------------
//--main circuit
//-----------------------------
generate
  genvar i;
  for(i=0;i<32;i=i+1)
  begin£ºSRAM_unit
    SRAM_unit(
        .clk  (clk     ) , 
        .wen  (wen[i]  ) , 
        .cen  (cen     ) , 
        .addr (addr    ) , 
        .wdata(wdata[i]) , 
        .rdata(rdata[i])  
    );
  end

endgenerate




endmodule





