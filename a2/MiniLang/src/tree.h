#ifndef TREE_H
#define TREE_H

typedef enum {
	k_expressionKindIdentifier,
    k_expressionKindBoolLiteral,
	k_expressionKindIntLiteral,
	k_expressionKindFloatLiteral,
    k_expressionKindStringLiteral,
    k_expressionKindMinus,
    k_expressionKindNot,
    k_expressionKindLParen,
    k_expressionKindRParen,
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
        } ifstmt;
        struct {
            STMTS* statements;
        } elsestmt;
        struct {
            EXPR* predicate;
            STMTS* statements;
        } whilestmt;
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
STMT* genSTMT_if(EXPR* pred, STMTS* stmts);
STMT* genSTMT_else(STMTS* stmts);
STMT* genSTMT_while(EXPR* pred, STMTS* stmts);

STMTS* genSTMTS(STMT* stmt, STMTS* stmts);

#endif /* TREE_H */
