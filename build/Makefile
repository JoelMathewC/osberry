# Using the ARM GCC cross-compiler
CC = /Applications/ARM/bin/arm-none-eabi-gcc

# Constants
CPU = cortex-a72
IMG_NAME=kernel.img

# Compilation flags
CFLAGS= -mcpu=$(CPU) -fpic -ffreestanding $(DIRECTIVES)
CSRCFLAGS= -O2 -Wall -Wextra
LFLAGS= -ffreestanding -O2 -nostdlib

# Location of the files
KER_SRC = ../src/kernel
KER_HEAD = ../include
COMMON_SRC = ../src/common
OBJ_DIR = bin

# collecting a list of all files
KERSOURCES = $(wildcard $(KER_SRC)/*.c)
COMMONSOURCES = $(wildcard $(COMMON_SRC)/*.c)
ASMSOURCES = $(wildcard $(KER_SRC)/*.S)
HEADERS = $(wildcard $(KER_HEAD)/*.h)

# Generating a list of all output file names by subitituting .c/.S
# with .o
OBJECTS = $(patsubst $(KER_SRC)/%.c, $(OBJ_DIR)/%.o, $(KERSOURCES))
OBJECTS += $(patsubst $(COMMON_SRC)/%.c, $(OBJ_DIR)/%.o, $(COMMONSOURCES))
OBJECTS += $(patsubst $(KER_SRC)/%.S, $(OBJ_DIR)/%.o, $(ASMSOURCES))


# build targets, we have individual targets for each out file that are wrapped 
# together here. Reference for the automatic variables used here can be found at
# https://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html
build:	$(OBJECTS) $(HEADERS)
	echo $(OBJECTS)
	$(CC) -T linker.ld -o $(IMG_NAME) $(LFLAGS) $(OBJECTS)

$(OBJ_DIR)/%.o:	$(KER_SRC)/%.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) -I$(KER_SRC) -I$(KER_HEAD) -c $< -o $@ $(CSRCFLAGS)

$(OBJ_DIR)/%.o:	$(KER_SRC)/%.S
	mkdir -p $(@D)
	$(CC) $(CFLAGS) -I$(KER_SRC) -c $< -o $@

$(OBJ_DIR)/%.o:	$(COMMON_SRC)/%.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) -I$(KER_SRC) -I$(KER_HEAD) -c $< -o $@ $(CSRCFLAGS)

# Cleans the object dir and removes the kernel image
clean:
	rm -rf $(OBJ_DIR)
	rm $(IMG_NAME)

# Spins up a QEMU raspberry PI emulator
run: build
	qemu-system-arm -m 1024 -M raspi2b -serial stdio -kernel kernel.img