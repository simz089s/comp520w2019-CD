#include <stdlib.h>
#include <stdbool.h>

#include "tree.h"

extern int yylineno;

// Expressions

EXPR* genEXPR_identifier(char* ident)
{
	EXPR* e = malloc(sizeof(EXPR));
	e->lineno = yylineno;
	e->kind = k_expressionKindIdentifier;
	e->val.identifier = ident;
	return e;
}

EXPR* genEXPR_boolLiteral(bool boolLiteral)
{
    EXPR* e = malloc(sizeof(EXPR));
    e->lineno = yylineno;
    e->kind = k_expressionKindBoolLiteral;
    e->val.boolLiteral = boolLiteral;
    return e;
}

EXPR* genEXPR_intLiteral(int intLiteral)
{
	EXPR* e = malloc(sizeof(EXPR));
	e->lineno = yylineno;
	e->kind = k_expressionKindIntLiteral;
	e->val.intLiteral = intLiteral;
	return e;
}

EXPR* genEXPR_floatLiteral(float floatLiteral)
{
    EXPR* e = malloc(sizeof(EXPR));
    e->lineno = yylineno;
    e->kind = k_expressionKindFloatLiteral;
    e->val.floatLiteral = floatLiteral;
    return e;
}

EXPR* genEXPR_stringLiteral(char* stringLiteral)
{
    EXPR* e = malloc(sizeof(EXPR));
    e->lineno = yylineno;
    e->kind = k_expressionKindBoolLiteral;
    e->val.stringLiteral = stringLiteral;
    return e;
}

EXPR* genEXPR_unary(ExpressionKind op, EXPR* expr)
{
    EXPR* e = malloc(sizeof(EXPR));
    e->lineno = yylineno;
	e->kind = op;
	e->val.unaryExpr = expr;
	return e;
}

EXPR* genEXPR_binary(ExpressionKind op, EXPR* lhs, EXPR* rhs)
{
	EXPR* e = malloc(sizeof(EXPR));
	e->lineno = yylineno;
	e->kind = op;
	e->val.binary.lhs = lhs;
	e->val.binary.rhs = rhs;
	return e;
}

// Statements

STMT* genSTMT_read(char* ident)
{
	STMT* s = malloc(sizeof(STMT));
	s->lineno = yylineno;
	s->kind = k_statementKindRead;
	s->val.read.identifier = ident;
	return s;
}

STMT* genSTMT_print(EXPR* expr)
{
	STMT* s = malloc(sizeof(STMT));
	s->lineno = yylineno;
	s->kind = k_statementKindPrint;
	s->val.print.expression = expr;
	return s;
}

STMT* genSTMT_declaration(char* ident, Type type)
{
	STMT* s = malloc(sizeof(STMT));
	s->lineno = yylineno;
	s->kind = k_statementKindDeclaration;
	s->val.declaration.identifier = ident;
	s->val.declaration.type = type;
	return s;
}

STMT* genSTMT_declarationInitialized(char* ident, Type type, EXPR* expr)
{
	STMT* s = malloc(sizeof(STMT));
	s->lineno = yylineno;
	s->kind = k_statementKindDeclarationInitialized;
	s->val.declarationInitialized.identifier = ident;
	s->val.declarationInitialized.type = type;
	s->val.declarationInitialized.expression = expr;
	return s;
}

STMT* genSTMT_assignment(char* ident, EXPR* expr)
{
	STMT* s = malloc(sizeof(STMT));
	s->lineno = yylineno;
	s->kind = k_statementKindAssignment;
	s->val.assignment.identifier = ident;
	s->val.assignment.expression = expr;
	return s;
}

STMT* genSTMT_if(EXPR* pred, STMTS* stmts, STMT* elseStmt)
{
	STMT* s = malloc(sizeof(STMT));
	s->lineno = yylineno;
	s->kind = k_statementKindIf;
	s->val.ifStmt.predicate = pred;
	s->val.ifStmt.statements = stmts;
	s->val.ifStmt.elseStmt = elseStmt;
	return s;
}

STMT* genSTMT_else(STMTS* stmts)
{
	STMT* s = malloc(sizeof(STMT));
	s->lineno = yylineno;
	s->kind = k_statementKindElse;
	s->val.elseStmt.statements = stmts;
	return s;
}

STMT* genSTMT_elseIf(STMT* ifStmt)
{
	STMT* s = malloc(sizeof(STMT));
	s->lineno = yylineno;
	s->kind = k_statementKindElseIf;
	s->val.elseIfStmt.ifStatement = ifStmt;
	return s;
}

STMT* genSTMT_while(EXPR* pred, STMTS* stmts)
{
	STMT* s = malloc(sizeof(STMT));
	s->lineno = yylineno;
	s->kind = k_statementKindWhile;
	s->val.whileStmt.predicate = pred;
	s->val.whileStmt.statements = stmts;
	return s;
}

STMTS* genSTMTS(STMT* stmt, STMTS* stmts)
{
	STMTS* ss = malloc(sizeof(STMTS));
	ss->statement = stmt;
	ss->statements = stmts;
	return ss;
}
