## FTDI eeprom memory

The **FTDI chip** included in the **Alhambra II** board has an internal **256 bytes eeprom memory** that is flashed in the factory. It can be flashed using the ftdi-eeprom **open source tool**. This tool can be compiled to any platform following the instruction of the [tool-systems apio package](https://github.com/FPGAwars/tools-system)

**NOTE**
Since May-15th-2019, the ftdi_eeprom tools has been included into the APIO system tool v1.1.1 packaged. It can be execute by means of the apio raw command. For example, try:  **apio raw "ftdi_eeprom --help"**

### Flashing the eeprom

**NOTE**: Do not play with the FTDI eeprom memory unless you know what you are doing. If you change the product id string, Icestudio will not recognized it as an FPGA board and will not upload the bitstreams. **Use at your own risk**

* **Step 1**: Build the eeprom image from the config file

  * Edit the Alhambra2.conf file
  * Make your changes
  * Build the new eeprom image using the command:

```
$ ftdi-eeprom --build-eeprom Alhambra2.conf

FTDI eeprom generator v0.17
(c) Intra2net AG and the libftdi developers <opensource@intra2net.com>
FTDI read eeprom: 0
EEPROM size: 256
Used eeprom space: 254 bytes
Writing to file: A2-eeprom-image.bin
FTDI close: 0
```
The file **A2-eeprom-image.bin** will be generated

* **Step 2**: Flash the eeprom image

```
$ ftdi-eeprom --flash-eeprom Alhambra2.conf

FTDI eeprom generator v0.17
(c) Intra2net AG and the libftdi developers <opensource@intra2net.com>
FTDI read eeprom: 0
EEPROM size: 256
Used eeprom space: 254 bytes
FTDI write eeprom: 0
Writing to file: A2-eeprom-image.bin
FTDI close: 0
```

* **Step 3**: Testing the changes

If you have changed the manufacturer or product ids, you can check the changes using apio:

```
$ apio system --lsftdi
Number of FTDI devices found: 1
Checking device: 0
Manufacturer: CHANGED, Description: Alhambra II v1.0 - P01-004
```
## Restoring the eeprom

The **A-eeprom-image-orig.bin** file contains an original eeprom image. You can restore it using the following command

```
$ apio raw "ftdi_eeprom --build-eeprom Alhambra2.conf"

FTDI eeprom generator v0.17
(c) Intra2net AG and the libftdi developers <opensource@intra2net.com>
FTDI read eeprom: 0
EEPROM size: 256
Used eeprom space: 238 bytes
Flashing raw eeprom from file A2-eeprom-image-orig.bin (256 bytes)
FTDI write eeprom: 0
FTDI close: 0
```

## Reading the eeprom

If you are curious and want to have a look a your eeprom's image, you can read it with the following command:

```
$ ftdi-eeprom --read-eeprom Alhambra2.conf

FTDI eeprom generator v0.17
(c) Intra2net AG and the libftdi developers <opensource@intra2net.com>
FTDI read eeprom: 0
EEPROM size: 256
FTDI close: 0
```
It will generate the **A2-eeprom-image.bin** image. Then you can have a look with the hd command line in linux:

```
$ hd -v A2-eeprom-image.bin
00000000  01 08 03 04 10 60 00 07  80 fa 00 00 11 11 9a 12  |.....`..........|
00000010  ac 36 00 00 00 00 00 00  56 00 00 00 00 00 00 00  |.6......V.......|
00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000070  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000080  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000090  00 00 00 00 00 00 00 00  00 00 12 03 4d 00 61 00  |............M.a.|
000000a0  72 00 65 00 6c 00 64 00  65 00 6d 00 36 03 41 00  |r.e.l.d.e.m.6.A.|
000000b0  6c 00 68 00 61 00 6d 00  62 00 72 00 61 00 20 00  |l.h.a.m.b.r.a. .|
000000c0  49 00 49 00 20 00 76 00  31 00 2e 00 30 00 20 00  |I.I. .v.1...0. .|
000000d0  2d 00 20 00 50 00 30 00  31 00 2d 00 30 00 30 00  |-. .P.0.1.-.0.0.|
000000e0  34 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |4...............|
000000f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 fc 28  |...............(|
```
