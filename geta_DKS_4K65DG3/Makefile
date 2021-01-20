BIN := _build/default/bin/main.exe
SCAD := geta.scad
STL := $(patsubst %.scad,%.stl,$(SCAD))

SOURCES := \
	$(shell find bin -type f -name *.ml) \
	$(shell find bin -type f -name dune) \
	$(shell find lib -type f -name *.ml) \
	$(shell find lib -type f -name dune) \
	dune-project

.PHONY: all
all: $(STL)

.PHONY: clean
clean:
	rm -rf _build
	rm -rf *.stl
	rm -rf *.scad

%.stl: %.scad
	openscad $< -o $@

$(SCAD): $(BIN)
	./$(BIN)

$(BIN): $(SOURCES)
	dune build
