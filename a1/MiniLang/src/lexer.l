%{

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

%}

WHITESPACE [ \t\r]
DIGIT [0-9]
DIGITS {DIGIT}*
ALPHA [a-zA-Z]
ALPHANUM {ALPHA}|{DIGIT}
IDENT ({ALPHA}|_)({ALPHANUM}|_)*
SYMBOLS [\~@#$\%\^\&\*\-\+\/`\<\>\=\|\'.,;:\!\?{}[]()]
ESCAPE \\[abfnrtv\"\\]

%option yylineno

%%

\n+
{WHITESPACE}+ printf("Whitespace, length %lu\n", yyleng);

"+"         printf("Plus\n");
"-"         printf("Minus\n");
"*"         printf("Times\n");
"/"         printf("Divide\n");
"("         printf("Left parenthesis\n");
")"         printf("Right parenthesis\n");

0|([1-9]{DIGITS})   { printf("Integer constant: %s\n", yytext); }
{IDENT}             { printf("Identifier: %s\n", yytext); }
{ESCAPE}            { printf("Escape character: %s\n", yytext); }

.       { fprintf(stderr, "Error: (line %d) unexpected character '%s'\n", yylineno, yytext);
          exit(1); }

%%

int main() {
    yylex();
    return 0;
}
