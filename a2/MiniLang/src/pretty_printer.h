#ifndef PRETTY_PRINTER_H
#define PRETTY_PRINTER_H

#include "tree.h"

void prettyEXPR(EXPR* expr);
void prettyType(Type type);
void prettySTMT(STMT* stmt, int indent);
void prettySTMTS(STMTS* stmts, int indent);

#endif /* PRETTY_PRINTER_H */
