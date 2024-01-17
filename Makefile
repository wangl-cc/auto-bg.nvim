SRCDIR = src
BUILDDIR = build

SWIFTC ?= swiftc
SWIFTCFLAGS ?= -O -whole-module-optimization -lto=llvm-full

TARGETS =

ifeq ($(shell uname),Darwin)
	TARGETS += $(BUILDDIR)/watcher-universal-macos
endif

all: $(TARGETS)

# watcher for macOS
$(BUILDDIR)/%-universal-macos: $(BUILDDIR)/%-x86_64-macos $(BUILDDIR)/%-arm64-macos
	lipo -create -output $@ $^

$(BUILDDIR)/%-x86_64-macos: $(SRCDIR)/%.swift
	$(SWIFTC) -o $@ $< -target x86_64-apple-macos10.15 $(SWIFTCFLAGS)
$(BUILDDIR)/%-arm64-macos: $(SRCDIR)/%.swift
	$(SWIFTC) -o $@ $< -target arm64-apple-macos11 $(SWIFTCFLAGS)

clean:
	rm $(TARGETS)
