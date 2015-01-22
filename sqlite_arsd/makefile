NAME = sqlite_arsd
VERSION = 0.1.0

ROOT_SOURCE_DIR = src
SRC = $(getSources) 
SRC_TEST = $(SRC)
#oppure	
#SRC_TEST = $(filter-out $(ROOT_SOURCE_DIR)/app.d, $(SRC)) 
#SRC_TEST += $(wildcard tests/*.d)

# Compiler flag
# -----------
DFLAGS += -debug #compile in debug code
#DFLAGS += -g # add symbolic debug info
#DFLAGS += -w # warnings as errors (compilation will halt)
DFLAGS += -wi # warnings as messages (compilation will continue)

DFLAGS_TEST += -unittest
# DFLAGS_TEST += -main -quiet

# Linker flag
# -----------
# LDFLAGS += 
# LDFLAGS += -L-L/usr/lib/

# Version flag
# -----------
# VERSION_FLAG = -version=use_gtk

# Packages
# -----------
PKG = $(wildcard $(BIN)/$(NAME))
PKG_SRC = $(PKG) $(SRC) makefile

# -----------
# Libraries
# -----------

# sqlite arsd
# -----------
LDFLAGS += -L-ldl -L-lsqlite3

LIB_TEST += $(LIB)
INCLUDES_TEST += $(INCLUDES)

include common.mk
