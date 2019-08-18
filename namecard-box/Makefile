OCAML = ocaml
SCAD = openscad

namecard-box.stl: namecard-box.scad
	$(SCAD) namecard-box.scad -o namecard-box.stl

namecard-box.scad: main.ml
	$(OCAML) main.ml

.PHONY: clean
clean:
	$(RM) *.scad *.stl
