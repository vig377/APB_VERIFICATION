class apb_trans;
rand logic[`data_width-1:0]pwdata;
rand logic[`addr_width-1:0]paddr;
rand logic[`strb_width-1:0]pstrb;
logic [`data_width-1:0]prdata;
rand bit psel,penable,pwrite;
bit pslverr,pready;
bit reset;
virtual function apb_trans copy();
  copy=new;
  copy.pwdata=this.pwdata;
  copy.paddr=this.paddr;
  copy.pstrb=this.pstrb;
  copy.psel=this.psel;
  copy.penable=this.penable;
  copy.pwrite=this.pwrite;
  copy.reset=this.reset;
  copy.pslverr=this.pslverr;
  copy.prdata=this.prdata;
  copy.pready=this.pready;
  return copy;
endfunction
endclass
class write_valid extends apb_trans;
constraint val{psel==1;penable==1;pwrite==1; pwdata inside{[0:2**(`data_width)-1]};
		paddr inside{[0:(`valid_addr)]}; foreach(pstrb[i]) {pstrb[i]==1;}}
virtual function apb_trans copy();
  write_valid copy_1;
  copy_1=new;
  copy_1.pwdata=this.pwdata;
  copy_1.paddr=this.paddr;
  copy_1.pstrb=this.pstrb;
  copy_1.psel=this.psel;
  copy_1.penable=this.penable;
  copy_1.pwrite=this.pwrite;
  copy_1.reset=this.reset;
  copy_1.pslverr=this.pslverr;
  copy_1.prdata=this.prdata;
  copy_1.pready=this.pready;
  return copy_1;
endfunction
endclass
class write_invalid extends apb_trans;
constraint val{psel==1;penable==1;pwrite==1;pwdata inside {[0:2**(`data_width)-1]};paddr inside{[`valid_addr+1:2**(`addr_width)-1]};foreach(pstrb[i]) {pstrb[i]==1;}}
virtual function apb_trans copy();
  write_invalid copy_2;
  copy_2=new;
  copy_2.pwdata=this.pwdata;
  copy_2.paddr=this.paddr;
  copy_2.pstrb=this.pstrb;
  copy_2.psel=this.psel;
  copy_2.penable=this.penable;
  copy_2.pwrite=this.pwrite;
  copy_2.reset=this.reset;
  copy_2.pslverr=this.pslverr;
  copy_2.prdata=this.prdata;
  copy_2.pready=this.pready;
  return copy_2;
endfunction
endclass
class read_valid extends apb_trans;
constraint val{psel==1;penable==1;pwrite==0; pwdata inside{[0:2**(`data_width)-1]};
		paddr inside{[0:(`valid_addr)]}; foreach(pstrb[i]) {pstrb[i]==0;}}
virtual function apb_trans copy();
read_valid copy_3;
  copy_3 =new;
  copy_3.pwdata=this.pwdata;
  copy_3.paddr=this.paddr;
  copy_3.pstrb=this.pstrb;
  copy_3.psel=this.psel;
  copy_3.penable=this.penable;
  copy_3.pwrite=this.pwrite;
  copy_3.reset=this.reset;
  copy_3.pslverr=this.pslverr;
  copy_3.prdata=this.prdata;
  copy_3.pready=this.pready;
  return copy_3;
endfunction
endclass
class read_invalid extends apb_trans;
constraint val{psel==1;penable==1;pwrite==0;pwdata inside {[0:2**(`data_width)-1]};paddr inside{[`valid_addr+1:2**(`addr_width)-1]};foreach(pstrb[i]) {pstrb[i]==1;}}
virtual function apb_trans copy();
  read_invalid copy_4;
  copy_4 =new;
  copy_4.pwdata=this.pwdata;
  copy_4.paddr=this.paddr;
  copy_4.pstrb=this.pstrb;
  copy_4.psel=this.psel;
  copy_4.penable=this.penable;
  copy_4.pwrite=this.pwrite;
  copy_4.reset=this.reset;
  copy_4.pslverr=this.pslverr;
  copy_4.prdata=this.prdata;
  copy_4.pready=this.pready;
  return copy_4;
endfunction
endclass
class pstrb_random extends apb_trans;
constraint val{psel==1;penable==1;pwrite==1;pwdata inside {[0:2**(`data_width)-1]};paddr inside{[`valid_addr-10:`valid_addr+10]};pstrb inside{[1:2**(`strb_width )-1]};}
virtual function apb_trans copy();
  pstrb_random copy_5;
  copy_5 =new;
  copy_5.pwdata=this.pwdata;
  copy_5.paddr=this.paddr;
  copy_5.pstrb=this.pstrb;
  copy_5.psel=this.psel;
  copy_5.penable=this.penable;
  copy_5.pwrite=this.pwrite;
  copy_5.reset=this.reset;
  copy_5.pready=this.pready;
  copy_5.prdata  = this.prdata;
  copy_5.pslverr = this.pslverr;
  return copy_5;
endfunction
endclass
class pstrb_allzero extends apb_trans;
constraint val{psel==1;penable==1;pwrite==1;pwdata inside {[0:2**(`data_width)-1]};paddr inside{[`valid_addr+1:2**(`addr_width)-1]};foreach(pstrb[i]) {pstrb[i]==0;}}
virtual function apb_trans copy();
  pstrb_allzero copy_6;
  copy_6 =new;
  copy_6.pwdata=this.pwdata;
  copy_6.paddr=this.paddr;
  copy_6.pstrb=this.pstrb;
  copy_6.psel=this.psel;
  copy_6.penable=this.penable;
  copy_6.pwrite=this.pwrite;
  copy_6.reset=this.reset;
  copy_6.pslverr=this.pslverr;
  copy_6.prdata=this.prdata;
  copy_6.pready=this.pready;
  return copy_6;
endfunction
endclass
class protocol_voilation extends apb_trans;
constraint val{psel==0;penable==1;pwrite==0;pwdata inside {[0:2**(`data_width)-1]};paddr inside{[`valid_addr+1:2**(`addr_width)-1]};foreach(pstrb[i]) {pstrb[i]==1;}}
virtual function apb_trans copy();
  protocol_voilation copy_7;
  copy_7 =new;
  copy_7.pwdata=this.pwdata;
  copy_7.paddr=this.paddr;
  copy_7.pstrb=this.pstrb;
  copy_7.psel=this.psel;
  copy_7.penable=this.penable;
  copy_7.pwrite=this.pwrite;
  copy_7.reset=this.reset;
  copy_7.pslverr=this.pslverr;
  copy_7.prdata=this.prdata;
  copy_7.pready=this.pready;
  return copy_7;
endfunction
endclass
class do_nothing extends apb_trans;
constraint val{psel==1;penable==0;pwrite==0;pwdata inside {[0:2**(`data_width)-1]};paddr inside{[`valid_addr+1:2**(`addr_width)-1]};foreach(pstrb[i]) {pstrb[i]==1;}}
virtual function apb_trans copy();
  do_nothing copy_8;
  copy_8 =new;
  copy_8.pwdata=this.pwdata;
  copy_8.paddr=this.paddr;
  copy_8.pstrb=this.pstrb;
  copy_8.psel=this.psel;
  copy_8.penable=this.penable;
  copy_8.pwrite=this.pwrite;
  copy_8.reset=this.reset;
  copy_8.pslverr=this.pslverr;
  copy_8.prdata=this.prdata;
  copy_8.pready=this.pready;
  return copy_8;
endfunction
endclass
class do_nothing_2 extends apb_trans;
constraint val{psel==0;penable==0;pwrite==0;pwdata inside {[0:2**(`data_width)-1]};paddr inside{[`valid_addr+1:2**(`addr_width)-1]};foreach(pstrb[i]) {pstrb[i]==1;}}
virtual function apb_trans copy();
  do_nothing_2 copy_9;
  copy_9 =new;
  copy_9.pwdata=this.pwdata;
  copy_9.paddr=this.paddr;
  copy_9.pstrb=this.pstrb;
  copy_9.psel=this.psel;
  copy_9.penable=this.penable;
  copy_9.pwrite=this.pwrite;
  copy_9.reset=this.reset;
  copy_9.pslverr=this.pslverr;
  copy_9.prdata=this.prdata;
  copy_9.pready=this.pready;
  return copy_9;
endfunction
endclass
class write_same extends apb_trans;
constraint val{psel==1;penable==1;pwrite==1;pwdata inside {[0:2**(`data_width)-1]};paddr==2;foreach(pstrb[i]) {pstrb[i]==1;}}
virtual function apb_trans copy();
  write_same copy_10;
  copy_10 =new;
  copy_10.pwdata=this.pwdata;
  copy_10.paddr=this.paddr;
  copy_10.pstrb=this.pstrb;
  copy_10.psel=this.psel;
  copy_10.penable=this.penable;
  copy_10.pwrite=this.pwrite;
  copy_10.reset=this.reset;
  copy_10.pslverr=this.pslverr;
  copy_10.prdata=this.prdata;
  copy_10.pready=this.pready;
  return copy_10;
endfunction
endclass
