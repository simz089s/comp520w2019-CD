%{

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

extern int yylineno;

int yylex();

void yyerror(const char* s) {
    fprintf(stderr, "Error: (line %d) Parse: invalid parse '%s'\n", yylineno, yytext);
    exit(1);
}

%}

%locations
%error-verbose

%union {
    bool bool_val;
    int int_val;
    float float_val;
    char* string_val;
    char* ident;
}

%token <bool_val> tTRUE tFALSE
%token <int_val> tINTVAL
%token <float_val> tFLOATVAL
%token <string_val> tSTRINGVAL
%token tBOOLTYPE
%token tINTTYPE
%token tFLOATTYPE
%token tSTRINGTYPE
%token <ident> tIDENT
%token tLPAREN tRPAREN
%token tLBRACE tRBRACE
%token tSEMICOLON
%token tVAR
%token tIF tELSE
%token tWHILE
%token tREAD tPRINT
%token tCOLON
%token tASSIGN
%token tCOMMENT
%token tADD /*tSUB*/ tMUL tDIV
%token tEQUALS tNEQUALS tGREATEREQ tLESSEQ tGREATER tLESS
%token tAND tOR tNOT
%token tMINUS
/*%token tNEG
%token tEOF tEOL*/

%left tOR
%left tAND
%left tEQUALS tNEQUALS
%left tGREATEREQ tLESSEQ tGREATER tLESS
%left tADD tSUB
%left tMUL tDIV
%left tNEG tNOT
%left tLPAREN

%start program

%%

program : stmts
        ;

stmts   : %empty        { }
        | stmt stmts    { $$ = genSTMTS($1, $2); }
        ;

stmt    : tREAD tLPAREN tIDENT tRPAREN tSEMICOLON /* read(x); */
        | tPRINT tLPAREN expr tRPAREN tSEMICOLON /* print(x); */
        | decl
        | tIDENT tASSIGN expr tSEMICOLON /* x = 1+1; */
        | ifstmt
        | whileloop
        | tCOMMENT
        ;

decl    : tVAR tIDENT tCOLON tBOOLTYPE tSEMICOLON
        | tVAR tIDENT tCOLON tINTTYPE tSEMICOLON
        | tVAR tIDENT tCOLON tFLOATTYPE tSEMICOLON
        | tVAR tIDENT tCOLON tSTRINGTYPE tSEMICOLON
        | tVAR tIDENT tCOLON tBOOLTYPE tASSIGN expr tSEMICOLON
        | tVAR tIDENT tCOLON tINTTYPE tASSIGN expr tSEMICOLON
        | tVAR tIDENT tCOLON tFLOATTYPE tASSIGN expr tSEMICOLON
        | tVAR tIDENT tCOLON tSTRINGTYPE tASSIGN expr tSEMICOLON
        ;

ifstmt  : tIF tLPAREN expr tRPAREN tLBRACE stmts tRBRACE elsestmt
        | tIF tLPAREN expr tRPAREN tLBRACE stmts tRBRACE
        ;

elsestmt    : tELSE tLBRACE stmts tRBRACE
            | tELSE ifstmt
            ;

whileloop   : tWHILE tLPAREN expr tRPAREN tLBRACE stmts tRBRACE
            ;

expr    : tIDENT                { $$ = genEXPR_identifier($1); }
        | tTRUE                 { $$ = genEXPR_($1); }
        | tFALSE
        | tINTVAL               { $$ = genEXPR_intLiteral($1); }
        | tFLOATVAL
        | tSTRINGVAL
        | tMINUS expr           { $$ = - $2; }
        | tMINUS expr
        | tNOT expr
        | tLPAREN expr tRPAREN  { $$ = $2; }
        | expr tMUL expr        { $$ = genEXPR_binary(k_expressionKindMultiplication, $1, $3); }
        | expr tDIV expr        { $$ = genEXPR_binary(k_expressionKindDivision, $1, $3); }
        | expr tADD expr        { $$ = genEXPR_binary(k_expressionKindAddition, $1, $3); }
        | expr tMINUS expr      { $$ = genEXPR_binary(k_expressionKindSubtraction, $1, $3); }
        | expr tGREATEREQ expr
        | expr tLESSEQ expr
        | expr tGREATER expr
        | expr tLESS expr
        | expr tEQUALS expr
        | expr tNEQUALS expr
        | expr tAND expr
        | expr tOR expr
        ;

%%

/*int main() {
    yyparse();
    return 0;
}*/
