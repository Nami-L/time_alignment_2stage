`ifndef TIMEALIGN_UVC_MONITOR_SV
`define TIMEALIGN_UVC_MONITOR_SV

class timeAlign_uvc_monitor extends uvm_monitor;
`uvm_component_utils(timeAlign_uvc_monitor)

uvm_analysis_port #(timeAlign_uvc_sequence_item) analysis_port;
virtual timeAlign_uvc_if vif;
timeAlign_uvc_config m_config;
timeAlign_uvc_sequence_item m_trans;

//CREAR VARIABLES TEMPORALES

logic [2:0] tem_msb;
logic [2:0] tem_lsb;
logic [5:0] tem_dout;

extern function new(string name, uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task do_mon ();


endclass:timeAlign_uvc_monitor

function timeAlign_uvc_monitor::new(string name, uvm_component parent);
super.new(name, parent);
endfunction:new

function void timeAlign_uvc_monitor::build_phase(uvm_phase phase);
//EN ESTA PARTE, AL IGUAL QUE EL DRIVER, SE NECESITA TENER ACCESO
//A LA INTERFAZ VIRTUAL
// AGREGAMOS EL CONFIG POR SI SE OCUPA
 if (!uvm_config_db#(virtual timeAlign_uvc_if)::get(get_parent(), "", "vif", vif)) begin
    `uvm_fatal(get_name(), "Could not retrieve timeAlign_uvc_if from VIF db")
  end

if (!uvm_config_db#(timeAlign_uvc_config)::get(get_parent(), "", "config", m_config)) begin
    `uvm_fatal(get_name(), "Could not retrieve timeAlign_uvc_config from config db")
  end

analysis_port = new("analysis_port", this);

endfunction:build_phase

task timeAlign_uvc_monitor::run_phase(uvm_phase phase);
// CREAMOS EL OBJETO PORQUE AHORA NECESITAMOS LEER LO QUE TIENE 
//EL DUT A TRAVES DE LA INTERFAZ
m_trans = timeAlign_uvc_sequence_item::type_id::create("m_trans");
do_mon(); 
endtask: run_phase

task timeAlign_uvc_monitor::do_mon();

forever begin
tem_lsb = vif.lsb_i;
tem_msb = vif.msb_i;
tem_dout = vif.dout_o;
@(vif.cb_drv);
//CONDICION
if((tem_lsb != vif.lsb_i) || (tem_msb != vif.msb_i) || (tem_dout != vif.dout_o))begin

  m_trans.m_msb = vif.msb_i;
  m_trans.m_lsb = vif.lsb_i;
  m_trans.m_dout = vif.dout_o;

    `uvm_info(get_type_name(), {"\n ------ MONITOR (TimeAlign UVC) ------ ", m_trans.convert2string()}, UVM_DEBUG)

analysis_port.write(m_trans);
end



end

endtask:do_mon


`endif //TIMEALIGN_UVC_MONITOR_SV