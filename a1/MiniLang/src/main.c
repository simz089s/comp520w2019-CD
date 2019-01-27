#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "lex.yy.c"
#include "parser.tab.c"

extern bool tokens_mode;

int main(int argc, char* argv[]) {
    // printf("Mode: %s\n", argv[1]);

    if (strcmp("scan", argv[1]) == 0) {
        while (yylex() != 0);
        printf("OK\n");
    }
    else if (strcmp("tokens", argv[1]) == 0) {
        tokens_mode = 1;
        while (yylex() != 0);
        printf("OK\n");
    }
    else if (strcmp("parse", argv[1]) == 0) {
        if (yyparse() == 0) {
            printf("OK\n");
        }
    }

	return 0;
}
