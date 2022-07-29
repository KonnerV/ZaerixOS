# ZaerixOS

## Usage

This is a somewhat functional Operating System intended to be used on a Virtual Machine as I have not yet tested it on actual hardware yet. This Operating System is meant for people who enjoy command-lines and enjoy not really being able to do much on an OS.

## About

This is an Operating System being worked on by an idiot with a keyboard. This OS is not yet finished and will likely not run on actual hardware but you can still try if you want. This Operating System is very basic with only a few commands.

## Notes

This OS is a work in progress and will likely be a mess to start off

## Setup/Install

Make sure all of the .asm files are in the same directory.

use the following commands:

build
```
nasm -f bin Zaerix.asm -o ZaerixOS.bin
```

run
```
qemu-system-i386 -fda ZaerixOS.bin
```


