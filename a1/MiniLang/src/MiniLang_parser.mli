
(* The type of tokens. *)

type token = 
  | T_WRITEINT
  | T_WHILE
  | T_TRUE of (bool)
  | T_SUB
  | T_STRING of (string)
  | T_RPAREN
  | T_RBRACE
  | T_OR
  | T_NOT
  | T_NEQUALS
  | T_NEG
  | T_MUL
  | T_LPAREN
  | T_LESSEQ
  | T_LESS
  | T_LBRACE
  | T_INTTYPE
  | T_INT of (int)
  | T_IF
  | T_IDENT of (string)
  | T_GREATEREQ
  | T_GREATER
  | T_FLOAT of (float)
  | T_FALSE of (bool)
  | T_EQUALS
  | T_EOL
  | T_EOF
  | T_ELSE
  | T_DIV
  | T_DEF
  | T_AND
  | T_ADD

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (bool)
