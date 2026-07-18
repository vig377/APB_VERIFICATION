`include "package.sv"
`include "interface.sv"
`include "APB.sv"
module top;
import apb_package::*;
bit clk=0;
bit reset;

apb intf(clk,reset);
apb_slave #(.ADDR_WIDTH(`addr_width),.DATA_WIDTH(`data_width),.MEM_DEPTH(`valid_addr)) duv(.PCLK(clk),.PRESETn(reset),.PADDR(intf.paddr),.PSEL(intf.psel),.PENABLE(intf.penable),.PWRITE(intf.pwrite),.PWDATA(intf.pwdata),.PSTRB(intf.pstrb),.PRDATA(intf.prdata),.PREADY(intf.pready),.PSLVERR(intf.pslverr));

apb_test test=new(intf.im,intf.driv,intf.om);
apb_reg tb_reg=new(intf.im,intf.driv,intf.om);

initial begin
forever #10 clk=~clk;
end
initial begin
reset=0;
//@(posedge clk);
reset=1;

//@(posedge clk);
reset=0;

//@(posedge clk);
reset=1;
end

initial begin
tb_reg.run();
$finish();
end
endmodule
