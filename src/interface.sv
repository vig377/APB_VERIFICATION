//`include "defines.svh"
interface apb(input bit clk,reset);
	logic [`data_width-1:0]pwdata;
	logic[`addr_width-1:0]paddr;
	logic [`strb_width-1:0]pstrb;
	logic [`data_width-1:0]prdata;
	logic psel,penable,pwrite,pready,pslverr;

	clocking driv_cb@(posedge clk);
		default input #0 output #0;
		output pwdata,paddr,pstrb,psel,penable,pwrite;
	endclocking

	clocking input_mon_cb@(posedge clk);
		default input #0 output #0;
		input pwdata,paddr,pstrb,psel,penable,pwrite,pready;
	endclocking

	clocking output_mon_cb@(posedge clk);
		default input #0 output  #0;
		input pslverr,pready,prdata,paddr,psel,penable;
	endclocking

	modport driv(clocking driv_cb,input reset);
	modport om(clocking output_mon_cb);
	modport im(clocking input_mon_cb,input reset);
endinterface
