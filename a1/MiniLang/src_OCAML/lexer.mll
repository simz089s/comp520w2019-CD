{
  open Parser
  exception Eof
  exception Error of string
  exception Syntax_error of string

  let syntax_error msg = raise (Syntax_error (msg ^ " on line " ^ (string_of_int !line_num)))

  open Parsing

  let line_num = ref 1

  let keywords = [
    "var", T_VAR;
    "float", T_FLOAT;
    "int", T_INT;
    "string", T_STRING;
    "boolean", T_BOOL;
    "if", T_IF;
    "else", T_ELSE;
    "while", T_WHILE;
    "read", T_READ;
    "print", T_PRINT;
    "true", T_TRUE;
    "false", T_FALSE
  ]
}

let whitespace = [' ' '\t' '\r']
let digit = ['0'-'9']
let digits = digit+
let alpha = ['a'-'z' 'A'-'Z']
let alphanum = alpha | digit
let ident = (alpha | '_') (alphanum | '_')*
let symbols = ['~' '@' '#' '$' '%' '^' '&' '*' '-' '+' '/' '`' '<' '>' '=' '|' '.' ',' ';' ':' '!' '?' '{' '}' '[' ']' '(' ')' '\'']
let escape = "\\a" | "\\b" | "\\f" | "\\n" | "\\r" | "\\t" | "\\v" | "\\\"" | "\\\\"

rule token = parse
  | ['\n']            { incr line_num; T_EOL }
  | whitespace        { token lexbuf }
  | digits as d       { T_INT (int_of_string d) }
  | '='               { T_ASSIGN }
  | '+'               { T_ADD }
  | '-'               { T_SUB }
  | '*'               { T_MUL }
  | '/'               { T_DIV }
  | '('               { T_LPAREN }
  | ')'               { T_RPAREN }
  | ident as id {
      let l = String.lowercase id in
      try List.assoc l keywords
      with Not_found -> T_IDENT id
    }
  | _                 { syntax_error ("Invalid character on line " ^ (string_of_int !line_num)) }
  | eof               { T_EOF }

{
  let main () =
    let lexbuf = Lexing.from_channel stdin in
    token lexbuf;
    Printf.printf "Number of lines = %d\n" !line_num

  let _ = Printexc.print main ()
}
