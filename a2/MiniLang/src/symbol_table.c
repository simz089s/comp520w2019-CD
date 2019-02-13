#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include "symbol_table.h"

void throw_error(const char* err, const char* arg) {
    fprintf(stderr, "Error: %s '%s'\n", err, arg);
    exit(1);
}

SymbolTable* initSymbolTable() {
    SymbolTable* st = malloc(sizeof(SymbolTable));
    for (int i = 0; i < HASH_SIZE; i++) st->table[i] = NULL;
    st->parent = NULL;
    return st;
}

SymbolTable* scopeSymbolTable(SymbolTable* parent) {
    SymbolTable* child = initSymbolTable();
    child->parent = parent;
    return child;
}

int hash(char* s) {
    unsigned int hash = 0;
    while (*s) hash = (hash << 1) + (unsigned int)*(s++);
    return hash % HASH_SIZE;
}

// Should check type along calling this function?
SYMBOL* putSymbol(SymbolTable* st, char* name, SymbolKind kind) {
    int i = hash(name);
    for (SYMBOL* sym = st->table[i]; sym; sym = sym->next) {
        if (strcmp(sym->name, name) == 0) throw_error("variable redefinition", name);
    }
    SYMBOL* sym = malloc(sizeof(SYMBOL));
    sym->name = name;
    sym->kind = kind;
    sym->next = st->table[i];
    st->table[i] = sym;
    return sym;
}

// If return NULL then symbol does not exist
SYMBOL* getSymbol(SymbolTable* st, char* name) {
    int i = hash(name);

    for (SYMBOL* sym = st->table[i]; sym; sym = sym->next) {
        if (strcmp(sym->name, name) == 0) return sym;
    }

    if (st->parent == NULL) return NULL;

    return getSymbol(st->parent, name);
}

