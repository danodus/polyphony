set PROJ_NAME polyphony_top
set PS_PROJ_NAME polyphony_ps
set PROJ_DIR ./zybo_top
set PS_PROJ_DIR ./zybo_ps
set RTL_ROOT_DIR ../../../rtl
set TOP_NAME zybo

create_project -force -part xc7z020clg400-1 zybo_top/${PROJ_NAME}
#set_property parent.project_path ${PROJ_DIR}/${PROJ_NAME}.xpr [current_project]
#get_property parent.project_path [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
get_property default_lib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:zybo-z7-20:part0:1.2 [current_project]
set_property ip_cache_permissions disable [current_project]
set_property vhdl_version vhdl_2k [current_fileset]

#add_files ${PROJ_DIR}/${PROJ_NAME}.srcs/sources_1/bd/zybo_base/zybo_base.bd

set bd [file normalize ${PS_PROJ_DIR}/${PS_PROJ_NAME}.srcs/sources_1/bd/zybo_base/zybo_base.bd]
read_bd ${bd}
set_property synth_checkpoint_mode None [get_files ${bd}]
generate_target -force all [get_files ${bd}]


set V_LIST "\
  ${RTL_ROOT_DIR}/include/polyphony_def.v \
  ${RTL_ROOT_DIR}/fm_cmn/fm_cmn_cinterface.v \
  ${RTL_ROOT_DIR}/fm_cmn/fm_cmn_dinterface.v \
  ${RTL_ROOT_DIR}/fm_cmn/fm_cmn_ififo.v \
  ${RTL_ROOT_DIR}/fm_mic/a_port_priority.v \
  ${RTL_ROOT_DIR}/fm_mic/a_port_unit.v \
  ${RTL_ROOT_DIR}/fm_hdmi/const_mult.v \
  ${RTL_ROOT_DIR}/fm_hdmi/csc.v \
  ${RTL_ROOT_DIR}/fm_hdmi/csc_top.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_def.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_color_blend.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_cu.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_cu_bselect.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_delay.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_f22_floor.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_f22_to_i8_2.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_f22_to_ui.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_f22_to_ui_b.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_f22_to_z.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_fadd.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_fcnv.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_fmul.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_frcp.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_frcp_rom.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_imul8.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_mu.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_mu_cache.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_mu_cache_ctrl.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_mu_cache_ctrl_ro.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_mu_cache_mem.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_mu_cache_ro.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_mu_cache_tag.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_mu_cif.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_mu_dif.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_mu_priority.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_norm.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_pu.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_outline.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_outline_edge.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_outline_edge_core.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_outline_edge_ctrl.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_outline_reg.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_outline_setup.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_outline_step.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_outline_step_core.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_outline_update.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_outline_update_core.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_span.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_span_delta.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_span_fragment.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_span_reg.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_span_setup.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_span_step.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_span_step_core.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_span_update.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_ru_span_update_core.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_tex_blend.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_tu.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_tu_etc.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_tu_etc_rom.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_vtx_dma.v \
  ${RTL_ROOT_DIR}/fm_3d/fm_3d_vtx_fifo.v \
  ${RTL_ROOT_DIR}/fm_hdmi/fm_444_422.v \
  ${RTL_ROOT_DIR}/fm_hvc/fm_afifo.v \
  ${RTL_ROOT_DIR}/fm_axi_m/fm_axi_m.v \
  ${RTL_ROOT_DIR}/fm_axi_m/fm_axi_monitor.v \
  ${RTL_ROOT_DIR}/fm_axi_m/fm_axi_monitor_b.v \
  ${RTL_ROOT_DIR}/fm_axi_m/fm_axi_monitor_r.v \
  ${RTL_ROOT_DIR}/fm_axi_m/fm_axi_monitor_vr.v \
  ${RTL_ROOT_DIR}/fm_axi_m/fm_axi_monitor_vw.v \
  ${RTL_ROOT_DIR}/fm_axi_s/fm_axi_s.v \
  ${RTL_ROOT_DIR}/fm_cmn/fm_cmn_bfifo.v \
  ${RTL_ROOT_DIR}/fm_cmn/fm_cmn_bram_01.v \
  ${RTL_ROOT_DIR}/fm_cmn/fm_cmn_bram_02.v \
  ${RTL_ROOT_DIR}/fm_cmn/fm_cmn_dram_01.v \
  ${RTL_ROOT_DIR}/fm_cmn/fm_cmn_if_ff_out.v \
  ${RTL_ROOT_DIR}/fm_rd/fm_dispatch.v \
  ${RTL_ROOT_DIR}/fm_rd/fm_dispatch_dma.v \
  ${RTL_ROOT_DIR}/fm_rd/fm_dma.v \
  ${RTL_ROOT_DIR}/fm_cmn/fm_fifo.v \
  ${RTL_ROOT_DIR}/fm_hdmi/fm_hdmi.v \
  ${RTL_ROOT_DIR}/fm_hvc/fm_hvc.v \
  ${RTL_ROOT_DIR}/fm_hvc/fm_hvc_aa_filter.v \
  ${RTL_ROOT_DIR}/fm_hvc/fm_hvc_aa_filter_core.v \
  ${RTL_ROOT_DIR}/fm_hvc/fm_hvc_core.v \
  ${RTL_ROOT_DIR}/fm_hvc/fm_hvc_data.v \
  ${RTL_ROOT_DIR}/fm_hvc/fm_hvc_dma.v \
  ${RTL_ROOT_DIR}/fm_hvc/fm_line_mem.v \
  ${RTL_ROOT_DIR}/fm_mic/fm_mic.v \
  ${RTL_ROOT_DIR}/fm_axi_m/fm_raw_fifo.v \
  ${RTL_ROOT_DIR}/fm_sys/fm_sys.v \
  ${RTL_ROOT_DIR}/pp_top.v \
  ../../rtl/${TOP_NAME}.v \
"
foreach i $V_LIST {
  read_verilog  -library xil_defaultlib ${i}
}


set XDC_LIST "\
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/ip/zybo_base_processing_system7_0_0/zybo_base_processing_system7_0_0.xdc \
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/ip/zybo_base_axi_gpio_btn_0/zybo_base_axi_gpio_btn_0_board.xdc \
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/ip/zybo_base_axi_gpio_btn_0/zybo_base_axi_gpio_btn_0_ooc.xdc \
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/ip/zybo_base_axi_gpio_btn_0/zybo_base_axi_gpio_btn_0.xdc \
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/ip/zybo_base_axi_gpio_led_0/zybo_base_axi_gpio_led_0_board.xdc \
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/ip/zybo_base_axi_gpio_led_0/zybo_base_axi_gpio_led_0_ooc.xdc \
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/ip/zybo_base_axi_gpio_led_0/zybo_base_axi_gpio_led_0.xdc \
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/ip/zybo_base_axi_gpio_sw_0/zybo_base_axi_gpio_sw_0_board.xdc \
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/ip/zybo_base_axi_gpio_sw_0/zybo_base_axi_gpio_sw_0_ooc.xdc \
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/ip/zybo_base_axi_gpio_sw_0/zybo_base_axi_gpio_sw_0.xdc \
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/ip/zybo_base_rst_ps7_0_50M_0/zybo_base_rst_ps7_0_50M_0_board.xdc \
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/ip/zybo_base_rst_ps7_0_50M_0/zybo_base_rst_ps7_0_50M_0.xdc \
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/ip/zybo_base_axi_protocol_convert_0_0/zybo_base_axi_protocol_convert_0_0_ooc.xdc\
  ${PS_PROJ_DIR}/${PS_PROJ_NAME}.gen/sources_1/bd/zybo_base/zybo_base_ooc.xdc \
"

foreach i $XDC_LIST {
  set_property used_in_implementation false [get_files -all ${i} ]
}

read_xdc user_const.xdc
set_property used_in_implementation false [get_files user_const.xdc]

#read_xdc dont_touch.xdc
#set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top ${TOP_NAME} -part xc7z020clg400-1 -verilog_define PP_BUSWIDTH_64=1 -include_dirs { ../../../rtl/include ../../../rtl/fm_3d }  \
-flatten_hierarchy rebuilt \
-bufg 12 \
-fanout_limit 10000 \
-directive PerformanceOptimized \
-fsm_extraction one_hot \
-resource_sharing off \
-no_lc

report_timing_summary -file ${TOP_NAME}_timing_synth.rpt
report_utilization -file ${TOP_NAME}_utilization_synth.rpt
write_checkpoint -force -noxdef ${TOP_NAME}.dcp

