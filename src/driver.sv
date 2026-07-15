class apb_driver;
apb_trans dr;
mailbox #(apb_trans)g_dr;
virtual apb.driv vif;
function new(mailbox #(apb_trans)g_dr,virtual apb.driv vif);
this.g_dr=g_dr;
this.vif=vif;
endfunction
task reset();
vif.driv_cb.pwdata<=0;
vif.driv_cb.paddr<=0;
vif.driv_cb.pstrb<=0;
vif.driv_cb.psel<=0;
vif.driv_cb.penable<=0;
vif.driv_cb.pwrite<=0;
$display("driver (reset ) : pwdata =%d paddr=%d pstrb=%d psel=%d penable=%d pwrite =%d at time=%d \n",dr.pwdata,dr.paddr,dr.pstrb,dr.psel,dr.penable,dr.pwrite,$time);
endtask
task start();
repeat(1)@(vif.driv_cb);
for (int i=0;i<`no;i++)
begin
dr=new;
g_dr.get(dr);
while(1)
begin
wait(vif.reset); 
fork
begin
repeat(1)@(vif.driv_cb);
vif.driv_cb.pwdata<=dr.pwdata;
vif.driv_cb.paddr<=dr.paddr;
vif.driv_cb.pstrb<=dr.pstrb;
vif.driv_cb.psel<=1;
vif.driv_cb.penable<=0;;
vif.driv_cb.pwrite<=dr.pwrite;
repeat(1)@(vif.driv_cb);
vif.driv_cb.pwdata<=dr.pwdata;
vif.driv_cb.paddr<=dr.paddr;
vif.driv_cb.pstrb<=dr.pstrb;
vif.driv_cb.psel<=dr.psel;
vif.driv_cb.penable<=dr.penable;
vif.driv_cb.pwrite<=dr.pwrite;
$display("driver (normal ) : pwdata =%d paddr=%d pstrb=%d psel=%d penable=%d pwrite =%d at time=%d \n",dr.pwdata,dr.paddr,dr.pstrb,dr.psel,dr.penable,dr.pwrite,$time);
end
begin
@(negedge vif.reset);
end
join_any
disable fork;
if(!vif.reset)
reset();
else
break;
end
end
endtask
endclass
