class apb_test;
virtual apb im_vif;
virtual apb drv_vif;
virtual apb om_vif;
apb_environment env;
function new(virtual apb im_vif,virtual apb drv_vif,virtual apb om_vif);
this.im_vif=im_vif;
this.drv_vif=drv_vif;
this.om_vif=om_vif;
endfunction
task run();
env=new(im_vif,drv_vif,om_vif);
env.build();
env.start();
endtask
endclass
class apb_reg extends apb_test;
write_valid reg1;
write_invalid reg2;
read_valid reg3;
read_invalid reg4;
pstrb_random reg5;
pstrb_allzero reg6;
protocol_voilation reg7;
do_nothing reg8;
do_nothing_2 reg9;
write_same reg10;

function new(virtual apb im_vif,virtual apb drv_vif,virtual apb om_vif);
super.new(im_vif, drv_vif, om_vif);
endfunction

task run();
$display("regression test\n");
env=new(im_vif,drv_vif,om_vif);
env.build();
begin
reg1=new;
env.gen.gen=reg1;
$display("write valid test\n");
end
env.start();
begin
reg2=new;
env.gen.gen=reg2;
$display("write_invalid test\n");
end
env.start();
begin
reg3=new;
env.gen.gen=reg3;
$display("read valid test\n");
end
env.start();
begin
reg4=new;
env.gen.gen=reg4;
$display("read invalid test\n");
end
env.start();
begin
reg5=new;
env.gen.gen=reg5;
$display("pstrb_random test\n");
end
env.start();
begin
reg3=new;
env.gen.gen=reg3;
$display("read valid after pstrb random\n");
end
env.start();
begin
reg6=new;
env.gen.gen=reg6;
$display("pstrb_allzero test\n");
end
env.start();
begin
reg3=new;
env.gen.gen=reg3;
$display("read valid after pstrb all zero\n");
end
env.start();
begin
reg7=new;
env.gen.gen=reg7;
$display("protocol_voilation test\n");
end
env.start();
begin
reg8=new;
env.gen.gen=reg8;
$display("do_nothing test\n");
end
env.start();
begin
reg9=new;
env.gen.gen=reg9;
$display("do_nothing 2 test\n");
end
env.start();
begin
reg10=new;
env.gen.gen=reg10;
$display("write_same test\n");
end
env.start();
endtask
endclass
