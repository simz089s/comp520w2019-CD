%{ /* C declarations */ %}

/* Bison declarations; tokens come from lexer (scanner) */
%token tIDENTIFIER tINTVAL

/*Grammar rules after the first %%*/
%start exp
%%
exp : tIDENTIFIER
    | tINTVAL
    | exp '*' exp
    | exp '/' exp
    | exp '+' exp
    | exp '-' exp
    | '(' exp ')'
;
%% /* User C code after the second %% */
