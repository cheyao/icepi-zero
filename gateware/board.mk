# Board revision selection for the demos.
#
# icepi-zero.lpf is no longer shipped in the demo directories - it is a
# symlink generated on demand, so building works out of the box in a fresh
# checkout:
#
#   make                 build with the newest revision, creating the symlink
#                        first if it doesn't exist yet
#   make v1.0            icepi-zero.lpf -> ../v1.0/icepi-zero-v1_0.lpf
#   make v1.1        ... likewise v1.1, v1.2, v1.3, v1.4
#   make latest      reset the symlink to the default (newest revision)
#
# Goals run left to right, so `make v1.3 debug` switches first and builds
# afterwards. The symlink is gitignored: delete it whenever you like, the next
# build recreates the default (check with `readlink icepi-zero.lpf`).
#
# Demos that ship a real icepi-zero.lpf of their own (vendored third-party
# designs with their own net names) are left untouched.

BOARD_VERSIONS := v1.0 v1.1 v1.2 v1.3 v1.4
BOARD_LATEST   := $(lastword $(BOARD_VERSIONS))

# Absolute path of the gateware directory (this file lives in it)
BOARD_MK       := $(realpath $(lastword $(MAKEFILE_LIST)))
GATEWARE_DIR   := $(patsubst %/,%,$(dir $(BOARD_MK)))

# ../ segments from $(CURDIR) up to the gateware directory (empty at the root)
BOARD_RELDIR := $(shell d="$(CURDIR)"; up=""; \
	while [ "$$d" != "$(GATEWARE_DIR)" ]; do \
		if [ "$$d" = "/" ]; then up=""; break; fi; \
		d="$${d%/*}"; up="../$$up"; \
	done; printf '%s' "$$up")

# What the default symlink points at: the shared gateware default in a demo
# directory, the newest revision's file itself at the gateware root (where
# that symlink lives)
BOARD_LATEST_LINK := $(if $(BOARD_RELDIR),$(BOARD_RELDIR)icepi-zero.lpf,$(BOARD_LATEST)/icepi-zero-$(subst .,_,$(BOARD_LATEST)).lpf)

.PHONY: $(BOARD_VERSIONS) latest

define board_guard
if [ -e icepi-zero.lpf ] && [ ! -L icepi-zero.lpf ]; then \
	echo "error: icepi-zero.lpf here is a real file (vendored constraints), not a board-version symlink -- leaving it alone."; \
	exit 1; \
fi
endef

# Auto-creation rule: the build's %.config rule lists icepi-zero.lpf as a
# prerequisite, so a plain `make` creates the default symlink before building
# if it is missing (backward compatibility with the old checked-in symlinks).
# If the file already exists -- symlink or real file -- it is left alone.
icepi-zero.lpf:
	@rm -f icepi-zero.lpf
	@ln -s $(BOARD_LATEST_LINK) icepi-zero.lpf
	@echo "no icepi-zero.lpf found -- created default symlink -> $(BOARD_LATEST_LINK)"

$(BOARD_VERSIONS):
	@$(board_guard)
	@rm -f icepi-zero.lpf
	@ln -s $(BOARD_RELDIR)$@/icepi-zero-$(subst .,_,$@).lpf icepi-zero.lpf
	@echo "icepi-zero.lpf -> $(BOARD_RELDIR)$@/icepi-zero-$(subst .,_,$@).lpf"

latest:
	@$(board_guard)
	@rm -f icepi-zero.lpf
	@ln -s $(BOARD_LATEST_LINK) icepi-zero.lpf
	@echo "icepi-zero.lpf -> $(BOARD_LATEST_LINK)"
