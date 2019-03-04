CC=gcc
CFLAGS=-Wall -pedantic
CLIBS=-lfl -lstdc++

PARSEFLAGS=--verbose --report=all --yacc --defines=parser.tab.c --output=parser.tab.h

all: main.c tree.c tree.h pretty_printer.c pretty_printer.h symbol_table.c symbol_table.h
	flex -l lexer.l
	bison --verbose --report=all -d parser.y
	${CC} ${CFLAGS} $^ -o MiniLang ${CLIBS}

#main: parser.tab.o lex.yy.o main.o
#	$(CC) lex.yy.o parser.tab.o tree.o pretty.o eval.o main.o -o MiniLang -lfl

#parser.tab.c parser.tab.h: parser.y
#	bison $(PARSEFLAGS) $<

#lex.yy.c: lexer.l parser.tab.h
#	flex $<

clean:
	rm lex.yy.c *.output *.tab.?
