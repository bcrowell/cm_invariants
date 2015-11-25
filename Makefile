test_symmetry:
	maxima --very-quiet -r "load(\"test_symmetry.mac\");"

test_all:
	maxima --very-quiet -r "load(\"test_flat.mac\");"
	maxima --very-quiet -r "load(\"test_vsi.mac\");"
	maxima --very-quiet -r "load(\"test_sch.mac\");"
	maxima --very-quiet -r "load(\"test_end.mac\");"
	maxima --very-quiet -r "load(\"test_de_sitter.mac\");"
