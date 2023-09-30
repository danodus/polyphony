#include "axi_slave_mem.h"

axi_slave_mem::axi_slave_mem() {
    m_r_mem = new uint32_t[1 << P_MEM_SIZE];
}

axi_slave_mem::~axi_slave_mem() {
    delete [] m_r_mem;
}

void axi_slave_mem::memory_clear(const std::unique_ptr<Vtop> &top) {
    for (size_t i = 0; i < (1 << P_MEM_SIZE); ++i)
        m_r_mem[i] = 0xFFFFFFFF;
}