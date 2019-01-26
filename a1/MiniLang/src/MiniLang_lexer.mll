{
  open Parser
  exception Eof
  exception Error of string
  open Printf

  let num_lines = ref 0
  let num_chars = ref 0
}

let alphanum = ['a'-'z' 'A'-'Z' '0'-'9']
let symbols = ['~' '@' '#' '$' '%' '^' '&' '*' '-' '+' '/' '`' '<' '>' '=' '|' '.' ',' ';' ':' '!' '?' '{' '}' '[' ']' '(' ')' '\'']
let escape = ["\\a" "\\b" "\\f" "\\n" "\\r" "\\t" "\\v" "\\\"" "\\\\"]
let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule count = parse
| '\n'  { incr num_lines;
          incr num_chars;
          count lexbuf }
| _     { incr num_chars;
          count lexbuf }
| eof   { () }

and translate = parse
  | "current_directory" { print_string (Sys.getcwd ());
                          translate lexbuf }
  | _ as c              { print_char c;
                          translate lexbuf }
  | eof                 { exit 0 }

and token = parse
  | [' ' '\t']        { token lexbuf }
  | ['\n' ]           { T_EOL }
  | ['0'-'9']+ as lxm { T_INT(int_of_string lxm) }
  | '+'               { T_PLUS }
  | '-'               { T_MINUS }
  | '*'               { T_TIMES }
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
