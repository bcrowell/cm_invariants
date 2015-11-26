test_all:
	maxima --very-quiet -r "load(\"tests/parity.mac\");"
	maxima --very-quiet -r "load(\"tests/flat.mac\");"
	maxima --very-quiet -r "load(\"tests/plane_wave.mac\");"
	maxima --very-quiet -r "load(\"tests/vsi.mac\");"
	maxima --very-quiet -r "load(\"tests/sch.mac\");"
	maxima --very-quiet -r "load(\"tests/end.mac\");"
	maxima --very-quiet -r "load(\"tests/de_sitter.mac\");"
