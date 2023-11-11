module wb2axi
  #(parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 12)
   (
    input                     wb_clk_i,
    input                     wb_rst_i,


    // Wishbone signals
    input                       wb_cyc_i,
    input                       wb_stb_i,
    input                       wb_we_i,
    input   [ADDR_WIDTH-1:0]    wb_adr_i,
    input   [DATA_WIDTH-1:0]    wb_dat_i,
    //input   [DATA_WIDTH/8-1:0]  wb_sel_i,
    output                      wb_ack_o,
    output   [DATA_WIDTH-1:0]   wb_dat_o,


    // AXI signals
    output   [ADDR_WIDTH-1:0]   axil_awaddr,
    output                      axil_awvalid,
    input                       axil_awready,

    output   [DATA_WIDTH-1:0]   axil_wdata,
    //output   [DATA_WIDTH/8-1:0] WE,
    output                      axil_wvalid,
    input                       axil_wready,
   
    output   [ADDR_WIDTH-1:0]   axil_araddr,
    output                      axil_arvalid,
    input                       axil_arready,
   
    input   [DATA_WIDTH-1:0]    axil_rdata,
    input                       axil_rvalid,
    output                      axil_rready,


   //ss interface
    output                        ss_tvalid,
    output   [DATA_WIDTH-1:0]     ss_tdata,
    output                        ss_tlast,
    input                         ss_tready,


   //sm interface
    output                        sm_tready,
    input                         sm_tvalid,
    input   [DATA_WIDTH-1:0]      sm_tdata,
    input                         sm_tlast
    );


   //assign axil_awaddr = wb_adr_i;
   //assign axil_wdata = wb_dat_i;
   
   //assign WE = wb_sel_i;

   //assign axil_araddr = wb_adr_i;


   wire      write_transfer;
   wire      read_transfer;

   assign write_transfer     = (wb_cyc_i && wb_stb_i) & wb_we_i;
   assign read_transfer      = (wb_cyc_i && wb_stb_i) & !wb_we_i;


fir firU0(

.awready(axil_awready),
.wready(axil_wready),
.awvalid(axil_awvalid),
.awaddr(axil_awaddr),
.wvalid(axil_wvalid),
.wdata(axil_wdata),

.arready(axil_arready),
.rvalid(axil_rvalid),
.arvalid(axil_arvalid),
.rready(axil_rready),
.araddr(axil_araddr),
.rdata(axil_rdata),

.ss_tdata(ss_tdata), 
.ss_tlast(ss_tlast), 
.ss_tready(ss_tready),
.ss_tvalid(ss_tvalid), 
.sm_tready(sm_tready), 
.sm_tvalid(sm_tvalid), 
.sm_tdata(sm_tdata), 
.sm_tlast(sm_tlast),

.axis_clk(wb_clk_i),
.axis_rst_n(!wb_rst_i)




);

//valid signal
//axi lite out and stream out control signal
assign axil_awvalid = write_transfer;
assign axil_wvalid  = write_transfer;
assign axil_arvalid = read_transfer;
assign ss_tvalid    = write_transfer && wb_adr_i == 12'h080;
assign ss_tdata     = (write_transfer && wb_adr_i == 12'h080) ? wb_dat_i : 0;
reg read_ack;
//reg [31:0] axil_wdata_reg;

// read or write data to fir through axi


/*
reg [11:0] axil_awaddr_reg;

always@(posedge axis_clk)
begin
    if(axil_awready && write_transfer)
        axil_awaddr_reg <= wb_adr_i;
    else
        axil_awaddr_reg <= 0;    
end

assign axil_awaddr = axil_awaddr_reg;
*/

assign axil_awaddr = (axil_awready && write_transfer)  ? (wb_adr_i & 12'hfff) : 0;
assign axil_araddr = (axil_arready && read_transfer) ? (wb_adr_i & 12'hfff) : 0;


/*
always@(posedge wb_clk_i)
begin
    if(write_transfer && (axil_wready || ss_tready) )
        axil_wdata_reg <= wb_dat_i;
    else
        axil_wdata_reg <= 0;    
end  

assign axil_wdata = axil_wdata_reg;
*/

assign axil_wdata  = (write_transfer && (axil_wready || ss_tready) ) ? wb_dat_i : 0;

assign wb_dat_o = (axil_rvalid && read_transfer) ? axil_rdata :  
                     (sm_tvalid && read_transfer) ? sm_tdata : 0;




//ready signal
assign sm_tready   = read_transfer & sm_tvalid;
assign axil_rready = 1;


/*check the condition if the data has been transfered 
assign transfer_success = (axil_wvalid & axil_wready) | 
                          (axil_rvalid & axil_rready) | 
                          (ss_tready & ss_tvalid) | 
                          (sm_tvalid & sm_tready);
*/                          


//ack signal
assign wb_ack_o = (write_transfer) ? 1 :
                  (read_transfer) ? 1 : 0;
 //                 (ss_tlast & write_transfer) ? 1:
 //                 (sm_tlast & read_transfer)  ? 1:0;


/*data from axi to wishbone to tb
assign wb_dat_o = (read_transfer & ss_tvalid) ? axil_rdata :
                  (read_transfer & sm_tready) ? sm_tdata : 0;
*/
    always@(posedge wb_clk_i ) begin
        if (wb_rst_i)begin
            read_ack <= 0;
        end  else if (read_transfer && !read_ack) begin
            read_ack <= 1;
        end  else begin
            read_ack <= 0;
        end
        
    end
endmodule





