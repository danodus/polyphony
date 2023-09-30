#ifndef __AXI_SLAVE_MEM_H__
#define __AXI_SLAVE_MEM_H__

#include "Vtop.h"

class axi_slave_mem {

    static const size_t P_MEM_SIZE = 24;

    uint32_t *m_r_mem;

public:
    axi_slave_mem();
    ~axi_slave_mem();
    void memory_clear(const std::unique_ptr<Vtop> &top);
};

#endif // __AXI_SLAVE_MEM_H__
