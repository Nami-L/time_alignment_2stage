`ifndef TIMEALIGN_UVC_SEQUENCE_ITEM_SV
`define TIMEALIGN_UVC_SEQUENCE_ITEM_SV

class timeAlign_uvc_sequence_item extends uvm_sequence_item;
`uvm_object_utils (timeAlign_uvc_sequence_item)


//TRANSACTION VARIABLES: INPUTS
    rand logic [2:0] m_msb; // Bits de la etapa 1 (MSBs)
    rand logic [2:0] m_lsb; // Bits de la etapa 2 (LSBs)
//READ VARIABLES :OUTPUTS
    logic [5:0] m_dout;    // Salida alineada: {MSBs, LSBs}


extern function new(string name ="");
extern function void do_copy(uvm_object rhs);
extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
extern function void do_print(uvm_printer printer);
extern function string convert2string();

endclass:timeAlign_uvc_sequence_item

function timeAlign_uvc_sequence_item::new(string name ="");
super.new();
endfunction: new

function void timeAlign_uvc_sequence_item::do_copy(uvm_object rhs);
timeAlign_uvc_sequence_item rhs_;

 if (!$cast(rhs_, rhs)) `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  super.do_copy(rhs);

     m_msb = rhs_.m_msb;
     m_lsb = rhs_.m_lsb; 
     m_dout = rhs_.m_dout;    

endfunction: do_copy


function bit timeAlign_uvc_sequence_item::do_compare(uvm_object rhs, uvm_comparer comparer);
bit result;
timeAlign_uvc_sequence_item rhs_;
  if (!$cast(rhs_, rhs)) `uvm_fatal(get_type_name(), "Cast of rhs object failed")

result = super.do_compare(rhs, comparer);
result &= (m_dout == rhs_.m_dout);
return result;
endfunction: do_compare

function void timeAlign_uvc_sequence_item::do_print(uvm_printer printer);
  if (printer.knobs.sprint == 0) `uvm_info(get_type_name(), convert2string(), UVM_MEDIUM)
  else printer.m_string = convert2string();
endfunction: do_print



function string timeAlign_uvc_sequence_item::convert2string();

  string s;
  s = super.convert2string();
  $sformat(s, {s, "\n", "TRANSACTION INFORMATION (TimeAlign UVC):"});
  $sformat(s, {s, "\n", "m_msb = %5d, m_lsb = %5d, m_dout = %5d\n"}, m_msb,
           m_lsb, m_dout);
  return s;

endfunction: convert2string



`endif //TIMEALIGN_UVC_SEQUENCE_ITEM_SV