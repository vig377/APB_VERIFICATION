class apb_scoreboard;
apb_trans exp,act;
mailbox #(apb_trans)ref_sc;
mailbox #(apb_trans)om_sc;
int match,mismatch;
function new(mailbox #(apb_trans)ref_sc,mailbox#(apb_trans)om_sc);
this.ref_sc=ref_sc;
this.om_sc=om_sc;
endfunction
task start();
for(int i=0;i<`no;i++)
begin
om_sc.get(act);
ref_sc.get(exp);
$display("ref mailbox %d sc mailbox %d\n",ref_sc.num(),om_sc.num());
if(exp.pslverr==act.pslverr)
begin
$display("slverr match : pslver(exp)=%d pslverr(actual)=%d at time %t\n",exp.pslverr,act.pslverr,$time);
match++;
end
else
begin
mismatch++;
$display("slverr mismatch : pslver(exp)=%d pslverr(actual)=%d at time %t\n",exp.pslverr,act.pslverr,$time);
end
if(exp.prdata==act.prdata)
begin
$display("prdata match : prdata(exp)=%d prdata(actual)=%d at time %t\n",exp.prdata,act.prdata,$time);
match++;
end
else
begin
$display("prdata mismatch : prdata(exp)=%d prdata(actual)=%d at time %t\n",exp.prdata,act.prdata,$time);
mismatch++;
end
end
$display("total test %d match =%d mismatch=%d \n",match+mismatch,match,mismatch);
endtask
endclass
