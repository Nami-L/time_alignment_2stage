`ifndef TIMEALIGN_UVC_CONFIG_SV
`define TIMEALIGN_UVC_CONFIG_SV

class timeAlign_uvc_config extends uvm_object;
`uvm_object_utils(timeAlign_uvc_config)

uvm_active_passive_enum is_active= UVM_ACTIVE;
extern function new(string name ="");

endclass: timeAlign_uvc_config

function timeAlign_uvc_config :: new(string name = "");
super.new(name);
endfunction: new



`endif //TIMEALIGN_UVC_CONFIG_SV

