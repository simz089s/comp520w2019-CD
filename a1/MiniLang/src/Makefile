all:
	ocamllex MiniLang_lexer.mll
	menhir MiniLang_parser.mly
	ocamlc -c MiniLang_parser.mli
	ocamlc -c MiniLang_lexer.ml
	ocamlc -c MiniLang_parser.ml
	ocamlc -c MiniLang.ml
	ocamlc -o MiniLang MiniLang_lexer.cmo MiniLang_parser.cmo MiniLang_.cmo

clean:
	echo "Cleaning..."
