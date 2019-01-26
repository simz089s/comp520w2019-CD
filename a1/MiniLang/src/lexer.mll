{
  open Parser
  exception Eof
  exception Error of string
  open Printf

  let num_lines = ref 0
  let num_chars = ref 0
}

let whitespace = [' ' '\t' '\r' '\n']
let digit = ['0'-'9']
let digits = digit+
let alpha = ['a'-'z' 'A'-'Z']
let alphanum = alpha | digit
let ident = (alpha | '_') (alphanum | '_')*
let symbols = ['~' '@' '#' '$' '%' '^' '&' '*' '-' '+' '/' '`' '<' '>' '=' '|' '.' ',' ';' ':' '!' '?' '{' '}' '[' ']' '(' ')' '\'']
let escape = "\\a" | "\\b" | "\\f" | "\\n" | "\\r" | "\\t" | "\\v" | "\\\"" | "\\\\"

rule count = parse
| '\n'  { incr num_lines;
          incr num_chars;
          count lexbuf }
| _     { incr num_chars;
          count lexbuf }
| eof   { () }

and token = parse
  | [' ' '\t']        { token lexbuf }
  | ['\n']            { T_EOL }
  | digits as d       { T_INT (int_of_string d) }
  | '+'               { T_ADD }
  | '-'               { T_SUB }
  | '*'               { T_MUL }
  | '/'               { T_DIV }
  | '('               { T_LPAREN }
  | ')'               { T_RPAREN }
  | eof               { raise Eof }

{
  let main () =
    let lexbuf = Lexing.from_channel stdin in
    count lexbuf;
    Printf.printf "# of lines = %d, # of chars = %d\n" !num_lines !num_chars

  let _ = Printexc.print main ()
}
