TARGETS =

SRCDIR = src
BUILDDIR = build
SWIFTC ?= swiftc

ifeq ($(shell uname),Darwin)
	TARGETS += $(BUILDDIR)/watcher
endif

all: $(TARGETS)

# watcher for macOS
$(BUILDDIR)/watcher: $(SRCDIR)/watcher.swift
	$(SWIFTC) -o $@ $<

