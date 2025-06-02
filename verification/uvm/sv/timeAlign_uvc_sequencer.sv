`ifndef TIMEALIGN_UVC_SEQUENCER_SV
`define TIMEALIGN_UVC_SEQUENCER_SV

class timeAlign_uvc_sequencer extends uvm_sequencer #(timeAlign_uvc_sequence_item);
`uvm_component_utils(timeAlign_uvc_sequencer)

timeAlign_uvc_config m_config;

extern function new(string name, uvm_component parent);
extern function void build_phase(uvm_phase phase);

endclass: timeAlign_uvc_sequencer

function timeAlign_uvc_sequencer::new(string name, uvm_component parent);
super.new(name, parent);
endfunction: new

function void timeAlign_uvc_sequencer::build_phase(uvm_phase phase);
//OBTENEMOS TODO LO QUE TENGA EL CONFIG POR SI SE OCUPA
if(!uvm_config_db#(timeAlign_uvc_config)::get(get_parent(),"","config",m_config))begin
    `uvm_fatal(get_name(), "Could not retrieve timeAlign_uvc_config from config db")

end
endfunction: build_phase


`endif //TIMEALIGN_UVC_SEQUENCER_SV