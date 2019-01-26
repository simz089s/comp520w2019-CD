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
}

%token <bool_val> tBOOLVAL
%token <int_val> tINTVAL
%token <float_val> tFLOATVAL
%token <string_val> tIDENT
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
%nonassoc tEQUALS tNEQUALS
%nonassoc tGREATEREQ tLESSEQ tGREATER tLESS
%left tADD tSUB
%left tMUL tDIV
%nonassoc tNEG tNOT
%nonassoc tLPAREN

%start program

%%
program : stmts tEOF    { yyerror("End of file"); }
        ;

stmts   : stmt T_SEMICOLON stmts    { }
        ;

stmt    : T_IDENT T_ASSIGN expr             { $$ = gen_assign($1, $3); }
        | T_READ T_LPAREN T_IDENT T_RPAREN  { $$ = gen_read($3); }
        | T_PRINT T_LPAREN expr T_RPAREN    { $$ = gen_print($3); }
        ;

exp : tIDENT                { $$ = genEXP_ident($1); }
    | tINTVAL               { $$ = genEXP_int_val($1); }
    | exp tMUL exp          { $$ = genEXP_bin_op(k_expressionKindMultiplication, $1, $3); }
    | exp tDIV exp          { $$ = genEXP_bin_op(k_expressionKindDivision, $1, $3); }
    | exp tADD exp          { $$ = genEXP_bin_op(k_expressionKindAddition, $1, $3); }
    | exp tSUB exp          { $$ = genEXP_bin_op(k_expressionKindSubtraction, $1, $3); }
    | tLPAREN exp tRPAREN   { $$ = $2; }
    | tSUB expr %prec tNEG  { $$ = - $2; }
    ;
%%

int main() {
    yyparse();
    return 0;
}
