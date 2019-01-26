exception Codegen_error of string

let gen_read id =
  print_string "read(" ^ id ^ ")"

let gen_print expr =
  print_string (eval expr)

let rec eval expr =
  assert false

let _ =
  try
    let lexbuf = Lexing.from_channel stdin in
    while true do
      let result = Parser.main Lexer.token lexbuf in
        print_int result; print_newline(); flush stdout
    done
  with Lexer.Eof ->
    exit 0
