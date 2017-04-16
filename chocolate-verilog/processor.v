module processor (
    input wire dbg_clk,

    output wire rw_mem,
    inout wire [7:0] mem_io,
    
    output wire pin_led,
);

wire [7:0] instr;
wire [7:0] rom_read;
wire [7:0] rom_write;
wire is_jump;

pc_instr pc_reg (
    .clk(dbg_clk),
    .instr(instr),
    
    .jmp(is_jump),
    .addr(alu_output),

    .read_mem(rom_read),
    .write_mem(rom_write),
    .rw_mem(rw_mem),
);

wire is_write, is_short_imm;
wire [7:0] rs_read;
wire [7:0] rt_read;
wire [7:0] reg_write;

decoder dec (
    .instr(instr),

    .rs_read(rs_read),
    .rt_read(rt_read),
    .is_write(is_write),
    .reg_write(reg_write),
    .is_short_imm(is_short_imm),

    .is_jump(is_jump)
);

// If the memory is an input, send the rom_write, otherwise set it to high impedance and read
assign mem_io = rw_mem ? rom_write : 8'bz;
assign rom_read = rw_mem ? 0 : mem_io;
assign pin_led = pc[0];

endmodule