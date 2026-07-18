class apb_refrence;
apb_trans refr;
apb_trans exp;
mailbox #(apb_trans)ref_sc;
mailbox #(apb_trans)im_ref;
function new(mailbox #(apb_trans)im_ref,mailbox #(apb_trans)ref_sc);
  this.ref_sc=ref_sc;
  this.im_ref=im_ref;
  refr=new;
endfunction
logic [`data_width-1:0]mem[0:2**(`addr_width)-1];
task start();
   for(int i=0;i<`no*2;i++)
    //forever
    begin
      im_ref.get(refr);
      $display("REF GOT: pwrite=%0b psel=%0b penable=%0b pready=%0b addr=%0d at time=%t",
               refr.pwrite, refr.psel, refr.penable, refr.pready, refr.paddr,$time);
      exp=new;
      if(refr.reset==0)
        begin
        foreach(mem[i])
        begin
        mem[i]=0;
        $display("After reset MEM[%d]=%h",i, mem[i]);
        end
        exp.pslverr=0;
        exp.prdata=0;
          $display("refrencebeforeput  data: pwdata =%d paddr =%d psel=%d penable=%d pwrite =%d pstr=%b pready=%d pslverr=%d prdata=%h at time %t\n",refr.pwdata,refr.paddr,refr.psel,refr.penable,refr.pwrite,refr.pstrb,exp.pready,exp.pslverr,exp.prdata,$time);
        ref_sc.put(exp.copy());
        $display("refrence data after put: pwdata =%d paddr =%d psel=%d penable=%d pwrite =%d pstr=%b pready=%d pslverr=%d prdata=%h at time %t\n",refr.pwdata,refr.paddr,refr.psel,refr.penable,refr.pwrite,refr.pstrb,exp.pready,exp.pslverr,exp.prdata,$time);
        end
      else if(refr.psel && refr.penable && refr.pready && refr.pwrite)
        begin
        $display("Before write MEM[%0d]=%h", refr.paddr, mem[refr.paddr]);
        if(refr.paddr>`valid_addr)
        begin
        exp.pslverr=1;
        exp.prdata=0;
        $display("After  write MEM[%0d]=%h", refr.paddr, mem[refr.paddr]);
          $display("refrencebeforeput  data: pwdata =%d paddr =%d psel=%d penable=%d pwrite =%d pstr=%b pready=%d pslverr=%d prdata=%h at time %t\n",refr.pwdata,refr.paddr,refr.psel,refr.penable,refr.pwrite,refr.pstrb,exp.pready,exp.pslverr,exp.prdata,$time);
        ref_sc.put(exp.copy());
        $display("refrence data after put: pwdata =%d paddr =%d psel=%d penable=%d pwrite =%d pstr=%b pready=%d pslverr=%d prdata=%h at time %t\n",refr.pwdata,refr.paddr,refr.psel,refr.penable,refr.pwrite,refr.pstrb,exp.pready,exp.pslverr,exp.prdata,$time);
        end
      else 
        begin
        foreach(refr.pstrb[i])
        if(refr.pstrb[i])
        mem[refr.paddr][i*8+:8]=refr.pwdata[i*8+:8];
        exp.pslverr=0;
        exp.prdata=0;
        $display("After  write MEM[%0d]=%h", refr.paddr, mem[refr.paddr]);
          $display("refrencebeforeput  data: pwdata =%d paddr =%d psel=%d penable=%d pwrite =%d pstr=%b pready=%d pslverr=%d prdata=%h at time %t\n",refr.pwdata,refr.paddr,refr.psel,refr.penable,refr.pwrite,refr.pstrb,exp.pready,exp.pslverr,exp.prdata,$time);
        ref_sc.put(exp.copy());
        $display("refrence data after put: pwdata =%d paddr =%d psel=%d penable=%d pwrite =%d pstr=%b pready=%d pslverr=%d prdata=%h at time %t\n",refr.pwdata,refr.paddr,refr.psel,refr.penable,refr.pwrite,refr.pstrb,exp.pready,exp.pslverr,exp.prdata,$time);
        end
        end
      else if(refr.psel && refr.penable && refr.pready && !refr.pwrite)
        begin
        if(refr.paddr>`valid_addr)
        begin
        exp.pslverr=1;
        exp.prdata=0;
        $display("Read MEM[%0d]=%h", refr.paddr, mem[refr.paddr]);
          $display("refrencebeforeput  data: pwdata =%d paddr =%d psel=%d penable=%d pwrite =%d pstr=%b pready=%d pslverr=%d prdata=%h at time %t\n",refr.pwdata,refr.paddr,refr.psel,refr.penable,refr.pwrite,refr.pstrb,exp.pready,exp.pslverr,exp.prdata,$time);
        ref_sc.put(exp.copy());
        $display("refrence data after put: pwdata =%d paddr =%d psel=%d penable=%d pwrite =%d pstr=%b pready=%d pslverr=%d prdata=%h at time %t\n",refr.pwdata,refr.paddr,refr.psel,refr.penable,refr.pwrite,refr.pstrb,exp.pready,exp.pslverr,exp.prdata,$time);
        end
        else
        begin
        exp.prdata=mem[refr.paddr];
        exp.pslverr=0;
        $display("Read MEM[%0d]=%h", refr.paddr, mem[refr.paddr]);
          $display("refrencebeforeput  data: pwdata =%d paddr =%d psel=%d penable=%d pwrite =%d pstr=%b pready=%d pslverr=%d prdata=%h at time %t\n",refr.pwdata,refr.paddr,refr.psel,refr.penable,refr.pwrite,refr.pstrb,exp.pready,exp.pslverr,exp.prdata,$time);
        ref_sc.put(exp.copy());
        $display("refrence data after put: pwdata =%d paddr =%d psel=%d penable=%d pwrite =%d pstr=%b pready=%d pslverr=%d prdata=%h at time %t\n",refr.pwdata,refr.paddr,refr.psel,refr.penable,refr.pwrite,refr.pstrb,exp.pready,exp.pslverr,exp.prdata,$time);
        end
      end
    end
endtask
endclass
