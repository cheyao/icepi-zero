# Icepi Zero - The portable FPGA development board. 

![](https://hc-cdn.hel1.your-objectstorage.com/s/v3/d2e1d2fe540b8c4ee1d35ecd6e0287b981d7ee8d_image.png)

## What is the Icepi Zero?

Icepi Zero is an economical FPGA development board with a Raspberry Pi Zero form factor. It carries a Lattice ECP5 25F, enabling powerful designs while keeping a small portable size. It also has a HDMI port allowing easy digital video output.

[View PCB online](https://kicanvas.org/?github=https%3A%2F%2Fgithub.com%2Fcheyao%2Ficepi-zero%2Ftree%2Fmain%2Fhardware%2Fv1.1)

![](https://hc-cdn.hel1.your-objectstorage.com/s/v3/ec8ed16af61150195ea388c32047b6e1b9825b63_image.png)

## Why Icepi Zero?

Currently most powerful FPGA boards on the market are expensive and bulky.

I've always wanted a low-cost portable FPGA with video output to make my own CPU, but there isn't any on the market.

The Icepi Zero aims to fix this. Carrying a powerful ECP5 FPGA on a small Raspberry Pi Zero form factor, it is the ultimate portable solution for FPGA development. Additionally packing a HDMI mini port and 3 USB-C ports, it allows interfacing with multiple external I/O devices.

Icepi Zero is for everyone: Students can use it to learn about the internals of modern processors. Gamers can use it to emulate old hardware. Programmers can use it to test their code on multiple architecture.

Icepi Zero also has an on-board USB to JTAG converter, so no external programmers are needed. Moreover Icepi Zero is fully open-source, no strings attached. Fabricate your own boards if you want one!

![](https://hc-cdn.hel1.your-objectstorage.com/s/v3/a6690d6e952f533cc95823e3fc1565726f22daf8_image.png)

## Features

- Raspberry Pi Zero form factor
- Lattice ECP5U FPGA:
    - 24k LUT
    - 112 KiB of RAM
- One MiniGPDI connector (it's HDM- but I don't have the money to buy a license...)
- Three USB-C Ports
- 256MiB 166MHz SDRAM
- MicroSD card slot
- On-board USB to JTAG and UART converter
- 40MHz external oscillator
- 128 Mbit of flash
- 4 user LEDs
- 1 user button

This powerful configuration allows the PCB to be used in numerous ways, including real time video processing, hardware AI acceleration and prototyping of ASICs.

![](https://hc-cdn.hel1.your-objectstorage.com/s/v3/4c0861d350addacafd7bc4966b30fc04cd840f32_image.png)

## Usage

Check out the `firmware` folder for example code and compilation instructions!

## Contact

If there is any questions DM `@Cyao` on Hackclub Slack or `cyao.` on Discord. Mail is also accepted at `cyao _at_ duck.com`.

Thanks Hackclub for sponsoring this! Check out [highway & undercity, a hackathon at Github HQ](https://highway.hackclub.com/?ref=recg6V5Pj0JbZghRM)
