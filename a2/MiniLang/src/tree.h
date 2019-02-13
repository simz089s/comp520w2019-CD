#ifndef TREE_H
#define TREE_H

#include <stdbool.h>

typedef enum {
	k_expressionKindIdentifier,
    k_expressionKindBoolLiteral,
	k_expressionKindIntLiteral,
	k_expressionKindFloatLiteral,
    k_expressionKindStringLiteral,
    k_expressionKindMinus,
    k_expressionKindNot,
	k_expressionKindMultiplication,
	k_expressionKindDivision,
	k_expressionKindAddition,
	k_expressionKindSubtraction,
    k_expressionKindGreaterEqual,
    k_expressionKindLessEqual,
    k_expressionKindGreater,
    k_expressionKindLess,
    k_expressionKindEquals,
    k_expressionKindNotEquals,
    k_expressionKindAnd,
    k_expressionKindOr
} ExpressionKind;

typedef enum {
    boolType,
    intType,
    floatType,
    stringType
} Type;

typedef enum {
    k_statementKindRead,
    k_statementKindPrint,
    k_statementKindDeclaration,
    k_statementKindDeclarationInitialized,
    k_statementKindAssignment,
    k_statementKindIf,
    k_statementKindElse,
    k_statementKindElseIf,
    k_statementKindWhile
} StatementKind;

typedef struct EXPR EXPR;
typedef struct STMT STMT;
typedef struct STMTS STMTS;

struct EXPR {
	int lineno;
	ExpressionKind kind;
	union {
		char* identifier;
        bool boolLiteral;
		int intLiteral;
		float floatLiteral;
        char* stringLiteral;
        EXPR* unaryExpr;
		struct {
            EXPR* lhs;
            EXPR* rhs;
        } binary;
	} val;
    Type type;
};

struct STMT {
	int lineno;
	StatementKind kind;
	union {
		struct {
            char* identifier;
        } read;
		struct {
            EXPR* expression;
        } print;
        struct {
            char* identifier;
            Type type;
            EXPR* expression;
        } declaration;
        struct {
            char* identifier;
            Type type;
            EXPR* expression;
        } declarationInitialized;
        struct {
            char* identifier;
            EXPR* expression;
        } assignment;
        struct {
            EXPR* predicate;
            STMTS* statements;
            STMT* elseStmt;
        } ifStmt;
        struct {
            STMTS* statements;
        } elseStmt;
        struct {
            STMT* ifStatement;
        } elseIfStmt;
        struct {
            EXPR* predicate;
            STMTS* statements;
        } whileStmt;
	} val;
};

struct STMTS {
    STMT* statement;
    STMTS* statements;
};

EXPR* genEXPR_identifier(char* ident);
EXPR* genEXPR_boolLiteral(bool boolLiteral);
EXPR* genEXPR_intLiteral(int intLiteral);
EXPR* genEXPR_floatLiteral(float floatLiteral);
EXPR* genEXPR_stringLiteral(char* stringLiteral);
EXPR* genEXPR_unary(ExpressionKind op, EXPR* expr);
EXPR* genEXPR_binary(ExpressionKind op, EXPR* lhs, EXPR* rhs);

STMT* genSTMT_read(char* ident);
STMT* genSTMT_print(EXPR* expr);
STMT* genSTMT_declaration(char* ident, Type type);
STMT* genSTMT_declarationInitialized(char* ident, Type type, EXPR* expr);
STMT* genSTMT_assignment(char* ident, EXPR* expr);
STMT* genSTMT_if(EXPR* pred, STMTS* stmts, STMT* elseStmt);
STMT* genSTMT_else(STMTS* stmts);
STMT* genSTMT_elseIf(STMT* ifStmt);
STMT* genSTMT_while(EXPR* pred, STMTS* stmts);

STMTS* genSTMTS(STMT* stmt, STMTS* stmts);

#endif /* TREE_H */
