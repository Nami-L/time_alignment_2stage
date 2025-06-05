`ifndef TOP_SCOREBOARD_SV
`define TOP_SCOREBOARD_SV

class top_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(top_scoreboard)
  `uvm_analysis_imp_decl(_timeAlign)
  uvm_analysis_imp_timeAlign #(timeAlign_uvc_sequence_item, top_scoreboard) timeAlign_imp_export;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);
  //extern task run_phase(uvm_phase phase);
  extern function void write_timeAlign(input timeAlign_uvc_sequence_item t);

  int unsigned m_num_passed;
  int unsigned m_num_failed;
  timeAlign_uvc_sequence_item m_timeAlign_queue[$];

endclass : top_scoreboard

function top_scoreboard::new(string name, uvm_component parent);
  super.new(name, parent);
  m_num_failed = 0;
  m_num_passed = 0;
endfunction : new

function void top_scoreboard::build_phase(uvm_phase phase);
  timeAlign_imp_export = new("timeAlign_imp_export", this);
endfunction : build_phase

function void top_scoreboard::write_timeAlign(input timeAlign_uvc_sequence_item t);
  timeAlign_uvc_sequence_item received_trans;
  received_trans = timeAlign_uvc_sequence_item::type_id::create("received_trans");
  received_trans.do_copy(t);
  m_timeAlign_queue.push_back(received_trans);
endfunction : write_timeAlign


function void top_scoreboard::report_phase(uvm_phase phase);

  string s;
     foreach (m_timeAlign_queue[i]) begin
       s = {s, $sformatf("\nTRANS[%3d]: \n", i+1) ,m_timeAlign_queue[i].convert2string(), "\n"};
     end
     `uvm_info(get_type_name(), s, UVM_DEBUG)
  `uvm_info(get_type_name(), $sformatf("PASSED = %3d, FAILED = %3d", m_num_passed, m_num_failed),
            UVM_DEBUG)

endfunction : report_phase

//   task top_scoreboard::run_phase(uvm_phase phase);
//    string s;
//     forever begin
//       wait (m_timeAlign_queue.size() > 1);  // Espera que haya elementos en la cola
      
//        foreach (m_timeAlign_queue[i]) begin
//         if(i >1 ) begin
//        if(({m_timeAlign_queue[i-1].m_msb , m_timeAlign_queue[i].m_lsb}) ==m_timeAlign_queue[i].m_dout) begin
//        m_num_passed = m_num_passed + 1;
//       end else begin
//        m_num_failed = m_num_failed + 1;
//       end
//      end
//        end

//       foreach (m_timeAlign_queue[i]) begin
//         s = {
//           s,
//           $sformatf("\nTRANS[%3d]: \n ------ SCOREBOARD (ADDER UVC) ------  ", i),
//           m_timeAlign_queue[i].convert2string(),
//           "\n"
//         };
//       end
//       `uvm_info(get_type_name(), s, UVM_DEBUG)
//       s = "";
//       m_timeAlign_queue.delete();
//     end



//  endtask : run_phase


`endif  //TOP_SCOREBOARD_SV
