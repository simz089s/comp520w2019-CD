/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tTRUE = 258,
    tFALSE = 259,
    tINTVAL = 260,
    tFLOATVAL = 261,
    tSTRINGVAL = 262,
    tBOOLTYPE = 263,
    tINTTYPE = 264,
    tFLOATTYPE = 265,
    tSTRINGTYPE = 266,
    tIDENT = 267,
    tLPAREN = 268,
    tRPAREN = 269,
    tLBRACE = 270,
    tRBRACE = 271,
    tSEMICOLON = 272,
    tVAR = 273,
    tIF = 274,
    tELSE = 275,
    tWHILE = 276,
    tREAD = 277,
    tPRINT = 278,
    tCOLON = 279,
    tASSIGN = 280,
    tCOMMENT = 281,
    tADD = 282,
    tSUB = 283,
    tMUL = 284,
    tDIV = 285,
    tEQUALS = 286,
    tNEQUALS = 287,
    tGREATEREQ = 288,
    tLESSEQ = 289,
    tGREATER = 290,
    tLESS = 291,
    tAND = 292,
    tOR = 293,
    tNOT = 294,
    tNEG = 295
  };
#endif
/* Tokens.  */
#define tTRUE 258
#define tFALSE 259
#define tINTVAL 260
#define tFLOATVAL 261
#define tSTRINGVAL 262
#define tBOOLTYPE 263
#define tINTTYPE 264
#define tFLOATTYPE 265
#define tSTRINGTYPE 266
#define tIDENT 267
#define tLPAREN 268
#define tRPAREN 269
#define tLBRACE 270
#define tRBRACE 271
#define tSEMICOLON 272
#define tVAR 273
#define tIF 274
#define tELSE 275
#define tWHILE 276
#define tREAD 277
#define tPRINT 278
#define tCOLON 279
#define tASSIGN 280
#define tCOMMENT 281
#define tADD 282
#define tSUB 283
#define tMUL 284
#define tDIV 285
#define tEQUALS 286
#define tNEQUALS 287
#define tGREATEREQ 288
#define tLESSEQ 289
#define tGREATER 290
#define tLESS 291
#define tAND 292
#define tOR 293
#define tNOT 294
#define tNEG 295

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 18 "parser.y" /* yacc.c:1909  */

    bool bool_val;
    int int_val;
    float float_val;
    char* string_val;
    char* ident;

#line 142 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;
int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
