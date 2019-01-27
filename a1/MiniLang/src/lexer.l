%{

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool tokens_mode = false;

%}

SYMBOL [~@\#\$%^&*\-+\/`<>=\|'.,;:!?{}\[\]()]
SINGLEQUOTE ' /* Put here because editor's syntax highlighter can't properly lex lexer generator syntax :) */
ESCAPE \\[abfnrtv\"\\]
WHITESPACE [ \t\r]
DIGIT [0-9]
DIGITS [0-9]*
ALPHA [a-zA-Z]
ALPHANUM [a-zA-Z0-9]

%option yylineno

%%

\n+
{WHITESPACE}+

"//".* {
    if (tokens_mode) printf("Comment: %s\n", yytext);
}

"var"       { if (tokens_mode) printf("Keyword: var\n"); }
"float"     { if (tokens_mode) printf("Keyword: float\n"); }
"int"       { if (tokens_mode) printf("Keyword: int\n"); }
"string"    { if (tokens_mode) printf("Keyword: string\n"); }
"boolean"   { if (tokens_mode) printf("Keyword: boolean\n"); }
"if"        { if (tokens_mode) printf("Keyword: if\n"); }
"else"      { if (tokens_mode) printf("Keyword: else\n"); }
"while"     { if (tokens_mode) printf("Keyword: while\n"); }
"read"      { if (tokens_mode) printf("Keyword: read\n"); }
"print"     { if (tokens_mode) printf("Keyword: print\n"); }
"true"      { if (tokens_mode) printf("Keyword: boolean value true\n"); }
"false"     { if (tokens_mode) printf("Keyword: boolean value false\n"); }

":" { if (tokens_mode) printf("Assignment identifier/type colon separator: %s\n", yytext); }
"=" { if (tokens_mode) printf("Assignment operator: %s\n", yytext); }
"{" { if (tokens_mode) printf("Left curly brace\n"); }
"}" { if (tokens_mode) printf("Right curly brace\n"); }
";" { if (tokens_mode) printf("End of statement semicolon: %s\n", yytext); }

"+"     { if (tokens_mode) printf("Plus\n"); }
"-"     { if (tokens_mode) printf("Minus\n"); }
"*"     { if (tokens_mode) printf("Multiply\n"); }
"/"     { if (tokens_mode) printf("Divide\n"); }
"("     { if (tokens_mode) printf("Left parenthesis\n"); }
")"     { if (tokens_mode) printf("Right parenthesis\n"); }
"=="    { if (tokens_mode) printf("Relational operator (binary): %s\n", yytext); }
"!="    { if (tokens_mode) printf("Relational operator (binary): %s\n", yytext); }
">="    { if (tokens_mode) printf("Comparison operator (binary): %s\n", yytext); }
"<="    { if (tokens_mode) printf("Comparison operator (binary): %s\n", yytext); }
">"     { if (tokens_mode) printf("Comparison operator (binary): %s\n", yytext); }
"<"     { if (tokens_mode) printf("Comparison operator (binary): %s\n", yytext); }
"&&"    { if (tokens_mode) printf("Logical operator (binary): %s\n", yytext); }
"||"    { if (tokens_mode) printf("Logical operator (binary): %s\n", yytext); }

(0|([1-9]{DIGITS}))\.{DIGITS} {
    if (tokens_mode) printf("Floating point number: %s\n", yytext);
}

(0[^0-9])|([1-9]{DIGITS}) {
    if (tokens_mode) printf("Integer constant: %s\n", yytext);
}

({ALPHA}|_)({ALPHANUM}|_)* {
    if (tokens_mode) printf("Identifier: %s\n", yytext);
}

\"[ {ALPHANUM}{SYMBOL}{ESCAPE}]*\" {
    if (tokens_mode) printf("String: %s\n", yytext); }

. {
    fprintf(stderr, "Error: (line %d) unexpected character '%s'\n", yylineno, yytext);
    exit(1);
}

%%

/*int main() {
    yylex();
    return 0;
}*/
