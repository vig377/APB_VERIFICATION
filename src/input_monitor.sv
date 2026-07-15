class apb_input_monitor;
apb_trans im;
mailbox #(apb_trans)im_ref;
virtual apb.im vif;
covergroup cg;
PADDR:coverpoint im.paddr{bins b1={[`valid_addr:2**(`addr_width)-1]};bins b2={[0:`valid_addr-1]};}			
PENABLE:coverpoint im.penable{bins b2[]={0,1};}
PSEL:coverpoint im.psel{bins b3[]={0,1};}
PSTRB:coverpoint im.pstrb{bins b4[]={0,[1:2**(`strb_width)-2],2**(`strb_width)-1};}
PWDATA:coverpoint im.pwdata{bins b5[3]= {[0:{`data_width{1'b1}}]};}
PWRITE:coverpoint im.pwrite{bins b6[]={0,1};}
cr:cross PSEL,PENABLE;
endgroup
function new(mailbox #(apb_trans)im_ref,virtual apb.im vif);
this.im_ref=im_ref;
this.vif=vif;
cg=new;
endfunction
task start();
fork
begin
forever begin
@(negedge vif.reset);
im=new;
im.reset=0;
im.psel    = 0;
im.penable = 0;
im.pwrite  = 0;
im.paddr   = 0;
im.pwdata  = 0;
im.pstrb   = 0;
im.pready  = 0;
$display("INPUT MONITOR : RESET transaction sent at time %t",$time);
im_ref.put(im.copy());
end
end
begin
repeat(2)@(vif.input_mon_cb);
for(int i=0;i<`no;i++)
begin
im=new;
wait(vif.reset);
repeat(1)@(vif.input_mon_cb);
im.pwdata=vif.input_mon_cb.pwdata;
im.paddr=vif.input_mon_cb.paddr;
im.psel=vif.input_mon_cb.psel;
im.penable=vif.input_mon_cb.penable;
im.pwrite=vif.input_mon_cb.pwrite;
im.pstrb=vif.input_mon_cb.pstrb;
im.pready=vif.input_mon_cb.pready;
im.reset=vif.reset;
cg.sample();
$display("input monitor (from interface) :pwdata =%d paddr=%d pstrb=%d psel=%d penable=%d pwrite =%d at time=%d \n",im.pwdata,im.paddr,im.pstrb,im.psel,im.penable,im.pwrite,$time);
im_ref.put(im.copy());
end
end

join_none
endtask
endclass

