#include <stdio.h>

void yyparse();

int main() {
	yyparse();

	int result = 0;
	printf("%d\n", result);

	return 0;
}
