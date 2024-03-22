VERILATOR = verilator

LDFLAGS := -LDFLAGS "$(shell sdl2-config --libs)"
CFLAGS := -CFLAGS "--std=c++14 $(shell sdl2-config --cflags)"

RTLDIR := ../rtl
SRC := sim_main.cpp utils.cpp axi_master.cpp
HDR := utils.h axi_master.h

all: sim

clean:
	rm -rf obj_dir

sim: top.sv $(SRC) $(HDR)
	$(VERILATOR) --trace -cc --exe $(CFLAGS) $(LDFLAGS) -Wno-CASEINCOMPLETE -Wno-UNSIGNED -Wno-WIDTHEXPAND -Wno-WIDTHTRUNC top.sv $(SRC) -I$(RTLDIR) -I$(RTLDIR)/include_32 -I$(RTLDIR)/fm_3d -I$(RTLDIR)/fm_axi_m -I$(RTLDIR)/fm_axi_s -I$(RTLDIR)/fm_cmn -I$(RTLDIR)/fm_hdmi -I$(RTLDIR)/fm_hvc -I$(RTLDIR)/fm_mic -I$(RTLDIR)/fm_rd -I$(RTLDIR)/fm_sys
	$(MAKE) -j 4 -C obj_dir -f Vtop.mk

run: sim
	obj_dir/Vtop

.PHONY: all clean
