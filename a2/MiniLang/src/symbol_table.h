#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#include <stdbool.h>

#include "tree.h"

#define HASH_SIZE 317

typedef enum {
    k_symbolKindBool,
	k_symbolKindInt,
	k_symbolKindFloat,
    k_symbolKindString
} SymbolKind;

typedef struct SYMBOL {
    char* name;
    SymbolKind kind;

    union {
        int x;
    } val;
    struct SYMBOL* next;
} SYMBOL;

typedef struct SymbolTable {
    SYMBOL* table[HASH_SIZE];
    struct SymbolTable* parent;
} SymbolTable;

void throw_error(const char* err, const char* arg);

SymbolTable* initSymbolTable(void);
SymbolTable* scopeSymbolTable(SymbolTable* parent);
int hash(char* s);
SYMBOL* putSymbol(SymbolTable* st, char* name, SymbolKind kind);
SYMBOL* getSymbol(SymbolTable* st, char* name);

void unscopeSymbolTable(SymbolTable* st);

#endif /* SYMBOL_TREE_H */
