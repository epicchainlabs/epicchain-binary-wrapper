NEON_VERSION ?= $(shell node -p 'require("./package.json").neonVersion')
NEON_BINS = \
	neo-one-csharp-osx-v$(NEON_VERSION)/neo-one-csharp \
	neo-one-csharp-linux-v$(NEON_VERSION)/neo-one-csharp \
	neo-one-csharp-win-v$(NEON_VERSION)/neo-one-csharp.exe
NEO_COMPILER = neo-compiler
NEON = neon
NEO_COMPILER_NEON = $(NEO_COMPILER)/$(NEON)
TEST = \
	npm link && \
	neo-one-csharp ./tests/nep-5/bin/Release/nep-5.dll && \
	rm nep-5.abi.json && \
	rm nep-5.avm && \
	npm unlink && \
	rm package-lock.json

.PHONY: all
all: clean build test

.PHONY: clean
clean:
	rm -rf neo-one-csharp-*-v* SHASUM256.txt

.PHONY: test
test: $(NEON_BINS)
	shasum -c SHASUM256.txt
	node test.js

.PHONY: build
build: clean SHASUM256.txt

.PHONY: setup
setup:
	cd $(NEO_COMPILER) && \
	nuget restore && \
	cd $(NEON) && \
	msbuild /p:Configuration=Release /p:Platform=x86

.PHONY: setup-test
setup-test:
	cd tests && \
	nuget restore && \
	msbuild /p:Configuration=Release /p:Platform="Any CPU"

.PHONY: local
local: setup
	mkbundle --simple -o neo-one-csharp --deps -L $(NEO_COMPILER_NEON)/bin/Release $(NEO_COMPILER_NEON)/bin/Release/neon.exe

.PHONY: local-windows
local-windows: setup
	mkbundle --simple -o neo-one-csharp.exe --deps -L $(NEO_COMPILER_NEON)/bin/Release $(NEO_COMPILER_NEON)/bin/Release/neon.exe

.PHONY: local-test
local-test:
	$(TEST)

SHASUM256.txt: $(NEON_BINS)
	shasum -a 256 $^ > $@

neo-one-csharp-osx-v%/neo-one-csharp: setup-test local
	mkdir -p $(@D)
	mv neo-one-csharp $@
	$(TEST)

neo-one-csharp-linux-v%/neo-one-csharp: setup-test
	eval $$(docker-machine env -unset) && docker run -v $$(pwd):/neo neo-one/build-linux:8.9.3 /bin/sh -c "cd neo && make local"
	mkdir -p $(@D)
	mv neo-one-csharp $@
	eval $$(docker-machine env -unset) && docker run -v $$(pwd):/neo neo-one/test-linux:8.9.3 /bin/sh -c "cd neo && make local-test"

neo-one-csharp-win-v%/neo-one-csharp.exe: setup-test
	eval $$(docker-machine env 2016) && docker run -v C:$$(pwd):C:/neo neo-one/build-windowsservercore:ltsc2016 powershell -Command cd neo; make local-windows
	mkdir -p $(@D)
	mv neo-one-csharp.exe $@
	eval $$(docker-machine env 2016) && docker run -v C:$$(pwd):C:/neo neo-one/test-windowsservercore:ltsc2016 powershell -Command cd neo; make local-test
