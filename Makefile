SRCDIR = src
BUILDDIR = build
SWIFTC ?= swiftc

TARGETS = $(BUILDDIR)/watcher-macos

all: $(TARGETS)

# watcher for macOS
$(BUILDDIR)/watcher-macos: $(BUILDDIR)/watcher-x86_64-macos $(BUILDDIR)/watcher-arm64-macos
	lipo -create -output $@ $^

$(BUILDDIR)/%-x86_64-macos: $(SRCDIR)/%.swift
	$(SWIFTC) -o $@ $< -target x86_64-apple-macos10.15
$(BUILDDIR)/%-arm64-macos: $(SRCDIR)/%.swift
	$(SWIFTC) -o $@ $< -target arm64-apple-macos11
