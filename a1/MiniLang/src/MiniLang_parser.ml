
module MenhirBasics = struct
  
  exception Error
  
  type token = 
    | T_WRITEINT
    | T_WHILE
    | T_TRUE of (
# 3 "MiniLang_parser.mly"
       (bool)
# 13 "MiniLang_parser.ml"
  )
    | T_SUB
    | T_STRING of (
# 6 "MiniLang_parser.mly"
       (string)
# 19 "MiniLang_parser.ml"
  )
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
    | T_INT of (
# 4 "MiniLang_parser.mly"
       (int)
# 36 "MiniLang_parser.ml"
  )
    | T_IF
    | T_IDENT of (
# 7 "MiniLang_parser.mly"
       (string)
# 42 "MiniLang_parser.ml"
  )
    | T_GREATEREQ
    | T_GREATER
    | T_FLOAT of (
# 5 "MiniLang_parser.mly"
       (float)
# 49 "MiniLang_parser.ml"
  )
    | T_FALSE of (
# 3 "MiniLang_parser.mly"
       (bool)
# 54 "MiniLang_parser.ml"
  )
    | T_EQUALS
    | T_EOL
    | T_EOF
    | T_ELSE
    | T_DIV
    | T_DEF
    | T_AND
    | T_ADD
  
end

include MenhirBasics

let _eRR =
  MenhirBasics.Error

type _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  _menhir_token: token;
  mutable _menhir_error: bool
}

and _menhir_state

let rec _menhir_discard : _menhir_env -> _menhir_env =
  fun _menhir_env ->
    let lexer = _menhir_env._menhir_lexer in
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and main : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 1 "MiniLang_parser.mly"
       (bool)
# 96 "MiniLang_parser.ml"
) =
  fun lexer lexbuf ->
    let _menhir_env =
      let (lexer : Lexing.lexbuf -> token) = lexer in
      let (lexbuf : Lexing.lexbuf) = lexbuf in
      ((let _tok = Obj.magic () in
      {
        _menhir_lexer = lexer;
        _menhir_lexbuf = lexbuf;
        _menhir_token = _tok;
        _menhir_error = false;
      }) : _menhir_env)
    in
    Obj.magic (let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv17) = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    ((let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | T_WRITEINT ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv13) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | T_INT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv9) = Obj.magic _menhir_stack in
            let (_v : (
# 4 "MiniLang_parser.mly"
       (int)
# 127 "MiniLang_parser.ml"
            )) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv7) = Obj.magic _menhir_stack in
            let ((_2 : (
# 4 "MiniLang_parser.mly"
       (int)
# 134 "MiniLang_parser.ml"
            )) : (
# 4 "MiniLang_parser.mly"
       (int)
# 138 "MiniLang_parser.ml"
            )) = _v in
            ((let _1 = () in
            let _v : (
# 1 "MiniLang_parser.mly"
       (bool)
# 144 "MiniLang_parser.ml"
            ) = 
# 30 "MiniLang_parser.mly"
                     ( true )
# 148 "MiniLang_parser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv5) = _menhir_stack in
            let (_v : (
# 1 "MiniLang_parser.mly"
       (bool)
# 155 "MiniLang_parser.ml"
            )) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv3) = Obj.magic _menhir_stack in
            let (_v : (
# 1 "MiniLang_parser.mly"
       (bool)
# 162 "MiniLang_parser.ml"
            )) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv1) = Obj.magic _menhir_stack in
            let ((_1 : (
# 1 "MiniLang_parser.mly"
       (bool)
# 169 "MiniLang_parser.ml"
            )) : (
# 1 "MiniLang_parser.mly"
       (bool)
# 173 "MiniLang_parser.ml"
            )) = _v in
            (Obj.magic _1 : 'freshtv2)) : 'freshtv4)) : 'freshtv6)) : 'freshtv8)) : 'freshtv10)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv11) = Obj.magic _menhir_stack in
            (raise _eRR : 'freshtv12)) : 'freshtv14)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv15) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv16)) : 'freshtv18))

# 233 "/home/simon/.opam/4.05.0/lib/menhir/standard.mly"
  

# 192 "MiniLang_parser.ml"
