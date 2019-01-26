%token <bool> T_TRUE T_FALSE
%token <int> T_INT
%token <float> T_FLOAT
%token <string> T_IDENT
%token T_LPAREN T_RPAREN
%token T_LBRACE T_RBRACE
%token T_SEMICOLON
%token T_VAR
%token T_STRING
%token T_BOOL
%token T_IF T_ELSE
%token T_WHILE
%token T_READ T_PRINT
%token T_COMMENT
%token T_ADD T_SUB T_MUL T_DIV
%token T_EQUALS T_NEQUALS T_GREATEREQ T_LESSEQ T_GREATER T_LESS
%token T_AND T_OR T_NOT
%token T_NEG
%token T_EOF T_EOL

%left T_OR
%left T_AND
%nonassoc T_EQUALS T_NEQUALS
%nonassoc T_GREATEREQ T_LESSEQ T_GREATER T_LESS
%left T_ADD T_SUB
%left T_MUL T_DIV
%nonassoc T_NEG T_NOT
%nonassoc T_LPAREN

%start main
%type <int> main

%%

main:
  | stmts T_EOF             { raise Eof }
;

stmts:
  |                         { }
  | stmt T_SEMICOLON stmts    { }

expr:
  | T_INT                   { $1 }
  | T_LPAREN expr T_RPAREN  { $2 }
  | expr T_ADD expr         { $1 + $3 }
  | expr T_SUB expr         { $1 - $3 }
  | expr T_MUL expr         { $1 * $3 }
  | expr T_DIV expr         { $1 / $3 }
  | T_SUB expr %prec T_NEG  { - $2 }
;
