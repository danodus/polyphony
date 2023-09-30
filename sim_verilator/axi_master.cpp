#include "axi_master.h"

#include "utils.h"

void axi_master::single_write(const std::unique_ptr<Vtop> &top, uint32_t adr, uint8_t be, uint32_t dat)
{
    top->i_awaddr_s      = adr;
    top->i_awlen_s       = 0;
    top->i_awvalid_s     = 1;
    top->i_wdata_s       = dat;
    top->i_wstrb_s       = be;
    top->i_wlast_s       = 0;
    top->i_wvalid_s      = 0;
    top->i_bready_s      = 0;
    while(!top->o_awready_s)
        pulse_clk(top);
    pulse_clk(top);
    top->i_awvalid_s = 0;
    top->i_wlast_s   = 1;
    top->i_wvalid_s  = 1;
    top->i_bready_s  = 1;
    while(!top->o_wready_s)
        pulse_clk(top);
    pulse_clk(top);
    top->i_wvalid_s  = 0;
    top->i_wlast_s   = 0;
    top->i_wvalid_s  = 0;
    while(!top->o_bvalid_s)
        pulse_clk(top);
    pulse_clk(top);
    top->i_bready_s       = 0;
    pulse_clk(top);
}