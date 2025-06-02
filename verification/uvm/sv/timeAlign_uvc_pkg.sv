`ifndef TIMEALIGN_UVC_PKG_SV
`define TIMEALIGN_UVC_PKG_SV

package timeAlign_uvc_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;


  `include "timeAlign_uvc_sequence_item.sv"
  `include "timeAlign_uvc_config.sv"
  `include "timeAlign_uvc_sequencer.sv"

  `include "timeAlign_uvc_monitor.sv"
  `include "timeAlign_uvc_driver.sv"
  `include "timeAlign_uvc_agent.sv"

  // Sequence library
  `include "timeAlign_uvc_sequence_base.sv"

endpackage : timeAlign_uvc_pkg

`endif  //TIMEALIGN_UVC_PKG_SV
