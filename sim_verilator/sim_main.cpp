#include <SDL.h>

#include <memory>
#include <chrono>
#include <deque>
#include <fstream>
#include <sstream>

#include <verilated.h>
#include <iostream>

// Include model header, generated from Verilating "top.v"
#include "Vtop.h"

#include "utils.h"
#include "axi_slave_mem.h"
#include "axi_master.h"

#define PP_BASE_ADDR 0x0

const int screen_width = 1024;
const int screen_height = 768;

// 640x480
const int vga_width = 800;
const int vga_height = 525;

axi_slave_mem g_axi_slave_mem{};
axi_master g_axi_master{};

double sc_time_stamp()
{
    return 0.0;
}

void reset(const std::unique_ptr<Vtop>& top)
{
    top->rst_x = 0;
    for (int i = 0; i < 10; ++i)
        pulse_clk(top);
    top->rst_x = 1;
    pulse_clk(top);
}

void memory_clear(const std::unique_ptr<Vtop>& top)
{
    g_axi_slave_mem.memory_clear(top);
}

void register_setup(const std::unique_ptr<Vtop>& top)
{
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0004, 0xf, 0x00000000);      // frame0 offset
    
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0008, 0xf, 0x00010000);      // frame1 offset
//        g_axi_master.single_write(top, PP_BASE_ADDR+0x0014, 0xf, 0x00000002);      // color mode
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0014, 0xf, 0x00000000);      // color mode
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0028, 0xf, 0x00000001);      // int mask
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0200, 0xf, 0x00000000);      // 3d register
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0284, 0xf, 0x00000000);      // color offset
    g_axi_master.single_write(top, PP_BASE_ADDR+0x028c, 0xf, 0x00400000);      // depth offset
    g_axi_master.single_write(top, PP_BASE_ADDR+0x02ac, 0xf, 0x00000001);      // depth test en, LESS
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0204, 0xf, 0x00000001);      // cache clear
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0280, 0xf, 0x00000001);      // screen flip
}

void to_float32(uint32_t *ret, float32_t v)
{
    union {
        float32_t f;
        uint32_t u;
    } _uf;

    _uf.f = v;
    *ret = _uf.u;
}

void set_triangle2(const std::unique_ptr<Vtop>& top)
{
  uint32_t r_f32;
    g_axi_master.single_write(top, PP_BASE_ADDR+0x02b4, 0xf, 0x00003001);      // attribute
    // vertex0 (top)
    to_float32(&r_f32,95);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0340, 0xf, r_f32);  // x
    to_float32(&r_f32,235);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0344, 0xf, r_f32);  // y
    to_float32(&r_f32,1.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0348, 0xf, r_f32);  // z
    to_float32(&r_f32,1.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x034c, 0xf, r_f32);  // iw
    to_float32(&r_f32,0.0*255.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0350, 0xf, r_f32);  // cr
    to_float32(&r_f32,1.0*255.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0354, 0xf, r_f32);  // cg
    to_float32(&r_f32,0.0*255.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0358, 0xf, r_f32);  // cb
    to_float32(&r_f32,1.0*255.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x035c, 0xf, r_f32);  // ca
    // vertex1 (middle)
    to_float32(&r_f32,220);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0380, 0xf, r_f32);  // x
    to_float32(&r_f32,125);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0384, 0xf, r_f32);  // y
    to_float32(&r_f32,1.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0388, 0xf, r_f32);  // z
    to_float32(&r_f32,1.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x038c, 0xf, r_f32);  // iw
    to_float32(&r_f32,0.0*255.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0390, 0xf, r_f32);  // cr
    to_float32(&r_f32,0.0*255.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0394, 0xf, r_f32);  // cg
    to_float32(&r_f32,1.0*255.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0398, 0xf, r_f32);  // cb
    to_float32(&r_f32,1.0*255.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x039c, 0xf, r_f32);  // ca
    to_float32(&r_f32,1.0);
    // vertex2 (bottom)
    to_float32(&r_f32,100);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x03c0, 0xf, r_f32);  // x
    to_float32(&r_f32,105);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x03c4, 0xf, r_f32);  // y
    to_float32(&r_f32,1.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x03c8, 0xf, r_f32);  // z
    to_float32(&r_f32,1.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x03cc, 0xf, r_f32);  // iw
    to_float32(&r_f32,1.0*255.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x03d0, 0xf, r_f32);  // cr
    to_float32(&r_f32,0.0*255.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x03d4, 0xf, r_f32);  // cb
    to_float32(&r_f32,0.0*255.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x03d8, 0xf, r_f32);  // cg
    to_float32(&r_f32,1.0*255.0);
    g_axi_master.single_write(top, PP_BASE_ADDR+0x03dc, 0xf, r_f32);  // ca
    to_float32(&r_f32,1.0);
    // render start
    g_axi_master.single_write(top, PP_BASE_ADDR+0x0200, 0xf, 1);
}

int main(int argc, char **argv, char **env)
{
    SDL_Init(SDL_INIT_VIDEO);

    SDL_Window *window = SDL_CreateWindow(
        "Polyphony",
        SDL_WINDOWPOS_UNDEFINED_DISPLAY(1),
        SDL_WINDOWPOS_UNDEFINED,
        screen_width,
        screen_height,
        0);

    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);

    // Create logs/ directory in case we have traces to put under it
    Verilated::mkdir("logs");


    const size_t pixels_size = vga_width * vga_height * 4;
    unsigned char *pixels = new unsigned char[pixels_size];

    SDL_Texture *texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGBA32, SDL_TEXTUREACCESS_STREAMING, vga_width, vga_height);

    bool restart_model;
    do {

        // Construct a VerilatedContext to hold simulation time, etc.
        // Multiple modules (made later below with Vtop) may share the same
        // context to share time, or modules may have different contexts if
        // they should be independent from each other.

        // Using unique_ptr is similar to
        // "VerilatedContext* contextp = new VerilatedContext" then deleting at end.
        const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};

        // Set debug level, 0 is off, 9 is highest presently used
        // May be overridden by commandArgs argument parsing
        //contextp->debug(0);

        // Randomization reset policy
        // May be overridden by commandArgs argument parsing
        contextp->randReset(0);

        // Verilator must compute traced signals
        contextp->traceEverOn(true);

        // Pass arguments so Verilated code can see them, e.g. $value$plusargs
        // This needs to be called before you create any model
        contextp->commandArgs(argc, argv);

        restart_model = false;

        // Construct the Verilated model, from Vtop.h generated from Verilating "top.v".
        // Using unique_ptr is similar to "Vtop* top = new Vtop" then deleting at end.
        // "TOP" will be the hierarchical name of the module.
        const std::unique_ptr<Vtop> top{new Vtop{contextp.get(), "TOP"}};

        SDL_Event e;
        bool quit = false;

        auto tp_frame = std::chrono::high_resolution_clock::now();
        auto tp_clk = std::chrono::high_resolution_clock::now();
        auto tp_now = std::chrono::high_resolution_clock::now();
        std::chrono::duration<double> duration_clk;

        unsigned int frame_counter = 0;
        bool was_vsync = false;

        size_t pixel_index = 0;

        top->clk = 0;

        // ----------

        reset(top);
        memory_clear(top);
        register_setup(top);
        set_triangle2(top);

        // ----------


        while (!contextp->gotFinish() && !quit)
        {
                
            // Update video display
            if (was_vsync && top->o_vsync_x)
            {
                pixel_index = 0;
                was_vsync = false;
            }

            pixels[pixel_index] = top->o_vr << 4;
            pixels[pixel_index + 1] = top->o_vg << 4;
            pixels[pixel_index + 2] = top->o_vb << 4;
            pixels[pixel_index + 3] = 255;
            pixel_index = (pixel_index + 4) % (pixels_size);

            if (!top->o_vsync_x && !was_vsync)
            {
                was_vsync = true;
                void *p;
                int pitch;
                SDL_LockTexture(texture, NULL, &p, &pitch);
                assert(pitch == vga_width * 4);
                memcpy(p, pixels, vga_width * vga_height * 4);
                SDL_UnlockTexture(texture);
            }

            tp_now = std::chrono::high_resolution_clock::now();
            std::chrono::duration<double> duration_frame = tp_now - tp_frame;

            if (contextp->time() % 2000000 == 0)
            {
                duration_clk = tp_now - tp_clk;
                tp_clk = tp_now;
            }

            if (duration_frame.count() >= 1.0 / 60.0)
            {
                while (SDL_PollEvent(&e))
                {
                    if (e.type == SDL_QUIT)
                    {
                        quit = true;
                    }
                    else if (e.type == SDL_KEYUP)
                    {
                        switch (e.key.keysym.sym)
                        {
                        case SDLK_F12:
                            quit = true;
                            restart_model = true;
                            break;
                        default:
                            break;
                        }
                    }
                    else if (e.type == SDL_KEYDOWN)
                    {
                        if (e.key.repeat == 0)
                        {
                            switch (e.key.keysym.sym)
                            {
                            case SDLK_F12:
                                std::cout << "Reset context\n";
                                break;
                            default:
                                break;
                            }
                        }
                    }
                }

                int draw_w, draw_h;
                SDL_GL_GetDrawableSize(window, &draw_w, &draw_h);

                int scale_x, scale_y;
                scale_x = draw_w / screen_width;
                scale_y = draw_h / screen_height;

                SDL_SetRenderDrawColor(renderer, 0, 0, 0, SDL_ALPHA_OPAQUE);
                SDL_RenderClear(renderer);

                if (frame_counter % 100 == 0)
                {
                    std::cout << "Clk speed: " << 1.0 / (duration_clk.count()) << " MHz\n";
                }

                tp_frame = tp_now;
                frame_counter++;

                SDL_Rect vga_r = {0, scale_x * (screen_height - vga_height - 1), scale_x * vga_width, scale_y * vga_height};
                SDL_RenderCopy(renderer, texture, NULL, &vga_r);

                SDL_RenderPresent(renderer);
            }

            pulse_clk(top);

        }

        // Final model cleanup
        top->final();
    } while (restart_model);

    SDL_DestroyTexture(texture);

    delete[] pixels;

    SDL_DestroyWindow(window);
    SDL_Quit();

    return 0;
}
