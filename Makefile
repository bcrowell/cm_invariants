test:
	# Test the cm_parity() function:
	maxima --very-quiet -r "load(\"tests/parity.mac\")$$"
	#
	maxima --very-quiet -r "load(\"tests/flat.mac\")$$"
	maxima --very-quiet -r "load(\"tests/plane_wave.mac\")$$"
	maxima --very-quiet -r "load(\"tests/closed.mac\")$$"
	maxima --very-quiet -r "load(\"tests/vsi.mac\")$$"
	maxima --very-quiet -r "load(\"tests/schwarzschild.mac\")$$"
	maxima --very-quiet -r "load(\"tests/schwarzschild_de_sitter.mac\")$$"
	maxima --very-quiet -r "load(\"tests/end.mac\")$$"
	maxima --very-quiet -r "load(\"tests/de_sitter.mac\")$$"
	maxima --very-quiet -r "load(\"tests/godel.mac\")$$"
	maxima --very-quiet -r "load(\"tests/polynomial.mac\")$$"

clean:
	rm -f *~ tests/*~

doc:
	# Convert README.md to html.
	pandoc --from markdown_github --to html --standalone README.md --output doc.html
