#OLD
yosys -p "synth_ice40 -blif hardware.blif" -q demo.v picorv32.v picosoc.v simpleuart.v spiflash.v spimemio.v
#NEW - use nextpnr
#yosys -p "synth_ice40 -json hardware.json" -q demo.v picorv32.v picosoc.v simpleuart.v spiflash.v spimemio.v

#OLD
arachne-pnr -d 8k -P tq144:4k -p demo.pcf hardware.blif -o hardware.txt
#NEW - use nextpnr
#nextpnr-ice40 --hx8k --package tq144:4k --json hardware.json --asc hardware.asc --pcf demo.pcf -q

#OLD
icepack hardware.txt hardware.bin
#NEW - use nextpnr
#icepack hardware.asc hardware.bin

iceprog -d i:0x0403:0x6010:0 hardware.bin
