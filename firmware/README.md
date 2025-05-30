# Icedev Zero Firmware

Welcome to the firmware folder! You can find numerous examples here:

- `blinky`: Classic LED counter!
- `counter`: Counter using the button as input :D
- `uart`: Uart transmission example

## Toolchain setup

Download the latest build of the [oss cad suit](https://github.com/YosysHQ/oss-cad-suite-build/releases/).

Unzip it anywhere and set shell command search path:
```
Linux              : export PATH=[path-to-bin]:$PATH
MacOS              : export PATH=[path-to-bin]:$PATH
Windows Powershell : $ENV:PATH = "[path-to-bin];" + $ENV:PATH
Windows cmd.exe    : PATH=[path-to-bin];%PATH%
```

## How to build

Just `cd` into the directories, and type `make`!

- `make install` installs the program to flash
- `make debug` installs the program to chip (bitstream is lost on power loss)
- `make build` builds the bitstream (bitstream is retained on power loss)
- `make clean` deletes all the temporary files
- `make` runs `make debug`

## Make your own!

Just copy the `icepi-zero.lpf` and `Makefile` to the root of your directory, call your main module `top`, and you are good to go!

## Pinout

To come soon
