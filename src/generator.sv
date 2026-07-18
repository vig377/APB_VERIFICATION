class apb_generator;
apb_trans gen;
mailbox #(apb_trans)g_dr;
bit [`addr_width-1:0]arr[$];
function new(mailbox #(apb_trans)g_dr);
  this.g_dr=g_dr;
  gen=new;
endfunction
task start();
  for(int i=0;i<`no;i++)
    begin
      assert(gen.randomize())
      begin
      if(gen.psel && gen.penable && gen.pwrite)
      begin
      arr.push_front(gen.paddr);
      $display("generator :  psel =%d penb =%d pwrite =%d pwdata =%d paddr =%d pstrb=%b at time =%t \n",gen.psel,gen.penable,gen.pwrite,gen.pwdata,gen.paddr,gen.pstrb,$time);
      g_dr.put(gen.copy());
      end
      else if(gen.psel && gen.penable && !(gen.pwrite))
      begin
      gen.paddr=arr.pop_back();
      $display("generator :  psel =%d penb =%d pwrite =%d pwdata =%d paddr =%d pstrb=%b at time =%t \n",gen.psel,gen.penable,gen.pwrite,gen.pwdata,gen.paddr,gen.pstrb,$time);
      g_dr.put(gen.copy());
      end
      else
      begin
      $display("generator :  psel =%d penb =%d pwrite =%d pwdata =%d paddr =%d pstrb=%b at time =%t \n",gen.psel,gen.penable,gen.pwrite,gen.pwdata,gen.paddr,gen.pstrb,$time);
      g_dr.put(gen.copy());
      end
  	end
  end
endtask
endclass
