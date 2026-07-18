class apb_environment;
virtual apb im_vif;
virtual apb drv_vif;
virtual apb om_vif;
mailbox #(apb_trans)im_ref;
mailbox#(apb_trans)om_sc;
mailbox#(apb_trans)ref_sc;
mailbox#(apb_trans)g_dr;
apb_generator gen;
apb_driver dr;
apb_input_monitor im;
apb_output_monitor om;
apb_refrence refr;
apb_scoreboard sc;
function new(virtual apb im_vif,virtual apb drv_vif,virtual apb om_vif);
  this.im_vif=im_vif;
  this.drv_vif=drv_vif;
  this.om_vif=om_vif;
endfunction
task build();
  im_ref=new;
  om_sc=new;
  ref_sc=new;
  g_dr=new;
  gen=new(g_dr);
  dr=new(g_dr,drv_vif);
  im=new(im_ref,im_vif);
  om=new(om_sc,om_vif);
  refr=new(im_ref,ref_sc);
  sc=new(ref_sc,om_sc);
endtask
task start();
fork 
  gen.start();
  dr.start();
  im.start();
  om.start();
  refr.start();
  sc.start();
join
endtask
endclass



