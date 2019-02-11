#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#include <stdbool.h>

#include "tree.h"

typedef struct Pair Pair;
typedef struct SymbolTable SymbolTable;
typedef struct Cactus Cactus;
typedef struct Cacti Cacti;

struct Pair {
    int identHash;
    Type type;
};

struct SymbolTable {
    Pair elements[256];
};

struct Cactus {
    Cactus* parent;
    SymbolTable* table;
    Cacti* children;
};

struct Cacti {
    Cactus* cacti[256];
};

void scopeSymbolTable(SymbolTable* t);
void unscopeSymbolTable(SymbolTable* t);
char* getSymbol(SymbolTable* t, char* name);
bool putSymbol(SymbolTable* t, char* name, ...);

#endif /* SYMBOL_TREE_H */
