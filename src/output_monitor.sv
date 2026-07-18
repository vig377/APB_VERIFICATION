class apb_output_monitor;
apb_trans om;
mailbox #(apb_trans)om_sc;
virtual apb.om vif;
function new(mailbox #(apb_trans)om_sc,virtual apb.om vif);
  this.om_sc=om_sc;
  this.vif=vif;
endfunction
task start();
  repeat(2)@(vif.output_mon_cb);
  for(int i=0;i<`no;i++)
    begin
      om=new;
      repeat (2) @(vif.output_mon_cb);
       // if(vif.output_mon_cb.psel&vif.output_mon_cb.penable && vif.output_mon_cb.pready)
          begin
      om.prdata=vif.output_mon_cb.prdata;
      om.pslverr=vif.output_mon_cb.pslverr;
      om.pready=vif.output_mon_cb.pready;
      om.paddr=vif.output_mon_cb.paddr;
            $display("output monitor : prdata =%h pslverr=%d pready=%d paddr =%d at time %t \n",om.prdata,om.pslverr,om.pready,om.paddr,$time);
      if (vif.output_mon_cb.pready) begin
          om_sc.put(om.copy());
        $display("output monitor after put : prdata =%h pslverr=%d pready=%d paddr=%d  num =%d at time %t \n",om.prdata,om.pslverr,om.pready,om.paddr,om_sc.num(),$time);
      end
      end
    end
endtask
endclass
