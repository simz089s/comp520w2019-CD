all:
	ocamllex lexer.mll
	menhir parser.mly
	ocamlc -c parser.mli
	ocamlc -c lexer.ml
	ocamlc -c parser.ml
	ocamlc -c MiniLang.ml
	ocamlc -o MiniLang lexer.cmo parser.cmo MiniLang.cmo
	ocamlbuild -use-ocamlfind -use-menhir main.native

clean:
	echo "Cleaning..."
