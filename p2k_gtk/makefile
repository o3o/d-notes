NAME = p2kgtk
VERSION = 0.1.0

ROOT_SOURCE_DIR = src
BIN = .
SRC = $(getSources) 
TARGET = "exe"
SRC_TEST = $(SRC)
#oppure	
#SRC_TEST = $(filter-out $(ROOT_SOURCE_DIR)/app.d, $(SRC)) 
#SRC_TEST += $(wildcard tests/*.d)

# Compiler flag
# -----------
ifeq ($(TARGET), "lib")
	DCFLAGS += -lib
	DCFLAGS_REL += -lib
endif

DCFLAGS += -debug #compile in debug code
#DCFLAGS += -g # add symbolic debug info
#DCFLAGS += -w # warnings as errors (compilation will halt)
DCFLAGS += -wi # warnings as messages (compilation will continue)

# release flags
DCFLAGS_REL += -O -wi -release -inline -boundscheck=off

DCFLAGS_TEST += -unittest
# DCFLAGS_TEST += -main -quiet

# Linker flag
# -----------
# DCFLAGS_LINK += 
# DCFLAGS_LINK += -L-L/usr/lib/

# Version flag
# -----------
#VERSION_FLAG += -version=StdLoggerDisableLogging
#VERSION_FLAG += -version=use_gtk

# Packages
# -----------
PKG = $(wildcard $(BIN)/$(NAME))
PKG_SRC = $(PKG) $(SRC) makefile

# -----------
# Libraries
# -----------

# logger
# https://github.com/burner/logger 
# -----------
#LIB += $(D_DIR)/logger/liblogger.a
#DCFLAGS_IMPORT += -I$(D_DIR)/logger

# endovena
# https://github.com/o3o/endovena
# -----------
#LIB += $(D_DIR)/endovena/bin/libendovena.a
#DCFLAGS_IMPORT += -I$(D_DIR)/endovena/src

# dinodave
# https://github.com/o3o/dinodave
# -----------
#LIB += $(D_DIR)/dinodave/bin/libdinodave.a
#DCFLAGS_IMPORT += -I$(D_DIR)/dinodave/src
#DCFLAGS_LINK +=-L-lnodave 

# serial
# https://github.com/NCrashed/serial-port
# -----------
#LIB += $(D_DIR)/serial-port/libserial-port.a
#DCFLAGS_IMPORT += -I$(D_DIR)/serial-port/source

# protocols
# git@gitlab.com:o3o/protocols.git
#LIB += $(D_DIR)/protocols/bin/libprotocols.a
#DCFLAGS_IMPORT += -I$(D_DIR)/protocols/src
#
# gtkd2
# https://github.com/gtkd-developers/GtkD
# -----------
#LIB += $(D_DIR)/GtkD/libgtkd-2.a
#DCFLAGS_IMPORT += -I$(D_DIR)/GtkD/src
#DCFLAGS_LINK += -L-ldl

# gtkd3
# https://github.com/gtkd-developers/GtkD
# -----------
LIB += $(D_DIR)/GtkD/libgtkd-3.a
DCFLAGS_IMPORT += -I$(D_DIR)/GtkD/src
DCFLAGS_LINK += -L-ldl

# sdlang
# https://github.com/Abscissa/SDLang-D
# -----------
#LIB += $(D_DIR)/SDLang-D/libsdlang-d.a
#LIB += $(D_DIR)/libInputVisitor/liblibinputvisitor.a
#DCFLAGS_IMPORT += -I$(D_DIR)/SDLang-D/src
#DCFLAGS_IMPORT += -I$(D_DIR)/libInputVisitor

# d-yaml
# https://github.com/kiith-sa/D-YAML
# -----------
#LIB += $(D_DIR)/D-YAML/libdyaml.a
#LIB += $(D_DIR)/tinyendian/libtinyendian.a
#DCFLAGS_IMPORT += -I$(D_DIR)/tinyendian/source
#DCFLAGS_IMPORT += -I$(D_DIR)/D-YAML/source

# msgpack
# https://github.com/msgpack/msgpack-d
# -----------
#LIB += $(D_DIR)/msgpack-d/libmsgpack-d.a
#DCFLAGS_IMPORT += -I$(D_DIR)/msgpack-d/src

# ddb
# https://github.com/pszturmaj/ddb
# -----------
#LIB += $(D_DIR)/ddb/libddb.a
#DCFLAGS_IMPORT += -I$(D_DIR)/ddb/source

# pack-d
# http://github.com/robik/pack-d
# -----------
#LIB += $(D_DIR)/pack-d/libpack-d.a
#DCFLAGS_IMPORT += -I$(D_DIR)/pack-d/source

# baussini
# https://github.com/BaussProjects/baussini
# -----------
#LIB += $(D_DIR)/baussini/libbaussini.a
#DCFLAGS_IMPORT += -I$(D_DIR)/baussini/src

# dolina
# https://github.com/o3o/dolina
# -----------
#LIB += $(D_DIR)/dolina/bin/libdolina.a
#DCFLAGS_IMPORT += -I$(D_DIR)/dolina/src

# harud
# https://github.com/o3o/harud
# -----------
#LIB += $(D_DIR)/harud/bin/libharud.a
#DCFLAGS_IMPORT += -I$(D_DIR)/harud/src
#DCFLAGS_LINK += -L-lhpdf 

# plot2kill
# https://github.com/klickverbot/plot2kill
LIB += $(D_DIR)/plot2kill/libplot2kill.a
DCFLAGS_IMPORT += -I$(D_DIR)/plot2kill/source

#
# -----------
# Test  library
# -----------

# unit-threaded
# -----------
#LIB_TEST += $(D_DIR)/unit-threaded/libunit-threaded.a
#DCFLAGS_IMPORT_TEST += -I$(D_DIR)/unit-threaded/source

# dunit
# -----------
#LIB += $(D_DIR)/dunit/libdunit.a
#DCFLAGS_IMPORT += -I$(D_DIR)/dunit/source

# dmocks-revived
# -----------
#LIB_TEST += $(D_DIR)/DMocks-revived/libdmocks-revived.a
#DCFLAGS_IMPORT_TEST += -I$(D_DIR)/DMocks-revived

LIB_TEST += $(LIB)
DCFLAGS_IMPORT_TEST += $(DCFLAGS_IMPORT)

include common.mk
