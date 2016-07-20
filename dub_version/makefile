# makefile release 0.2.0
NAME = name
PROJECT_VERSION = 0.1.0

#############
# Dirs      #
#############
ROOT_SOURCE_DIR = .
BIN = bin

#############
# Sources   #
#############
SRC = $(getSources)

#############
# Names     #
#############
BASE_NAME = $(basename $(NAME))

#############
# Packages  #
#############
ZIP = $(BIN)/$(NAME)
ZIP_SRC = $(ZIP) $(SRC) dub.json README.md CHANGELOG.md makefile $(SRC_TEST)
ZIP_PREFIX = $(BASE_NAME)-$(PROJECT_VERSION)

#############
# Test      #
#############
TEST_SOURCE_DIR = tests
SRC_TEST += $(shell find $(TEST_SOURCE_DIR) -name "*.d")

getSources = $(shell find $(ROOT_SOURCE_DIR) -name "*.d")

#############
# Commands  #
#############
DUB = dub
DSCAN = $(D_DIR)/Dscanner/bin/dscanner
MKDIR = mkdir -p
RM = -rm -f
UPX = upx --no-progress

#############
# Flags     #
#############
# per impostatare la configurazione conf
# make c=conf
CONFIG += $(if $(c), -c$(c))
DUBFLAGS = -q --combined $(CONFIG)

.PHONY: all release force run test pkgall pkg pkgtar pkgsrc tags style syn loc clean clobber

DEFAULT: all

all:
	$(DUB) build $(DUBFLAGS)  

release:
	$(DUB) build -brelease $(DUBFLAGS)  

force:
	$(DUB) build --force $(DUBFLAGS)  

run:
	@$(DUB) run $(DUBFLAGS)  
run-rel:
	$(DUB) run -brelease $(DUBFLAGS)  
test: 
	$(DUB) test 

upx: $(BIN)/$(NAME)
	$(UPX) $@

pkgdir:
	$(MKDIR) pkg

pkgall: pkg pkgtar pkgsrc

pkg: pkgdir | pkg/$(ZIP_PREFIX).zip

pkg/$(ZIP_PREFIX).zip: $(ZIP)
	zip $@ $(ZIP)

pkgtar: pkgdir | pkg/$(ZIP_PREFIX).tar.bz2

pkg/$(ZIP_PREFIX).tar.bz2: $(ZIP)
	tar -jcf $@ $^

pkgsrc: pkgdir | pkg/$(ZIP_PREFIX)-src.tar.bz2

pkg/$(ZIP_PREFIX)-src.tar.bz2: $(ZIP_SRC)
	tar -jcf $@ $^

tags: $(SRC)
	$(DSCAN) --ctags $^ > tags

style: $(SRC)
	$(DSCAN) --styleCheck $^

syn: $(SRC)
	$(DSCAN) --syntaxCheck $^

loc: $(SRC)
	$(DSCAN) --sloc $^

clean:
	$(DUB) clean

clobber: clean
	$(RM) $(BIN)/$(NAME)
	$(RM) $(BIN)/*.log
	$(RM) $(BIN)/test-runner


ver:
	@echo $(PROJECT_VERSION)

var:
	@echo NAME:       $(NAME)
	@echo PRJ_VER:    $(PROJECT_VERSION)
	@echo BASE_NAME:  $(BASE_NAME)
	@echo DUBFLAGS:   $(DUBFLAGS)
	@echo
	@echo ==== dir ===
	@echo D_DIR: $(D_DIR)
	@echo BIN:   $(BIN)
	@echo ROOT_SOURCE_DIR: $(ROOT_SOURCE_DIR)
	@echo TEST_SOURCE_DIR: $(TEST_SOURCE_DIR)
	@echo
	@echo ==== zip ===
	@echo ZIP: $(ZIP)
	@echo ZIP_SRC: $(ZIP_SRC)
	@echo ZIP_PREFIX: $(ZIP_PREFIX)
	@echo 
	@echo ==== src ===
	@echo SRC:   $(SRC)

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... release Compiles in release mode"
	@echo "... force  Forces a recompilation"
	@echo "... test Executes the tests"
	@echo "... run Builds and runs"
	@echo "... clean Removes intermediate build files"
	@echo "... clobber"
	@echo "... pkg Zip binary"
	@echo "... pkgtar Tar binary"
	@echo "... pkgsrc Tar source"
	@echo "... pkgall Executes pkg, pkgtar, pkgsrc"
	@echo "... tags Generates tag file"
	@echo "... style Checks programming style"
	@echo "... syn Syntax check"
	@echo "... upx Compress using upx"
	@echo "... loc Counts lines of code"
	@echo "... var Lists all variables"
