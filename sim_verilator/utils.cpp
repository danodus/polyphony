#include "utils.h"

void pulse_clk(const std::unique_ptr<Vtop>& top)
{
    top->clk = 1;
    top->contextp()->timeInc(1);
    top->eval();    
    top->clk = 0;
    top->contextp()->timeInc(1);
    top->eval();

    //if (top->contextp()->time() > 10000)
    //    exit(0); 
}