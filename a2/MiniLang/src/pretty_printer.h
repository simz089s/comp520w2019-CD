#ifndef PRETTY_PRINTER_H
#define PRETTY_PRINTER_H

#include "tree.h"

void prettyEXPR(EXPR* expr);
void prettyType(Type type);
void prettySTMT(STMT* stmt);
void prettySTMTS(STMTS* stmts);

#endif /* PRETTY_PRINTER_H */
