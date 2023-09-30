#ifndef __AXI_MASTER_H__
#define __AXI_MASTER_H__

#include "Vtop.h"

class axi_master {
public:
    void single_write(const std::unique_ptr<Vtop> &top, uint32_t adr, uint8_t be, uint32_t dat);
};

#endif // __AXI_MASTER_H__