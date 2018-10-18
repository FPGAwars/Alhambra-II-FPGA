
# ---- iCE40 HX8K Breakout Board ----

hx8kprog: hardware.bin hx8kdemo_fw.bin
	iceprog -o 1M hx8kdemo_fw.bin

hx8kprog_fw: hx8kdemo_fw.bin
	iceprog -o 1M hx8kdemo_fw.bin

hx8kdemo_fw.elf: sections.lds start.s firmware.c
	/opt/riscv32i/bin/riscv32-unknown-elf-gcc -DHX8KDEMO -march=rv32imc -Wl,-Bstatic,-T,sections.lds,--strip-debug -ffreestanding -nostdlib -o hx8kdemo_fw.elf start.s firmware.c

hx8kdemo_fw.hex: hx8kdemo_fw.elf
	/opt/riscv32i/bin/riscv32-unknown-elf-objcopy -O verilog hx8kdemo_fw.elf hx8kdemo_fw.hex

hx8kdemo_fw.bin: hx8kdemo_fw.elf
	/opt/riscv32i/bin/riscv32-unknown-elf-objcopy -O binary hx8kdemo_fw.elf hx8kdemo_fw.bin

# ---- Clean ----

clean:
	rm -f hx8kdemo_fw.elf hx8kdemo_fw.hex hx8kdemo_fw.bin 
	rm -f hx8kdemo.blif hx8kdemo.log hx8kdemo.asc hx8kdemo.bin

.PHONY: hx8kprog hx8kprog_fw
.PHONY: icebprog icebprog_fw
