%{

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

%}

SYMBOL [~@\#\$%^&*\-+\/`<>=\|'.,;:!?{}\[\]()]
SINGLEQUOTE '
ESCAPE \\[abfnrtv\"\\]
WHITESPACE [ \t\r]
DIGIT [0-9]
DIGITS {DIGIT}*
ALPHA [a-zA-Z]
ALPHANUM {ALPHA}|{DIGIT}

%option yylineno

%%

\n+
{WHITESPACE}+

"//".* {
    printf("Comment: %s\n", yytext);
}

"var" { puts("Keyword: var"); }
"float" { puts("Keyword: float"); }
"int" { puts("Keyword: int"); }
"string" { puts("Keyword: string"); }
"boolean" { puts("Keyword: boolean"); }
"if" { puts("Keyword: if"); }
"else" { puts("Keyword: else"); }
"while" { puts("Keyword: while"); }
"read" { puts("Keyword: read"); }
"print" { puts("Keyword: print"); }
"true" { puts("Keyword: true"); }
"false" { puts("Keyword: false"); }

"="  { printf("Assignment operator: %s\n", yytext); }
"{" { printf("Left curly brace\n"); }
"}" { printf("Right curly brace\n"); }

"+" printf("Plus\n");
"-" printf("Minus\n");
"*" printf("Times\n");
"/" printf("Divide\n");
"(" printf("Left parenthesis\n");
")" printf("Right parenthesis\n");
"==" { printf("Operator: %s\n", yytext); }
"!=" { printf("Operator: %s\n", yytext); }
">=" { printf("Operator: %s\n", yytext); }
"<=" { printf("Operator: %s\n", yytext); }
">" { printf("Operator: %s\n", yytext); }
"<" { printf("Operator: %s\n", yytext); }
"&&" { printf("Operator: %s\n", yytext); }
"||" { printf("Operator: %s\n", yytext); }

(0|([1-9]{DIGITS}))\.{DIGITS} {
    printf("Floating point number: %s\n", yytext);
}

0|([1-9]{DIGITS}) {
    printf("Integer constant: %s\n", yytext);
}

{SYMBOL} {
    printf("Symbol: %s\n", yytext);
}

{ESCAPE} {
    printf("Escape character: %s\n", yytext);
}

({ALPHA}|_)({ALPHANUM}|_)* {
    printf("Identifier: %s\n", yytext);
}

\"[ {ALPHANUM}{SYMBOL}{ESCAPE}]*\" {
    printf("String: %s\n", yytext); }

. {
    fprintf(stderr, "Error: (line %d) unexpected character '%s'\n", yylineno, yytext);
    exit(1);
}

%%

int main() {
    yylex();
    return 0;
}
