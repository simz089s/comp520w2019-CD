%{

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

extern int yylineno;

int yylex();

void yyerror(const char* s) { fprintf(stderr, "Error: %s\n", s); }

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

%token <bool_val> tBOOLTYPE
%token <int_val> tINTTYPE
%token <float_val> tFLOATTYPE
%token <string_val> tSTRINGTYPE
%token <ident> tIDENT
%token tLPAREN tRPAREN
%token tLBRACE tRBRACE
%token tSEMICOLON
%token tVAR
%token tIF tELSE
%token tWHILE
%token tREAD tPRINT
%token tASSIGN
%token tCOMMENT
%token tADD tSUB tMUL tDIV
%token tEQUALS tNEQUALS tGREATEREQ tLESSEQ tGREATER tLESS
%token tAND tOR tNOT
%token tNEG
%token tEOF tEOL

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

program : stmts tEOF    { yyerror("End of file"); }
        ;

stmts   : %empty    { }
        | stmt stmts { }
        ;

stmt    : tREAD tLPAREN tIDENT tRPAREN tSEMICOLON /* read(x); */
        | tPRINT tLPAREN expr tRPAREN tSEMICOLON /* print(x); */
        | decl
        | tIDENT tASSIGN expr tSEMICOLON /* x = 1+1; */
        | ifstmt
        | elsestmt
        | whileloop
        ;

decl    : tVAR tIDENT tSEMICOLON tBOOLTYPE tSEMICOLON
        | tVAR tIDENT tSEMICOLON tINTTYPE tSEMICOLON
        | tVAR tIDENT tSEMICOLON tFLOATTYPE tSEMICOLON
        | tVAR tIDENT tSEMICOLON tSTRINGTYPE tSEMICOLON
        | tVAR tIDENT tSEMICOLON tBOOLTYPE tASSIGN expr tSEMICOLON
        | tVAR tIDENT tSEMICOLON tINTTYPE tASSIGN expr tSEMICOLON
        | tVAR tIDENT tSEMICOLON tFLOATTYPE tASSIGN expr tSEMICOLON
        | tVAR tIDENT tSEMICOLON tSTRINGTYPE tASSIGN expr tSEMICOLON
        ;

ifstmt  : tIF tLPAREN expr tRPAREN tLBRACE stmts tRBRACE
        | tIF tLPAREN expr tRPAREN tLBRACE stmts tRBRACE elsestmt
        ;

elsestmt    : tELSE tLBRACE stmts tRBRACE
            | tELSE ifstmt
            ;

whileloop   : tWHILE tLPAREN expr tRPAREN tLBRACE stmts tRBRACE
            ;

expr    : tIDENT
        | tBOOLTYPE
        | tINTTYPE
        | tFLOATTYPE
        | tSTRINGTYPE
        | tNEG expr %prec tNEG
        | tNOT expr %prec tNOT
        | tLPAREN expr tRPAREN
        | expr tMUL expr
        | expr tDIV expr
        | expr tADD expr
        | expr tSUB expr
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

int main() {
    yyparse();
    return 0;
}
