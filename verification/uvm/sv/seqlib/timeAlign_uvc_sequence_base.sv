`ifndef TIMEALIGN_UVC_SEQUENCE_BASE_SV 
`define TIMEALIGN_UVC_SEQUENCE_BASE_SV

class timeAlign_uvc_sequence_base extends uvm_sequence #(timeAlign_uvc_sequence_item);

`uvm_object_utils(timeAlign_uvc_sequence_base)
rand timeAlign_uvc_sequence_item m_trans;

extern function new(string name = "");
extern virtual task body();

endclass: timeAlign_uvc_sequence_base

function timeAlign_uvc_sequence_base::new(string name ="");
super.new(name);
endfunction:new

task timeAlign_uvc_sequence_base::body();
  start_item(m_trans);
  finish_item(m_trans);
endtask:body

`endif //TIMEALIGN_UVC_SEQUENCE_BASE_SV