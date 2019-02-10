CC=gcc
CFLAGS=-o

PARSEFLAGS=--verbose --report=all --yacc --defines=parser.tab.c --output=parser.tab.h

all: main.c
	flex -l lexer.l
	bison --verbose --report=all -d parser.y
	$(CC) main.c -o MiniLang -lfl

#main: parser.tab.o lex.yy.o main.o
#	$(CC) lex.yy.o parser.tab.o tree.o pretty.o eval.o main.o -o MiniLang -lfl

#parser.tab.c parser.tab.h: parser.y
#	bison $(PARSEFLAGS) $<

#lex.yy.c: lexer.l parser.tab.h
#	flex $<

clean:
	rm lex.yy.c parser.output parser.tab.*
