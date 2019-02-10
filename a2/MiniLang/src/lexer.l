%{

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "parser.tab.c"

#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno;

bool tokens_mode = false;

%}

SYMBOL [~@\#\$%^&*\-+\/`<>=_\|'.,;:!?{}\[\]()]
ESCAPE \\[abfnrtv\"\\]
WHITESPACE [ \t\r]
DIGIT [0-9]
ALPHA [a-zA-Z]
ALPHANUM [a-zA-Z0-9]

%option yylineno

%%

\n+
{WHITESPACE}+

"//".* {
    if (tokens_mode) printf("Comment: %s\n", yytext);
    /*return tCOMMENT;*/
}

"var"       { if (tokens_mode) printf("Keyword: var\n"); return tVAR; }
"float"     { if (tokens_mode) printf("Keyword: float\n"); return tFLOATTYPE; }
"int"       { if (tokens_mode) printf("Keyword: int\n"); return tINTTYPE; }
"string"    { if (tokens_mode) printf("Keyword: string\n"); return tSTRINGTYPE; }
"boolean"   { if (tokens_mode) printf("Keyword: boolean\n"); return tBOOLTYPE; }
"if"        { if (tokens_mode) printf("Keyword: if\n"); return tIF; }
"else"      { if (tokens_mode) printf("Keyword: else\n"); return tELSE; }
"while"     { if (tokens_mode) printf("Keyword: while\n"); return tWHILE; }
"read"      { if (tokens_mode) printf("Keyword: read\n"); return tREAD; }
"print"     { if (tokens_mode) printf("Keyword: print\n"); return tPRINT; }
"true"      { if (tokens_mode) printf("Keyword: boolean value true\n"); return tTRUE; }
"false"     { if (tokens_mode) printf("Keyword: boolean value false\n"); return tFALSE; }

":" { if (tokens_mode) printf("Assignment identifier/type colon separator: %s\n", yytext); return tCOLON; }
"=" { if (tokens_mode) printf("Assignment operator: %s\n", yytext); return tASSIGN; }
"{" { if (tokens_mode) printf("Left curly brace\n"); return tLBRACE; }
"}" { if (tokens_mode) printf("Right curly brace\n"); return tRBRACE; }
";" { if (tokens_mode) printf("End of statement semicolon: %s\n", yytext); return tSEMICOLON; }

"+"     { if (tokens_mode) printf("Plus\n"); return tADD; }
"-"     { if (tokens_mode) printf("Minus\n"); return tMINUS; }
"*"     { if (tokens_mode) printf("Multiply\n"); return tMUL; }
"/"     { if (tokens_mode) printf("Divide\n"); return tDIV; }
"("     { if (tokens_mode) printf("Left parenthesis\n"); return tLPAREN; }
")"     { if (tokens_mode) printf("Right parenthesis\n"); return tRPAREN; }
"=="    { if (tokens_mode) printf("Relational operator (binary): %s\n", yytext); return tEQUALS; }
"!="    { if (tokens_mode) printf("Relational operator (binary): %s\n", yytext); return tNEQUALS; }
">="    { if (tokens_mode) printf("Comparison operator (binary): %s\n", yytext); return tGREATEREQ; }
"<="    { if (tokens_mode) printf("Comparison operator (binary): %s\n", yytext); return tLESSEQ; }
">"     { if (tokens_mode) printf("Comparison operator (binary): %s\n", yytext); return tGREATER; }
"<"     { if (tokens_mode) printf("Comparison operator (binary): %s\n", yytext); return tLESS; }
"&&"    { if (tokens_mode) printf("Logical operator (binary): %s\n", yytext); return tAND; }
"||"    { if (tokens_mode) printf("Logical operator (binary): %s\n", yytext); return tOR; }
"!"     { if (tokens_mode) printf("Logical operator (unary): %s\n", yytext); return tNOT; }

(0|([1-9][0-9]*))\.[0-9]+ {
    if (tokens_mode) printf("Floating point number: %s\n", yytext);
    yylval.float_val = strtof(yytext, NULL);
    return tFLOATVAL;
}

0|([1-9]{DIGIT}*) {
    if (tokens_mode) printf("Integer constant: %s\n", yytext);
    yylval.int_val = strtol(yytext, NULL, 10);
    return tINTVAL;
}

({ALPHA}|_)({ALPHANUM}|_)* {
    if (tokens_mode) printf("Identifier: %s\n", yytext);
    yylval.ident = strdup(yytext);
    return tIDENT;
}

\"([ a-zA-Z0-9~@\#\$%^&*\-+\/`<>=_\|'.,;:!?{}\[\]()']|{ESCAPE})*\" {
    if (tokens_mode) printf("String: %s\n", yytext);
    yylval.string_val = strdup(yytext);
    return tSTRINGVAL;
}

. {
    fprintf(stderr, "Error: (line %d) Scan: unexpected character '%s'\n", yylineno, yytext);
    exit(1);
}

%%

/*int main() {
    yylex();
    return 0;
}*/
