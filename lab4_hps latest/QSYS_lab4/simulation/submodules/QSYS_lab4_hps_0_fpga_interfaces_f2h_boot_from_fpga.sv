// (C) 2001-2015 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/main/ip/sopc/components/verification/altera_tristate_conduit_bfm/altera_tristate_conduit_bfm.sv.terp#7 $
// $Revision: #7 $
// $Date: 2010/08/05 $
// $Author: klong $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_conduit_bfm
// =head1 SYNOPSIS
// Bus Functional Model (BFM) for a Standard Conduit BFM
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This is a Bus Functional Model (BFM) for a Standard Conduit Master.
// This BFM sampled the input/bidirection port value or driving user's value to 
// output ports when user call the API.  
// This BFM's HDL is been generated through terp file in Qsys/SOPC Builder.
// Generation parameters:
// output_name:                                       QSYS_lab4_hps_0_fpga_interfaces_f2h_boot_from_fpga
// role:width:direction:                              f2h_boot_from_fpga_ready:1:Input,f2h_boot_from_fpga_on_failure:1:Input
// 0
//-----------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module QSYS_lab4_hps_0_fpga_interfaces_f2h_boot_from_fpga
(
   sig_f2h_boot_from_fpga_ready,
   sig_f2h_boot_from_fpga_on_failure
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   input sig_f2h_boot_from_fpga_ready;
   input sig_f2h_boot_from_fpga_on_failure;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   typedef logic ROLE_f2h_boot_from_fpga_ready_t;
   typedef logic ROLE_f2h_boot_from_fpga_on_failure_t;

   logic [0 : 0] sig_f2h_boot_from_fpga_ready_in;
   logic [0 : 0] sig_f2h_boot_from_fpga_ready_local;
   logic [0 : 0] sig_f2h_boot_from_fpga_on_failure_in;
   logic [0 : 0] sig_f2h_boot_from_fpga_on_failure_local;

   //--------------------------------------------------------------------------
   // =head1 Public Methods API
   // =pod
   // This section describes the public methods in the application programming
   // interface (API). The application program interface provides methods for 
   // a testbench which instantiates, controls and queries state in this BFM 
   // component. Test programs must only use these public access methods and 
   // events to communicate with this BFM component. The API and module pins
   // are the only interfaces of this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------
   
   event signal_input_f2h_boot_from_fpga_ready_change;
   event signal_input_f2h_boot_from_fpga_on_failure_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "15.0";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // f2h_boot_from_fpga_ready
   // -------------------------------------------------------
   function automatic ROLE_f2h_boot_from_fpga_ready_t get_f2h_boot_from_fpga_ready();
   
      // Gets the f2h_boot_from_fpga_ready input value.
      $sformat(message, "%m: called get_f2h_boot_from_fpga_ready");
      print(VERBOSITY_DEBUG, message);
      return sig_f2h_boot_from_fpga_ready_in;
      
   endfunction

   // -------------------------------------------------------
   // f2h_boot_from_fpga_on_failure
   // -------------------------------------------------------
   function automatic ROLE_f2h_boot_from_fpga_on_failure_t get_f2h_boot_from_fpga_on_failure();
   
      // Gets the f2h_boot_from_fpga_on_failure input value.
      $sformat(message, "%m: called get_f2h_boot_from_fpga_on_failure");
      print(VERBOSITY_DEBUG, message);
      return sig_f2h_boot_from_fpga_on_failure_in;
      
   endfunction

   assign sig_f2h_boot_from_fpga_ready_in = sig_f2h_boot_from_fpga_ready;
   assign sig_f2h_boot_from_fpga_on_failure_in = sig_f2h_boot_from_fpga_on_failure;


   always @(sig_f2h_boot_from_fpga_ready_in) begin
      if (sig_f2h_boot_from_fpga_ready_local != sig_f2h_boot_from_fpga_ready_in)
         -> signal_input_f2h_boot_from_fpga_ready_change;
      sig_f2h_boot_from_fpga_ready_local = sig_f2h_boot_from_fpga_ready_in;
   end
   
   always @(sig_f2h_boot_from_fpga_on_failure_in) begin
      if (sig_f2h_boot_from_fpga_on_failure_local != sig_f2h_boot_from_fpga_on_failure_in)
         -> signal_input_f2h_boot_from_fpga_on_failure_change;
      sig_f2h_boot_from_fpga_on_failure_local = sig_f2h_boot_from_fpga_on_failure_in;
   end
   


// synthesis translate_on

endmodule

