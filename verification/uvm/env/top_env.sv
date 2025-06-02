`ifndef TOP_ENV_SV
`define TOP_ENV_SV

class top_env extends uvm_env;
`uvm_component_utils(top_env)

timeAlign_uvc_agent m_timeAlign_agent;
timeAlign_uvc_config m_timeAlign_config;
top_vsqr vsqr;

extern function new(string name, uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass:top_env

function top_env :: new(string name, uvm_component parent);
super.new(name, parent);
endfunction: new

function void top_env::build_phase(uvm_phase phase);
//2. CREAMOS EL CONFIG
m_timeAlign_config = timeAlign_uvc_config::type_id::create("m_timeAlign_config");
m_timeAlign_config.is_active = UVM_ACTIVE;
uvm_config_db#(timeAlign_uvc_config)::set(this,"m_timeAlign_agent*","config",m_timeAlign_config);

//CREAMOS EL AGENTE
m_timeAlign_agent = timeAlign_uvc_agent::type_id::create("m_timeAlign_agent",this);
vsqr = top_vsqr::type_id::create("vsqr",this);
endfunction:build_phase

function void top_env ::connect_phase(uvm_phase phase);
vsqr.m_timeAlign_sequencer = m_timeAlign_agent.m_sequencer;

endfunction


`endif 