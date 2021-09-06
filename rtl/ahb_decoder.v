//file name: ahb_decoder.v
//function : 
//author   : HateHanzo
module ahb_decoder(
 
);

//parametr
parameter  DLY         = 1              ;


//input output
input       HCLK      ;
input       HRESETn    ;
input [11:0]  HREADYOUTS ;
input [31:0]  HRDATAS11 ;
input [31:0]  HRDATAS10 ;
input [31:0]  HRDATAS9  ;
//...

input [31:0]  cpu_haddr  ;
input [31:0]  cpu_hwdata ;
input [2:0]  cpu_hsize   ; 
input [2:0]  cpu_hburst  ;
input [1:0]  cpu_htrans  ;
input       cpu_hwrite  ;

output         HREADY ;//gobal readyi to every slave module
output [11:0]   HSELS  ;
output [31:0]   HRDATA ;
output [31:0]   HWDATA ;
output [31:0]   HADDR  ;
output [2:0]    HBURST ;
output [2:0]    HSIZE  ;
output [1:0]    HTRANS ;
output         HWRITE ;
//-----------------------------
//--signal
//-----------------------------
wire [11:0] HSELS   ;
reg  [11:0] hsels_r ;

//-----------------------------
//--main circuit
//-----------------------------

//AHB bus MUX
assign HADDR  = load_flag ? load_maddr  : cpu_haddr  ;
assign HSIZE  = load_flag ? load_msize  : cpu_hsize  ;
assign HTRANS = load_flag ? load_mtrans : cpu_htrans  ;
assign HBURST = load_flag ? load_mburst : cpu_hburst  ;
assign HWDATA = load_flag ? load_mwdata : cpu_hwdata  ;
assign HWRITE = load_flag ? load_mwrite : cpu_hwrite  ;

//Memory Map
assign HSELS[11] = (HADDR[31:16] == 16'40007) ;//FSK
assign HSELS[10] = (HADDR[31:16] == 16'40006) ;//SPI
assign HSELS[9]  = (HADDR[31:16] == 16'40005) ;//I2C
assign HSELS[8]  = (HADDR[31:16] == 16'40004) ;//SRAM
//...

//registered hsels
always@(posedge HCLK or negedge HRESETn)
begin
  if(!HRESETn)
    hsels_r <= 12'h0;
  else if(HREADY)
    hsels_r <= #DLY HSELS;
end

//hrdata/hready/hresp
assign HRDATA = ( {32{hsels_r[11]}} & HRDATAS11 ) |
             ( {32{hsels_r[10]}} & HRDATAS10 ) |
              //...
             ( {32{hsels_r[0]}} & HRDATAS0 );

assign HREADY = ~ ( (hsels_r[11]) & (~HREADYOUTS[11]) |
                 (hsels_r[10]) & (~HREADYOUTS[10]) |
                 //...
                 (hsels_r[0]) & (~HREADYOUTS[0]) ) ;             
              
endmodule





