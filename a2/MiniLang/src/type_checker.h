#ifndef TYPE_CHECKER_H
#define TYPE_CHECKER_H

#include "tree.h"
#include "symbol_table.h"

void throw_error(const char* err, const char* arg);

Type typeVar(char* ident);
bool checkBOOL(Type type, int lineno);

void typeImplementationSTMT(STMT* stmt, Type* returnType);
void typeImplementationEXPR(EXPR* expr);

#endif /* TYPE_CHECKER_H */
