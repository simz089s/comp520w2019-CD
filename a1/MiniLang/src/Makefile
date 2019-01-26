CC=gcc
CFLAGS=-Wall -pedantic -o

LEXGEN=flex

PARSEGEN=bison
PARSEFLAGS=--verbose

all:
	#$(PARSEGEN) $(PARSEFLAGS) parser.y
	$(LEXGEN) lexer.l
	$(CC) $(CFLAGS) MiniLang lex.yy.c -lfl

parser: parser.y
	$(PARSEGEN) $(PARSEFLAGS) parser.y

lexer: lex.yy.c lexer.l
	$(LEXGEN) lexer.l
	$(CC) $(CFLAGS) $@ lex.yy.c -lfl

clean:
	echo "NOT Cleaning..."
