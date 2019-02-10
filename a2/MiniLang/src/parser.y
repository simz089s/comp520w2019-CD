%{

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "tree.h"

extern int yylineno;

/* extern EXPR* root; */

int yylex();

void yyerror(const char* s) {
    fprintf(stderr, "Error: (line %d) Parse: invalid parse '%s'\n", yylineno, yytext);
    exit(1);
}

%}

%locations
%error-verbose

%code requires
{
	#include "tree.h"
}

%union {
    bool bool_val;
    int int_val;
    float float_val;
    char* string_val;
    char* ident;
    EXPR* expr;
}

%type <stmts> program stmts

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
%token tADD tMUL tDIV
%token tMINUS
%token tEQUALS tNEQUALS tGREATEREQ tLESSEQ tGREATER tLESS
%token tAND tOR tNOT

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

program : stmts /* { root = $1; } */
        ;

stmts   : %empty        { $$ = NULL; }
        | stmt stmts    { $$ = genSTMTS($1, $2); }
        ;

stmt    : tREAD tLPAREN tIDENT tRPAREN tSEMICOLON   { $$ = genSTMT_read($3); } /* read(x); */
        | tPRINT tLPAREN expr tRPAREN tSEMICOLON    { $$ = genSTMT_print($3); } /* print(x); */
        | decl
        | tIDENT tASSIGN expr tSEMICOLON            { $$ = genSTMT_assignment($1, $3); } /* x = 1+1; */
        | ifstmt
        | whileloop
        | tCOMMENT
        ;

decl    : tVAR tIDENT tCOLON tBOOLTYPE tSEMICOLON                   { $$ = genSTMT_declaration($2, $4); }
        | tVAR tIDENT tCOLON tINTTYPE tSEMICOLON                    { $$ = genSTMT_declaration($2, $4); }
        | tVAR tIDENT tCOLON tFLOATTYPE tSEMICOLON                  { $$ = genSTMT_declaration($2, $4); }
        | tVAR tIDENT tCOLON tSTRINGTYPE tSEMICOLON                 { $$ = genSTMT_declaration($2, $4); }
        | tVAR tIDENT tCOLON tBOOLTYPE tASSIGN expr tSEMICOLON      { $$ = genSTMT_declarationInitialized($2, $4, $6); }
        | tVAR tIDENT tCOLON tINTTYPE tASSIGN expr tSEMICOLON       { $$ = genSTMT_declarationInitialized($2, $4, $6); }
        | tVAR tIDENT tCOLON tFLOATTYPE tASSIGN expr tSEMICOLON     { $$ = genSTMT_declarationInitialized($2, $4, $6); }
        | tVAR tIDENT tCOLON tSTRINGTYPE tASSIGN expr tSEMICOLON    { $$ = genSTMT_declarationInitialized($2, $4, $6); }
        ;

ifstmt  : tIF tLPAREN expr tRPAREN tLBRACE stmts tRBRACE elsestmt   { $$ = genSTMT_if($3, $6, $8); }
        ;

elsestmt    : tELSE tLBRACE stmts tRBRACE   { $$ = genSTMT_else($3); }
            | tELSE ifstmt                  { $$ = genSTMT_elseIf($2); }
            | %empty                        { $$ = NULL; }
            ;

whileloop   : tWHILE tLPAREN expr tRPAREN tLBRACE stmts tRBRACE { $$ = genSTMT_while($3, $6); }
            ;

expr    : tIDENT                { $$ = genEXPR_identifier($1); }
        | tTRUE                 { $$ = genEXPR_boolLiteral($1); }
        | tFALSE                { $$ = genEXPR_boolLiteral($1); }
        | tINTVAL               { $$ = genEXPR_intLiteral($1); }
        | tFLOATVAL             { $$ = genEXPR_floatLiteral($1); }
        | tSTRINGVAL            { $$ = genEXPR_stringLiteral($1); }
        | tMINUS expr           { $$ = genEXPR_unary(k_expressionKindMinus, $2); }
        | tNOT expr             { $$ = genEXPR_unary(k_expressionKindNot, $2); }
        | tLPAREN expr tRPAREN  { $$ = $2; }
        | expr tMUL expr        { $$ = genEXPR_binary(k_expressionKindMultiplication, $1, $3); }
        | expr tDIV expr        { $$ = genEXPR_binary(k_expressionKindDivision, $1, $3); }
        | expr tADD expr        { $$ = genEXPR_binary(k_expressionKindAddition, $1, $3); }
        | expr tMINUS expr      { $$ = genEXPR_binary(k_expressionKindSubtraction, $1, $3); }
        | expr tGREATEREQ expr  { $$ = genEXPR_binary(k_expressionKindGreaterEqual, $1, $3); }
        | expr tLESSEQ expr     { $$ = genEXPR_binary(k_expressionKindLessEqual, $1, $3); }
        | expr tGREATER expr    { $$ = genEXPR_binary(k_expressionKindGreater, $1, $3); }
        | expr tLESS expr       { $$ = genEXPR_binary(k_expressionKindLess, $1, $3); }
        | expr tEQUALS expr     { $$ = genEXPR_binary(k_expressionKindEquals, $1, $3); }
        | expr tNEQUALS expr    { $$ = genEXPR_binary(k_expressionKindNotEquals, $1, $3); }
        | expr tAND expr        { $$ = genEXPR_binary(k_expressionKindAnd, $1, $3); }
        | expr tOR expr         { $$ = genEXPR_binary(k_expressionKindOr, $1, $3); }
        ;

%%
