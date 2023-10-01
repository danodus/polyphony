`include "polyphony_axi_def.v"

module top(
    // system
    input wire logic                  clk,
    input wire logic                  rst_x,

    output logic o_int,
    output logic [1:0] o_debug,
    // AXI Slave
    //   write port
    input wire logic [P_AXI_S_AWID-1:0] i_awid_s,
    input wire logic [P_AXI_S_AWADDR-1:0] i_awaddr_s,
    input wire logic [P_AXI_S_AWLEN-1:0] i_awlen_s,
    input wire logic [P_AXI_S_AWSIZE-1:0] i_awsize_s,
    input wire logic [P_AXI_S_AWBURST-1:0] i_awburst_s,
    input wire logic [P_AXI_S_AWLOCK-1:0] i_awlock_s,
    input wire logic [P_AXI_S_AWCACHE-1:0] i_awcache_s,
    input wire logic [P_AXI_S_AWPROT-1:0] i_awprot_s,
    input wire logic i_awvalid_s,
    output logic o_awready_s,
    input wire logic [P_AXI_S_WID-1:0] i_wid_s,
    input wire logic [P_AXI_S_WDATA-1:0] i_wdata_s,
    input wire logic [P_AXI_S_WSTRB-1:0] i_wstrb_s,
    input wire logic i_wlast_s,
    input wire logic i_wvalid_s,
    output logic o_wready_s,
    output logic [P_AXI_S_BID-1:0] o_bid_s,
    output logic [P_AXI_S_BRESP-1:0] o_bresp_s,
    output logic o_bvalid_s,
    input wire logic i_bready_s,
    //   read port
    input wire logic [P_AXI_S_ARID-1:0] i_arid_s,
    input wire logic [P_AXI_S_ARADDR-1:0] i_araddr_s,
    input wire logic [P_AXI_S_ARLEN-1:0] i_arlen_s,
    input wire logic [P_AXI_S_ARSIZE-1:0] i_arsize_s,
    input wire logic [P_AXI_S_ARBURST-1:0] i_arburst_s,
    input wire logic [P_AXI_S_ARLOCK-1:0] i_arlock_s,
    input wire logic [P_AXI_S_ARCACHE-1:0] i_arcache_s,
    input wire logic [P_AXI_S_ARPROT-1:0] i_arprot_s,
    input wire logic i_arvalid_s,
    output logic o_arready_s,
    output logic [P_AXI_S_RID-1:0] o_rid_s,
    output logic [P_AXI_S_RDATA-1:0] o_rdata_s,
    output logic [P_AXI_S_RRESP-1:0] o_rresp_s,
    output logic o_rlast_s,
    output logic o_rvalid_s,
    input wire logic i_rready_s,
    // Video out
    input wire logic clk_v,
    output logic o_blank_x,
    output logic o_hsync_x,
    output logic o_vsync_x,
    output logic [7:0] o_vr,
    output logic [7:0] o_vg,
    output logic [7:0] o_vb
);

    // AXI Master Write Channel Signals
    wire [P_AXI_M_AWID-1:0] w_awid_m;
    wire [P_AXI_M_AWADDR-1:0] w_awaddr_m;
    wire [P_AXI_M_AWLEN-1:0] w_awlen_m;
    wire [P_AXI_M_AWSIZE-1:0] w_awsize_m;
    wire [P_AXI_M_AWBURST-1:0] w_awburst_m;
    wire [P_AXI_M_AWLOCK-1:0] w_awlock_m;
    wire [P_AXI_M_AWCACHE-1:0] w_awcache_m;
    wire [P_AXI_M_AWPROT-1:0] w_awprot_m;
    wire w_awvalid_m;
    wire w_awready_m;
    wire [P_AXI_M_WID-1:0] w_wid_m;
    wire [P_AXI_M_WDATA-1:0] w_wdata_m;
    wire [P_AXI_M_WSTRB-1:0] w_wstrb_m;
    wire w_wlast_m;
    wire w_wvalid_m;
    wire w_wready_m;
    wire [P_AXI_M_BID-1:0] w_bid_m;
    wire [P_AXI_M_BRESP-1:0] w_bresp_m;
    wire w_bvalid_m;
    wire w_bready_m;
    // AXI Master Read Channel Signals
    wire [P_AXI_M_ARID-1:0] w_arid_m;
    wire [P_AXI_M_ARADDR-1:0] w_araddr_m;
    wire [P_AXI_M_ARLEN-1:0] w_arlen_m;
    wire [P_AXI_M_ARSIZE-1:0] w_arsize_m;
    wire [P_AXI_M_ARBURST-1:0] w_arburst_m;
    wire [P_AXI_M_ARLOCK-1:0] w_arlock_m;
    wire [P_AXI_M_ARCACHE-1:0] w_arcache_m;
    wire [P_AXI_M_ARPROT-1:0] w_arprot_m;
    wire w_arvalid_m;
    wire w_arready_m;
    wire [P_AXI_M_RID-1:0] w_rid_m;
    wire [P_AXI_M_RDATA-1:0] w_rdata_m;
    wire [P_AXI_M_RRESP-1:0] w_rresp_m;
    wire w_rlast_m;
    wire w_rvalid_m;
    wire w_rready_m;

    pp_top pp_top (
        // system
        .clk_core(clk),
        .rst_x(rst_x),
        .o_int,
        .o_debug,
        // AXI Slave
        //   write port
        .i_awid_s,
        .i_awaddr_s,
        .i_awlen_s,
        .i_awsize_s,
        .i_awburst_s,
        .i_awlock_s,
        .i_awcache_s,
        .i_awprot_s,
        .i_awvalid_s,
        .o_awready_s,
        .i_wid_s,
        .i_wdata_s,
        .i_wstrb_s,
        .i_wlast_s,
        .i_wvalid_s,
        .o_wready_s,
        .o_bid_s,
        .o_bresp_s,
        .o_bvalid_s,
        .i_bready_s,
        //   read port
        .i_arid_s,
        .i_araddr_s,
        .i_arlen_s,
        .i_arsize_s,
        .i_arburst_s,
        .i_arlock_s,
        .i_arcache_s,
        .i_arprot_s,
        .i_arvalid_s,
        .o_arready_s,
        .o_rid_s,
        .o_rdata_s,
        .o_rresp_s,
        .o_rlast_s,
        .o_rvalid_s,
        .i_rready_s,
        // AXI Master Write
        .o_awid_m(w_awid_m),
        .o_awaddr_m(w_awaddr_m),
        .o_awlen_m(w_awlen_m),
        .o_awsize_m(w_awsize_m),
        .o_awburst_m(w_awburst_m),
        .o_awlock_m(w_awlock_m),
        .o_awcache_m(w_awcache_m),
        .o_awuser_m(),
        .o_awprot_m(w_awprot_m),
        .o_awvalid_m(w_awvalid_m),
        .i_awready_m(w_awready_m),
        .o_wid_m(w_wid_m),
        .o_wdata_m(w_wdata_m),
        .o_wstrb_m(w_wstrb_m),
        .o_wlast_m(w_wlast_m),
        .o_wvalid_m(w_wvalid_m),
        .i_wready_m(w_wready_m),
        .i_bid_m(w_bid_m),
        .i_bresp_m(w_bresp_m),
        .i_bvalid_m(w_bvalid_m),
        .o_bready_m(w_bready_m),
        // AXI Master Read
        .o_arid_m(w_arid_m),
        .o_araddr_m(w_araddr_m),
        .o_arlen_m(w_arlen_m),
        .o_arsize_m(w_arsize_m),
        .o_arburst_m(w_arburst_m),
        .o_arlock_m(w_arlock_m),
        .o_arcache_m(w_arcache_m),
        .o_aruser_m(),
        .o_arprot_m(w_arprot_m),
        .o_arvalid_m(w_arvalid_m),
        .i_arready_m(w_arready_m),
        .i_rid_m(w_rid_m),
        .i_rdata_m(w_rdata_m),
        .i_rresp_m(w_rresp_m),
        .i_rlast_m(w_rlast_m),
        .i_rvalid_m(w_rvalid_m),
        .o_rready_m(w_rready_m),
        // Video out
        .clk_v(clk),
        .o_blank_x,
        .o_hsync_x,
        .o_vsync_x,
        .o_vr,
        .o_vg,
        .o_vb
    );

    axi_slave_mem axi_slave_mem (
        .clk_core(clk),
        .rst_x(rst_x),
        // AXI
        //   write channel
        .i_awid(w_awid_m),
        .i_awaddr(w_awaddr_m),
        .i_awlen(w_awlen_m),
        .i_awsize(w_awsize_m),
        .i_awburst(w_awburst_m),
        .i_awlock(w_awlock_m),
        .i_awcache(w_awcache_m),
        .i_awprot(w_awprot_m),
        .i_awvalid(w_awvalid_m),
        .o_awready(w_awready_m),
        .i_wid(w_wid_m),
        .i_wdata(w_wdata_m),
        .i_wstrb(w_wstrb_m),
        .i_wlast(w_wlast_m),
        .i_wvalid(w_wvalid_m),
        .o_wready(w_wready_m),
        .o_bid(w_bid_m),
        .i_bresp(w_bresp_m),
        .o_bvalid(w_bvalid_m),
        .i_bready(w_bready_m),
        //   read channel
        .i_arid(w_arid_m),
        .i_araddr(w_araddr_m),
        .i_arlen(w_arlen_m),
        .i_arsize(w_arsize_m),
        .i_arburst(w_arburst_m),
        .i_arlock(w_arlock_m),
        .i_arcache(w_arcache_m),
        .i_arprot(w_arprot_m),
        .i_arvalid(w_arvalid_m),
        .o_arready(w_arready_m),
        .o_rid(w_rid_m),
        .o_rdata(w_rdata_m),
        .o_rresp(w_rresp_m),
        .o_rlast(w_rlast_m),
        .o_rvalid(w_rvalid_m),
        .i_rready(w_rready_m)
    );

    initial begin
        axi_slave_mem.memory_clear();
        //$display("[%0t] Tracing to logs/vlt_dump.vcd...\n", $time);
        //$dumpfile("logs/vlt_dump.vcd");
        //$dumpvars();
    end

endmodule
