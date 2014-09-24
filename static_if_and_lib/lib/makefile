NAME = mystruct 
PROJECT_VERSION  = 0.1.0 

#ROOT_SOURCE_DIR = src
#SRC = $(wildcard $(ROOT_SOURCE_DIR)/$(NAME)/*.d)
ROOT_SOURCE_DIR = .
getSources = $(shell find . -name "*.d")
SRC = $(getSources) 

#LIB =  $(D_DIR)/dunit/libdunit.a
#LIB +=  $(D_DIR)/serial-port/libserial-port.a
IS_LIB = true 

# filter_out esclude main.d per evitare conflitti
#SRC_TEST = $(filter-out main.d, $(SRC)) 
SRC_TEST = $(SRC)

#INCLUDES += -I$(D_DIR)/dunit/source

INCLUDES_TEST += $(INCLUDES)

DFLAGS += $(if $(IS_LIB), -lib, )
DFLAGS += -debug -g
DFLAGS += -w -wi
DFLAGS += -m64
LDFLAGS = 
#si usa make VER=x
VERSION_FLAG = $(if $(VERS), -version=$(VERS), )
DFLAGS_TEST += -unittest
# DFLAGS_TEST += -main -quiet

PKG = $(wildcard $(BIN)/$(NAME))
PKG_SRC = $(PKG) $(SRC) makefile
DEFAULT: all

#################
BIN = bin
DMD = dmd
BASE_NAME = $(basename $(NAME))
TEST_NAME = $(BASE_NAME)-test 
DSCAN = ~/dscanner
.PHONY: all clean clobber test run

all: builddir $(BIN)/$(NAME)

builddir:
	@mkdir -p $(BIN)

$(BIN)/$(NAME): $(SRC) $(LIB)| builddir
	$(DMD) $^ $(DFLAGS) $(INCLUDES) $(LDFLAGS) $(VERSION_FLAG) -of$@

run: all
	$(BIN)/$(NAME)

test: $(BIN)/$(TEST_NAME)
	@$(BIN)/$(TEST_NAME)

$(BIN)/$(TEST_NAME): $(SRC_TEST) $(LIB)| builddir
	$(DMD) $^ $(DFLAGS_TEST) $(INCLUDES_TEST) $(VERSION_FLAG) -of$@

pkgdir:
	@mkdir -p pkg

pkg: $(PKG) | pkgdir
	tar -jcf pkg/$(BASE_NAME)-$(VERSION).tar.bz2 $^
	zip pkg/$(BASE_NAME)-$(VERSION).zip $^

pkgsrc: $(PKG_SRC) | pkgdir
	tar -jcf pkg/$(BASE_NAME)-$(VERSION)-src.tar.bz2 $^

tags: $(SRC)
	$(DSCAN) --ctags -R src > tags

style:
	$(DSCAN) --styleCheck -R src/

clean:
	-rm -f $(BIN)/*.o

clobber:
	-rm -Rf $(BIN)/*

var:
	@echo SRC: $(SRC)
	@echo ROOT_SOURCE_DIR: $(ROOT_SOURCE_DIR)
	@echo INCLUDES:
	@echo $(INCLUDES)
	@echo
	@echo DFLAGS: $(DFLAGS)
	@echo
	@echo VERSION:
	@echo $(VERSION_FLAG)
	@echo --- $(getSources)

