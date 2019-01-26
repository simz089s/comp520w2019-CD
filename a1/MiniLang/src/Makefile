all:
	flex lexer.l
	gcc -o MiniLang lex.yy.c -lfl
	#bison --verbose parser.y

clean:
	echo "Cleaning..."
