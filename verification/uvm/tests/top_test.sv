`ifndef TOP_TEST_SV
`define TOP_TEST_SV

class top_test extends uvm_test;
`uvm_component_utils(top_test)


extern function new(string name, uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void end_of_elaboration_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass: top_test

function top_test::new(string name, uvm_component parent);
super.new(name, parent);
endfunction:new

function void top_test::build_phase(uvm_phase phase);

endfunction: build_phase

function void top_test::end_of_elaboration_phase(uvm_phase phase);
uvm_root::get().print_topology();
uvm_factory::get().print();

endfunction: end_of_elaboration_phase

task top_test::run_phase(uvm_phase phase);
//COLOCAMOS LOS SIGUIENTES COMANDOS PARA CORRER EL RUN
phase.raise_objection(this);

phase.drop_objection(this);


endtask: run_phase




`endif // TOP_TEST_SV