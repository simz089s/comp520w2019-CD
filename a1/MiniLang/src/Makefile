CC=gcc
CFLAGS=-o

LEXGEN=flex

PARSEGEN=bison
PARSEFLAGS=--verbose --report=all

all: main.c
	$(PARSEGEN) $(PARSEFLAGS) parser.y
	$(LEXGEN) lexer.l
	$(CC) $(CFLAGS) MiniLang main.c -lfl

parser: parser.y
	$(PARSEGEN) $(PARSEFLAGS) parser.y

lexer: lex.yy.c lexer.l
	$(LEXGEN) lexer.l
	$(CC) $(CFLAGS) $@ lex.yy.c -lfl

clean:
	rm lex.yy.c parser.output parser.tab.c
