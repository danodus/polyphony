module top(
    input wire logic                  clk,
    input wire logic                  reset_i,

    output logic vga_hsync,
    output logic vga_vsync,
    output logic [3:0] vga_r,
    output logic [3:0] vga_g,
    output logic [3:0] vga_b    
);

    pp_top pp_top (
    // system
    .clk_core(clk),
    .rst_x(~reset_i),
    .o_int(),
    .o_debug(),
    // AXI Slave
    //   write port
    .i_awid_s(),
    .i_awaddr_s(),
    .i_awlen_s(),
    .i_awsize_s(),
    .i_awburst_s(),
    .i_awlock_s(),
    .i_awcache_s(),
    .i_awprot_s(),
    .i_awvalid_s(),
    .o_awready_s(),
    .i_wid_s(),
    .i_wdata_s(),
    .i_wstrb_s(),
    .i_wlast_s(),
    .i_wvalid_s(),
    .o_wready_s(),
    .o_bid_s(),
    .o_bresp_s(),
    .o_bvalid_s(),
    .i_bready_s(),
    //   read port
    .i_arid_s(),
    .i_araddr_s(),
    .i_arlen_s(),
    .i_arsize_s(),
    .i_arburst_s(),
    .i_arlock_s(),
    .i_arcache_s(),
    .i_arprot_s(),
    .i_arvalid_s(),
    .o_arready_s(),
    .o_rid_s(),
    .o_rdata_s(),
    .o_rresp_s(),
    .o_rlast_s(),
    .o_rvalid_s(),
    .i_rready_s(),
    // AXI Master
    .o_awid_m(),
    .o_awaddr_m(),
    .o_awlen_m(),
    .o_awsize_m(),
    .o_awburst_m(),
    .o_awlock_m(),
    .o_awcache_m(),
    .o_awuser_m(),
    .o_awprot_m(),
    .o_awvalid_m(),
    .i_awready_m(),
    .o_wid_m(),
    .o_wdata_m(),
    .o_wstrb_m(),
    .o_wlast_m(),
    .o_wvalid_m(),
    .i_wready_m(),
    .i_bid_m(),
    .i_bresp_m(),
    .i_bvalid_m(),
    .o_bready_m(),
    .o_arid_m(),
    .o_araddr_m(),
    .o_arlen_m(),
    .o_arsize_m(),
    .o_arburst_m(),
    .o_arlock_m(),
    .o_arcache_m(),
    .o_aruser_m(),
    .o_arprot_m(),
    .o_arvalid_m(),
    .i_arready_m(),
    .i_rid_m(),
    .i_rdata_m(),
    .i_rresp_m(),
    .i_rlast_m(),
    .i_rvalid_m(),
    .o_rready_m(),
    // Video out
    .clk_v(clk),
    `ifdef PP_HDMI_TEST
    .clk_v_90(),
    `endif
    .o_blank_x(),
    .o_hsync_x(vga_hsync),
    .o_vsync_x(vga_vsync),
    .o_vr(vga_r),
    .o_vg(vga_g),
    .o_vb(vga_b)
    `ifdef PP_USE_HDMI
    // HDMI
    ,.io_scl(),
    .io_sda(),
    .clk_vo(),
    .o_hd_vsync(),
    .o_hd_hsync(),
    .o_hd_de(),
    .o_hd_d()
    `endif
    );

/*
    initial begin
        $display("[%0t] Tracing to logs/vlt_dump.vcd...\n", $time);
        $dumpfile("logs/vlt_dump.vcd");
        $dumpvars();
    end
*/

endmodule
