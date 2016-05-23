
# (C) 2001-2016 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 15.0 145 win32 2016.03.13.17:11:34

# ----------------------------------------
# Auto-generated simulation script

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "QSYS_lab4"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "C:/altera/15.0/quartus/"
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

set Aldec "Riviera"
if { [ string match "*Active-HDL*" [ vsim -version ] ] } {
  set Aldec "Active"
}

if { [ string match "Active" $Aldec ] } {
  scripterconf -tcl
  createdesign "$TOP_LEVEL_NAME"  "."
  opendesign "$TOP_LEVEL_NAME"
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib      ./libraries     
ensure_lib      ./libraries/work
vmap       work ./libraries/work
ensure_lib                       ./libraries/altera_ver           
vmap       altera_ver            ./libraries/altera_ver           
ensure_lib                       ./libraries/lpm_ver              
vmap       lpm_ver               ./libraries/lpm_ver              
ensure_lib                       ./libraries/sgate_ver            
vmap       sgate_ver             ./libraries/sgate_ver            
ensure_lib                       ./libraries/altera_mf_ver        
vmap       altera_mf_ver         ./libraries/altera_mf_ver        
ensure_lib                       ./libraries/altera_lnsim_ver     
vmap       altera_lnsim_ver      ./libraries/altera_lnsim_ver     
ensure_lib                       ./libraries/cyclonev_ver         
vmap       cyclonev_ver          ./libraries/cyclonev_ver         
ensure_lib                       ./libraries/cyclonev_hssi_ver    
vmap       cyclonev_hssi_ver     ./libraries/cyclonev_hssi_ver    
ensure_lib                       ./libraries/cyclonev_pcie_hip_ver
vmap       cyclonev_pcie_hip_ver ./libraries/cyclonev_pcie_hip_ver
ensure_lib                                           ./libraries/altera_common_sv_packages                
vmap       altera_common_sv_packages                 ./libraries/altera_common_sv_packages                
ensure_lib                                           ./libraries/error_adapter_0                          
vmap       error_adapter_0                           ./libraries/error_adapter_0                          
ensure_lib                                           ./libraries/border                                   
vmap       border                                    ./libraries/border                                   
ensure_lib                                           ./libraries/avalon_st_adapter                        
vmap       avalon_st_adapter                         ./libraries/avalon_st_adapter                        
ensure_lib                                           ./libraries/crosser                                  
vmap       crosser                                   ./libraries/crosser                                  
ensure_lib                                           ./libraries/rsp_mux                                  
vmap       rsp_mux                                   ./libraries/rsp_mux                                  
ensure_lib                                           ./libraries/rsp_demux_001                            
vmap       rsp_demux_001                             ./libraries/rsp_demux_001                            
ensure_lib                                           ./libraries/rsp_demux                                
vmap       rsp_demux                                 ./libraries/rsp_demux                                
ensure_lib                                           ./libraries/cmd_mux                                  
vmap       cmd_mux                                   ./libraries/cmd_mux                                  
ensure_lib                                           ./libraries/cmd_demux                                
vmap       cmd_demux                                 ./libraries/cmd_demux                                
ensure_lib                                           ./libraries/router_002                               
vmap       router_002                                ./libraries/router_002                               
ensure_lib                                           ./libraries/router                                   
vmap       router                                    ./libraries/router                                   
ensure_lib                                           ./libraries/hps_0_h2f_axi_master_wr_rsp_width_adapter
vmap       hps_0_h2f_axi_master_wr_rsp_width_adapter ./libraries/hps_0_h2f_axi_master_wr_rsp_width_adapter
ensure_lib                                           ./libraries/router_003                               
vmap       router_003                                ./libraries/router_003                               
ensure_lib                                           ./libraries/SDRAM_s1_agent_rsp_fifo                  
vmap       SDRAM_s1_agent_rsp_fifo                   ./libraries/SDRAM_s1_agent_rsp_fifo                  
ensure_lib                                           ./libraries/SDRAM_s1_agent                           
vmap       SDRAM_s1_agent                            ./libraries/SDRAM_s1_agent                           
ensure_lib                                           ./libraries/hps_0_h2f_axi_master_agent               
vmap       hps_0_h2f_axi_master_agent                ./libraries/hps_0_h2f_axi_master_agent               
ensure_lib                                           ./libraries/SDRAM_s1_translator                      
vmap       SDRAM_s1_translator                       ./libraries/SDRAM_s1_translator                      
ensure_lib                                           ./libraries/hps_0_f2h_axi_slave_wr_burst_adapter     
vmap       hps_0_f2h_axi_slave_wr_burst_adapter      ./libraries/hps_0_f2h_axi_slave_wr_burst_adapter     
ensure_lib                                           ./libraries/alt_vip_vfr_0_avalon_master_limiter      
vmap       alt_vip_vfr_0_avalon_master_limiter       ./libraries/alt_vip_vfr_0_avalon_master_limiter      
ensure_lib                                           ./libraries/router_001                               
vmap       router_001                                ./libraries/router_001                               
ensure_lib                                           ./libraries/hps_0_f2h_axi_slave_agent                
vmap       hps_0_f2h_axi_slave_agent                 ./libraries/hps_0_f2h_axi_slave_agent                
ensure_lib                                           ./libraries/alt_vip_vfr_0_avalon_master_agent        
vmap       alt_vip_vfr_0_avalon_master_agent         ./libraries/alt_vip_vfr_0_avalon_master_agent        
ensure_lib                                           ./libraries/alt_vip_vfr_0_avalon_master_translator   
vmap       alt_vip_vfr_0_avalon_master_translator    ./libraries/alt_vip_vfr_0_avalon_master_translator   
ensure_lib                                           ./libraries/reset_from_locked                        
vmap       reset_from_locked                         ./libraries/reset_from_locked                        
ensure_lib                                           ./libraries/sys_pll                                  
vmap       sys_pll                                   ./libraries/sys_pll                                  
ensure_lib                                           ./libraries/hps_io                                   
vmap       hps_io                                    ./libraries/hps_io                                   
ensure_lib                                           ./libraries/fpga_interfaces                          
vmap       fpga_interfaces                           ./libraries/fpga_interfaces                          
ensure_lib                                           ./libraries/rst_controller                           
vmap       rst_controller                            ./libraries/rst_controller                           
ensure_lib                                           ./libraries/irq_mapper_001                           
vmap       irq_mapper_001                            ./libraries/irq_mapper_001                           
ensure_lib                                           ./libraries/irq_mapper                               
vmap       irq_mapper                                ./libraries/irq_mapper                               
ensure_lib                                           ./libraries/mm_interconnect_2                        
vmap       mm_interconnect_2                         ./libraries/mm_interconnect_2                        
ensure_lib                                           ./libraries/mm_interconnect_1                        
vmap       mm_interconnect_1                         ./libraries/mm_interconnect_1                        
ensure_lib                                           ./libraries/mm_interconnect_0                        
vmap       mm_interconnect_0                         ./libraries/mm_interconnect_0                        
ensure_lib                                           ./libraries/sysid_qsys_0                             
vmap       sysid_qsys_0                              ./libraries/sysid_qsys_0                             
ensure_lib                                           ./libraries/sys_sdram_pll_0                          
vmap       sys_sdram_pll_0                           ./libraries/sys_sdram_pll_0                          
ensure_lib                                           ./libraries/switches                                 
vmap       switches                                  ./libraries/switches                                 
ensure_lib                                           ./libraries/sdram_master_0                           
vmap       sdram_master_0                            ./libraries/sdram_master_0                           
ensure_lib                                           ./libraries/ready_from_HPS                           
vmap       ready_from_HPS                            ./libraries/ready_from_HPS                           
ensure_lib                                           ./libraries/pll_1                                    
vmap       pll_1                                     ./libraries/pll_1                                    
ensure_lib                                           ./libraries/pll_0                                    
vmap       pll_0                                     ./libraries/pll_0                                    
ensure_lib                                           ./libraries/leds                                     
vmap       leds                                      ./libraries/leds                                     
ensure_lib                                           ./libraries/jtag_uart_0                              
vmap       jtag_uart_0                               ./libraries/jtag_uart_0                              
ensure_lib                                           ./libraries/hps_0                                    
vmap       hps_0                                     ./libraries/hps_0                                    
ensure_lib                                           ./libraries/done_from_sdram_master                   
vmap       done_from_sdram_master                    ./libraries/done_from_sdram_master                   
ensure_lib                                           ./libraries/alt_vip_vfr_0                            
vmap       alt_vip_vfr_0                             ./libraries/alt_vip_vfr_0                            
ensure_lib                                           ./libraries/alt_vip_itc_0                            
vmap       alt_vip_itc_0                             ./libraries/alt_vip_itc_0                            
ensure_lib                                           ./libraries/SDRAM                                    
vmap       SDRAM                                     ./libraries/SDRAM                                    

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  vlog -v2k5 "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                    -work altera_ver           
  vlog -v2k5 "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                             -work lpm_ver              
  vlog -v2k5 "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                -work sgate_ver            
  vlog -v2k5 "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                            -work altera_mf_ver        
  vlog       "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                        -work altera_lnsim_ver     
  vlog -v2k5 "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
  vlog -v2k5 "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
  vlog -v2k5 "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                       -work cyclonev_ver         
  vlog -v2k5 "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
  vlog -v2k5 "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                  -work cyclonev_hssi_ver    
  vlog -v2k5 "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
  vlog -v2k5 "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"              -work cyclonev_pcie_hip_ver
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  vlog       "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                                              -work altera_common_sv_packages                
  vlog       "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                                                       -work altera_common_sv_packages                
  vlog       "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                                                              -work altera_common_sv_packages                
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_avalon_st_adapter_error_adapter_0.sv" -l altera_common_sv_packages -work error_adapter_0                          
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_avalon_st_adapter_error_adapter_0.sv" -l altera_common_sv_packages -work error_adapter_0                          
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                    -l altera_common_sv_packages -work border                                   
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                  -l altera_common_sv_packages -work border                                   
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                    -l altera_common_sv_packages -work border                                   
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                    -l altera_common_sv_packages -work border                                   
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0_hps_io_border_memory.sv"                          -l altera_common_sv_packages -work border                                   
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0_hps_io_border_hps_io.sv"                          -l altera_common_sv_packages -work border                                   
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0_hps_io_border.sv"                                 -l altera_common_sv_packages -work border                                   
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_avalon_st_adapter.v"                                               -work avalon_st_adapter                        
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_st_handshake_clock_crosser.v"                       -l altera_common_sv_packages -work crosser                                  
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_st_clock_crosser.v"                                 -l altera_common_sv_packages -work crosser                                  
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                 -l altera_common_sv_packages -work crosser                                  
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                      -l altera_common_sv_packages -work rsp_mux                                  
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_rsp_mux.sv"                           -l altera_common_sv_packages -work rsp_mux                                  
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_rsp_demux_001.sv"                     -l altera_common_sv_packages -work rsp_demux_001                            
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_rsp_demux.sv"                         -l altera_common_sv_packages -work rsp_demux                                
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                      -l altera_common_sv_packages -work cmd_mux                                  
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_cmd_mux.sv"                           -l altera_common_sv_packages -work cmd_mux                                  
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_cmd_demux.sv"                         -l altera_common_sv_packages -work cmd_demux                                
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_router_002.sv"                        -l altera_common_sv_packages -work router_002                               
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_router.sv"                            -l altera_common_sv_packages -work router                                   
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_avalon_st_adapter.v"                                               -work avalon_st_adapter                        
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_width_adapter.sv"                                   -l altera_common_sv_packages -work hps_0_h2f_axi_master_wr_rsp_width_adapter
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                               -l altera_common_sv_packages -work hps_0_h2f_axi_master_wr_rsp_width_adapter
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                              -l altera_common_sv_packages -work hps_0_h2f_axi_master_wr_rsp_width_adapter
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                      -l altera_common_sv_packages -work rsp_mux                                  
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_rsp_mux.sv"                           -l altera_common_sv_packages -work rsp_mux                                  
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_rsp_demux.sv"                         -l altera_common_sv_packages -work rsp_demux                                
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                      -l altera_common_sv_packages -work cmd_mux                                  
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_cmd_mux.sv"                           -l altera_common_sv_packages -work cmd_mux                                  
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_cmd_demux.sv"                         -l altera_common_sv_packages -work cmd_demux                                
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_router_003.sv"                        -l altera_common_sv_packages -work router_003                               
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_router_002.sv"                        -l altera_common_sv_packages -work router_002                               
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_router.sv"                            -l altera_common_sv_packages -work router                                   
  vlog -v2k5 "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                       -work SDRAM_s1_agent_rsp_fifo                  
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                     -l altera_common_sv_packages -work SDRAM_s1_agent                           
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                              -l altera_common_sv_packages -work SDRAM_s1_agent                           
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_axi_master_ni.sv"                                   -l altera_common_sv_packages -work hps_0_h2f_axi_master_agent               
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                               -l altera_common_sv_packages -work hps_0_h2f_axi_master_agent               
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                -l altera_common_sv_packages -work SDRAM_s1_translator                      
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                      -l altera_common_sv_packages -work rsp_mux                                  
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0_rsp_mux.sv"                           -l altera_common_sv_packages -work rsp_mux                                  
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0_rsp_demux.sv"                         -l altera_common_sv_packages -work rsp_demux                                
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                      -l altera_common_sv_packages -work cmd_mux                                  
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0_cmd_mux.sv"                           -l altera_common_sv_packages -work cmd_mux                                  
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0_cmd_demux.sv"                         -l altera_common_sv_packages -work cmd_demux                                
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                   -l altera_common_sv_packages -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv"                            -l altera_common_sv_packages -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                              -l altera_common_sv_packages -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                               -l altera_common_sv_packages -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlog       "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                   -l altera_common_sv_packages -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlog       "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                   -l altera_common_sv_packages -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlog       "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                                -l altera_common_sv_packages -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                               -l altera_common_sv_packages -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                               -l altera_common_sv_packages -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                 -l altera_common_sv_packages -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"                                 -l altera_common_sv_packages -work alt_vip_vfr_0_avalon_master_limiter      
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"                                  -l altera_common_sv_packages -work alt_vip_vfr_0_avalon_master_limiter      
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                          -l altera_common_sv_packages -work alt_vip_vfr_0_avalon_master_limiter      
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                 -l altera_common_sv_packages -work alt_vip_vfr_0_avalon_master_limiter      
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0_router_001.sv"                        -l altera_common_sv_packages -work router_001                               
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0_router.sv"                            -l altera_common_sv_packages -work router                                   
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_axi_slave_ni.sv"                                    -l altera_common_sv_packages -work hps_0_f2h_axi_slave_agent                
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                              -l altera_common_sv_packages -work hps_0_f2h_axi_slave_agent                
  vlog -v2k5 "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                                       -work hps_0_f2h_axi_slave_agent                
  vlog -v2k5 "$QSYS_SIMDIR/submodules/credit_producer.v"                                                                             -work hps_0_f2h_axi_slave_agent                
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                               -l altera_common_sv_packages -work hps_0_f2h_axi_slave_agent                
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                    -l altera_common_sv_packages -work alt_vip_vfr_0_avalon_master_agent        
  vlog       "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                               -l altera_common_sv_packages -work alt_vip_vfr_0_avalon_master_translator   
  vlog -v2k5 "$QSYS_SIMDIR/submodules/altera_up_avalon_reset_from_locked_signal.v"                                                   -work reset_from_locked                        
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_sys_sdram_pll_0_sys_pll.vo"                                                          -work sys_pll                                  
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0_hps_io.v"                                                                      -work hps_io                                   
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                    -l altera_common_sv_packages -work fpga_interfaces                          
  vlog       "$QSYS_SIMDIR/submodules/questa_mvc_svapi.svh"                                             -l altera_common_sv_packages -work fpga_interfaces                          
  vlog       "$QSYS_SIMDIR/submodules/mgc_common_axi.sv"                                                -l altera_common_sv_packages -work fpga_interfaces                          
  vlog       "$QSYS_SIMDIR/submodules/mgc_axi_master.sv"                                                -l altera_common_sv_packages -work fpga_interfaces                          
  vlog       "$QSYS_SIMDIR/submodules/mgc_axi_slave.sv"                                                 -l altera_common_sv_packages -work fpga_interfaces                          
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                  -l altera_common_sv_packages -work fpga_interfaces                          
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                    -l altera_common_sv_packages -work fpga_interfaces                          
  vlog       "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                    -l altera_common_sv_packages -work fpga_interfaces                          
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0_fpga_interfaces_f2h_boot_from_fpga.sv"            -l altera_common_sv_packages -work fpga_interfaces                          
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0_fpga_interfaces.sv"                               -l altera_common_sv_packages -work fpga_interfaces                          
  vlog -v2k5 "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                                     -work rst_controller                           
  vlog -v2k5 "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                                   -work rst_controller                           
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_irq_mapper_001.sv"                                      -l altera_common_sv_packages -work irq_mapper_001                           
  vlog       "$QSYS_SIMDIR/submodules/QSYS_lab4_irq_mapper.sv"                                          -l altera_common_sv_packages -work irq_mapper                               
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2.v"                                                                 -work mm_interconnect_2                        
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1.v"                                                                 -work mm_interconnect_1                        
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0.v"                                                                 -work mm_interconnect_0                        
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_sysid_qsys_0.vo"                                                                     -work sysid_qsys_0                             
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_sys_sdram_pll_0.v"                                                                   -work sys_sdram_pll_0                          
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_switches.v"                                                                          -work switches                                 
  vlog -v2k5 "$QSYS_SIMDIR/submodules/sdram_master_reduced_fsm.v"                                                                    -work sdram_master_0                           
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_ready_from_HPS.v"                                                                    -work ready_from_HPS                           
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_pll_1.vo"                                                                            -work pll_1                                    
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_pll_0.vo"                                                                            -work pll_0                                    
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_leds.v"                                                                              -work leds                                     
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_jtag_uart_0.v"                                                                       -work jtag_uart_0                              
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0.v"                                                                             -work hps_0                                    
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_done_from_sdram_master.v"                                                            -work done_from_sdram_master                   
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_alt_vip_vfr_0.vo"                                                                    -work alt_vip_vfr_0                            
  vlog       "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid.sv"                                          -l altera_common_sv_packages -work alt_vip_itc_0                            
  vlog -v2k5 "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_sync_compare.v"                                                           -work alt_vip_itc_0                            
  vlog -v2k5 "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_calculate_mode.v"                                                         -work alt_vip_itc_0                            
  vlog -v2k5 "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_control.v"                                                                -work alt_vip_itc_0                            
  vlog       "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_mode_banks.sv"                               -l altera_common_sv_packages -work alt_vip_itc_0                            
  vlog -v2k5 "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_statemachine.v"                                                           -work alt_vip_itc_0                            
  vlog -v2k5 "$QSYS_SIMDIR/submodules/alt_vipitc131_common_fifo.v"                                                                   -work alt_vip_itc_0                            
  vlog -v2k5 "$QSYS_SIMDIR/submodules/alt_vipitc131_common_generic_count.v"                                                          -work alt_vip_itc_0                            
  vlog -v2k5 "$QSYS_SIMDIR/submodules/alt_vipitc131_common_to_binary.v"                                                              -work alt_vip_itc_0                            
  vlog -v2k5 "$QSYS_SIMDIR/submodules/alt_vipitc131_common_sync.v"                                                                   -work alt_vip_itc_0                            
  vlog -v2k5 "$QSYS_SIMDIR/submodules/alt_vipitc131_common_trigger_sync.v"                                                           -work alt_vip_itc_0                            
  vlog -v2k5 "$QSYS_SIMDIR/submodules/alt_vipitc131_common_sync_generation.v"                                                        -work alt_vip_itc_0                            
  vlog -v2k5 "$QSYS_SIMDIR/submodules/alt_vipitc131_common_frame_counter.v"                                                          -work alt_vip_itc_0                            
  vlog -v2k5 "$QSYS_SIMDIR/submodules/alt_vipitc131_common_sample_counter.v"                                                         -work alt_vip_itc_0                            
  vlog -v2k5 "$QSYS_SIMDIR/submodules/QSYS_lab4_SDRAM.v"                                                                             -work SDRAM                                    
  vlog -v2k5 "$QSYS_SIMDIR/QSYS_lab4.v"                                                                                                                                             
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim +access +r -t ps $ELAB_OPTIONS -L work -L altera_common_sv_packages -L error_adapter_0 -L border -L avalon_st_adapter -L crosser -L rsp_mux -L rsp_demux_001 -L rsp_demux -L cmd_mux -L cmd_demux -L router_002 -L router -L hps_0_h2f_axi_master_wr_rsp_width_adapter -L router_003 -L SDRAM_s1_agent_rsp_fifo -L SDRAM_s1_agent -L hps_0_h2f_axi_master_agent -L SDRAM_s1_translator -L hps_0_f2h_axi_slave_wr_burst_adapter -L alt_vip_vfr_0_avalon_master_limiter -L router_001 -L hps_0_f2h_axi_slave_agent -L alt_vip_vfr_0_avalon_master_agent -L alt_vip_vfr_0_avalon_master_translator -L reset_from_locked -L sys_pll -L hps_io -L fpga_interfaces -L rst_controller -L irq_mapper_001 -L irq_mapper -L mm_interconnect_2 -L mm_interconnect_1 -L mm_interconnect_0 -L sysid_qsys_0 -L sys_sdram_pll_0 -L switches -L sdram_master_0 -L ready_from_HPS -L pll_1 -L pll_0 -L leds -L jtag_uart_0 -L hps_0 -L done_from_sdram_master -L alt_vip_vfr_0 -L alt_vip_itc_0 -L SDRAM -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with -dbg -O2 option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -dbg -O2 +access +r -t ps $ELAB_OPTIONS -L work -L altera_common_sv_packages -L error_adapter_0 -L border -L avalon_st_adapter -L crosser -L rsp_mux -L rsp_demux_001 -L rsp_demux -L cmd_mux -L cmd_demux -L router_002 -L router -L hps_0_h2f_axi_master_wr_rsp_width_adapter -L router_003 -L SDRAM_s1_agent_rsp_fifo -L SDRAM_s1_agent -L hps_0_h2f_axi_master_agent -L SDRAM_s1_translator -L hps_0_f2h_axi_slave_wr_burst_adapter -L alt_vip_vfr_0_avalon_master_limiter -L router_001 -L hps_0_f2h_axi_slave_agent -L alt_vip_vfr_0_avalon_master_agent -L alt_vip_vfr_0_avalon_master_translator -L reset_from_locked -L sys_pll -L hps_io -L fpga_interfaces -L rst_controller -L irq_mapper_001 -L irq_mapper -L mm_interconnect_2 -L mm_interconnect_1 -L mm_interconnect_0 -L sysid_qsys_0 -L sys_sdram_pll_0 -L switches -L sdram_master_0 -L ready_from_HPS -L pll_1 -L pll_0 -L leds -L jtag_uart_0 -L hps_0 -L done_from_sdram_master -L alt_vip_vfr_0 -L alt_vip_itc_0 -L SDRAM -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -dbg -O2
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with -dbg -O2 option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -dbg -O2"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
}
file_copy
h
