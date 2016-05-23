
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
# vcsmx - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="QSYS_lab4"
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="C:/altera/15.0/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="+vcs+finish+100"

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_ELAB=1 SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# initialize simulation properties - DO NOT MODIFY!
ELAB_OPTIONS=""
SIM_OPTIONS=""
if [[ `vcs -platform` != *"amd64"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/altera_common_sv_packages/
mkdir -p ./libraries/error_adapter_0/
mkdir -p ./libraries/border/
mkdir -p ./libraries/avalon_st_adapter/
mkdir -p ./libraries/crosser/
mkdir -p ./libraries/rsp_mux/
mkdir -p ./libraries/rsp_demux_001/
mkdir -p ./libraries/rsp_demux/
mkdir -p ./libraries/cmd_mux/
mkdir -p ./libraries/cmd_demux/
mkdir -p ./libraries/router_002/
mkdir -p ./libraries/router/
mkdir -p ./libraries/hps_0_h2f_axi_master_wr_rsp_width_adapter/
mkdir -p ./libraries/router_003/
mkdir -p ./libraries/SDRAM_s1_agent_rsp_fifo/
mkdir -p ./libraries/SDRAM_s1_agent/
mkdir -p ./libraries/hps_0_h2f_axi_master_agent/
mkdir -p ./libraries/SDRAM_s1_translator/
mkdir -p ./libraries/hps_0_f2h_axi_slave_wr_burst_adapter/
mkdir -p ./libraries/alt_vip_vfr_0_avalon_master_limiter/
mkdir -p ./libraries/router_001/
mkdir -p ./libraries/hps_0_f2h_axi_slave_agent/
mkdir -p ./libraries/alt_vip_vfr_0_avalon_master_agent/
mkdir -p ./libraries/alt_vip_vfr_0_avalon_master_translator/
mkdir -p ./libraries/reset_from_locked/
mkdir -p ./libraries/sys_pll/
mkdir -p ./libraries/hps_io/
mkdir -p ./libraries/fpga_interfaces/
mkdir -p ./libraries/rst_controller/
mkdir -p ./libraries/irq_mapper_001/
mkdir -p ./libraries/irq_mapper/
mkdir -p ./libraries/mm_interconnect_2/
mkdir -p ./libraries/mm_interconnect_1/
mkdir -p ./libraries/mm_interconnect_0/
mkdir -p ./libraries/sysid_qsys_0/
mkdir -p ./libraries/sys_sdram_pll_0/
mkdir -p ./libraries/switches/
mkdir -p ./libraries/sdram_master_0/
mkdir -p ./libraries/ready_from_HPS/
mkdir -p ./libraries/pll_1/
mkdir -p ./libraries/pll_0/
mkdir -p ./libraries/leds/
mkdir -p ./libraries/jtag_uart_0/
mkdir -p ./libraries/hps_0/
mkdir -p ./libraries/done_from_sdram_master/
mkdir -p ./libraries/alt_vip_vfr_0/
mkdir -p ./libraries/alt_vip_itc_0/
mkdir -p ./libraries/SDRAM/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/cyclonev_ver/
mkdir -p ./libraries/cyclonev_hssi_ver/
mkdir -p ./libraries/cyclonev_pcie_hip_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                       -work altera_ver           
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                                -work lpm_ver              
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                   -work sgate_ver            
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                               -work altera_mf_ver        
  vlogan +v2k -sverilog "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                           -work altera_lnsim_ver     
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                          -work cyclonev_ver         
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                     -work cyclonev_hssi_ver    
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"                 -work cyclonev_pcie_hip_ver
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                 -work altera_common_sv_packages                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                          -work altera_common_sv_packages                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                                 -work altera_common_sv_packages                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_avalon_st_adapter_error_adapter_0.sv" -work error_adapter_0                          
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_avalon_st_adapter_error_adapter_0.sv" -work error_adapter_0                          
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                    -work border                                   
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                  -work border                                   
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                    -work border                                   
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                    -work border                                   
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0_hps_io_border_memory.sv"                          -work border                                   
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0_hps_io_border_hps_io.sv"                          -work border                                   
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0_hps_io_border.sv"                                 -work border                                   
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_avalon_st_adapter.v"                  -work avalon_st_adapter                        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_st_handshake_clock_crosser.v"                       -work crosser                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_st_clock_crosser.v"                                 -work crosser                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                 -work crosser                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                      -work rsp_mux                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_rsp_mux.sv"                           -work rsp_mux                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_rsp_demux_001.sv"                     -work rsp_demux_001                            
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_rsp_demux.sv"                         -work rsp_demux                                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                      -work cmd_mux                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_cmd_mux.sv"                           -work cmd_mux                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_cmd_demux.sv"                         -work cmd_demux                                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_router_002.sv"                        -work router_002                               
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2_router.sv"                            -work router                                   
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_avalon_st_adapter.v"                  -work avalon_st_adapter                        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_width_adapter.sv"                                   -work hps_0_h2f_axi_master_wr_rsp_width_adapter
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                               -work hps_0_h2f_axi_master_wr_rsp_width_adapter
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                              -work hps_0_h2f_axi_master_wr_rsp_width_adapter
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                      -work rsp_mux                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_rsp_mux.sv"                           -work rsp_mux                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_rsp_demux.sv"                         -work rsp_demux                                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                      -work cmd_mux                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_cmd_mux.sv"                           -work cmd_mux                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_cmd_demux.sv"                         -work cmd_demux                                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_router_003.sv"                        -work router_003                               
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_router_002.sv"                        -work router_002                               
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1_router.sv"                            -work router                                   
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                          -work SDRAM_s1_agent_rsp_fifo                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                     -work SDRAM_s1_agent                           
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                              -work SDRAM_s1_agent                           
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_axi_master_ni.sv"                                   -work hps_0_h2f_axi_master_agent               
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                               -work hps_0_h2f_axi_master_agent               
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                -work SDRAM_s1_translator                      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                      -work rsp_mux                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0_rsp_mux.sv"                           -work rsp_mux                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0_rsp_demux.sv"                         -work rsp_demux                                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                      -work cmd_mux                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0_cmd_mux.sv"                           -work cmd_mux                                  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0_cmd_demux.sv"                         -work cmd_demux                                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                   -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv"                            -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                              -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                               -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                   -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                   -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                                -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                               -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                               -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                 -work hps_0_f2h_axi_slave_wr_burst_adapter     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"                                 -work alt_vip_vfr_0_avalon_master_limiter      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"                                  -work alt_vip_vfr_0_avalon_master_limiter      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                          -work alt_vip_vfr_0_avalon_master_limiter      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                 -work alt_vip_vfr_0_avalon_master_limiter      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0_router_001.sv"                        -work router_001                               
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0_router.sv"                            -work router                                   
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_axi_slave_ni.sv"                                    -work hps_0_f2h_axi_slave_agent                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                              -work hps_0_f2h_axi_slave_agent                
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                          -work hps_0_f2h_axi_slave_agent                
  vlogan +v2k           "$QSYS_SIMDIR/submodules/credit_producer.v"                                                -work hps_0_f2h_axi_slave_agent                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                               -work hps_0_f2h_axi_slave_agent                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                    -work alt_vip_vfr_0_avalon_master_agent        
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                               -work alt_vip_vfr_0_avalon_master_translator   
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_up_avalon_reset_from_locked_signal.v"                      -work reset_from_locked                        
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_sys_sdram_pll_0_sys_pll.vo"                             -work sys_pll                                  
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0_hps_io.v"                                         -work hps_io                                   
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                    -work fpga_interfaces                          
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/questa_mvc_svapi.svh"                                             -work fpga_interfaces                          
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/mgc_common_axi.sv"                                                -work fpga_interfaces                          
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/mgc_axi_master.sv"                                                -work fpga_interfaces                          
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/mgc_axi_slave.sv"                                                 -work fpga_interfaces                          
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_interrupt_sink.sv"                                  -work fpga_interfaces                          
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_clock_source.sv"                                    -work fpga_interfaces                          
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_reset_source.sv"                                    -work fpga_interfaces                          
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0_fpga_interfaces_f2h_boot_from_fpga.sv"            -work fpga_interfaces                          
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0_fpga_interfaces.sv"                               -work fpga_interfaces                          
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                        -work rst_controller                           
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                      -work rst_controller                           
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_irq_mapper_001.sv"                                      -work irq_mapper_001                           
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/QSYS_lab4_irq_mapper.sv"                                          -work irq_mapper                               
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_2.v"                                    -work mm_interconnect_2                        
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_1.v"                                    -work mm_interconnect_1                        
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_mm_interconnect_0.v"                                    -work mm_interconnect_0                        
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_sysid_qsys_0.vo"                                        -work sysid_qsys_0                             
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_sys_sdram_pll_0.v"                                      -work sys_sdram_pll_0                          
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_switches.v"                                             -work switches                                 
  vlogan +v2k           "$QSYS_SIMDIR/submodules/sdram_master_reduced_fsm.v"                                       -work sdram_master_0                           
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_ready_from_HPS.v"                                       -work ready_from_HPS                           
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_pll_1.vo"                                               -work pll_1                                    
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_pll_0.vo"                                               -work pll_0                                    
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_leds.v"                                                 -work leds                                     
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_jtag_uart_0.v"                                          -work jtag_uart_0                              
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_hps_0.v"                                                -work hps_0                                    
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_done_from_sdram_master.v"                               -work done_from_sdram_master                   
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_alt_vip_vfr_0.vo"                                       -work alt_vip_vfr_0                            
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid.sv"                                          -work alt_vip_itc_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_sync_compare.v"                              -work alt_vip_itc_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_calculate_mode.v"                            -work alt_vip_itc_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_control.v"                                   -work alt_vip_itc_0                            
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_mode_banks.sv"                               -work alt_vip_itc_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_statemachine.v"                              -work alt_vip_itc_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/alt_vipitc131_common_fifo.v"                                      -work alt_vip_itc_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/alt_vipitc131_common_generic_count.v"                             -work alt_vip_itc_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/alt_vipitc131_common_to_binary.v"                                 -work alt_vip_itc_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/alt_vipitc131_common_sync.v"                                      -work alt_vip_itc_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/alt_vipitc131_common_trigger_sync.v"                              -work alt_vip_itc_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/alt_vipitc131_common_sync_generation.v"                           -work alt_vip_itc_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/alt_vipitc131_common_frame_counter.v"                             -work alt_vip_itc_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/alt_vipitc131_common_sample_counter.v"                            -work alt_vip_itc_0                            
  vlogan +v2k           "$QSYS_SIMDIR/submodules/QSYS_lab4_SDRAM.v"                                                -work SDRAM                                    
  vlogan +v2k           "$QSYS_SIMDIR/QSYS_lab4.v"                                                                                                                
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  vcs -lca -t ps $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS
fi
