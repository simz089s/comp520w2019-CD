#include <stdio.h>

#include "pretty_printer.h"

void prettyEXPR(EXPR* expr)
{
	switch (expr->kind) {
		case k_expressionKindIdentifier:
			printf("%s", expr->val.identifier);
			break;
		case k_expressionKindBoolLiteral:
			printf("%s", expr->val.boolLiteral ? "true" : "false");
			break;
		case k_expressionKindIntLiteral:
			printf("%i", expr->val.intLiteral);
			break;
		case k_expressionKindFloatLiteral:
			printf("%f", expr->val.floatLiteral);
			break;
		case k_expressionKindStringLiteral:
			printf("%s", expr->val.stringLiteral);
			break;
        case k_expressionKindMinus:
            printf("-(");
			prettyEXPR(expr->val.unaryExpr);
			printf(")");
            break;
        case k_expressionKindNot:
            printf("!(");
			prettyEXPR(expr->val.unaryExpr);
			printf(")");
            break;
		case k_expressionKindMultiplication:
			printf("(");
			prettyEXPR(expr->val.binary.lhs);
			printf("*");
			prettyEXPR(expr->val.binary.rhs);
			printf(")");
			break;
		case k_expressionKindDivision:
			printf("(");
			prettyEXPR(expr->val.binary.lhs);
			printf("/");
			prettyEXPR(expr->val.binary.rhs);
			printf(")");
			break;
		case k_expressionKindAddition:
			printf("(");
			prettyEXPR(expr->val.binary.lhs);
			printf("+");
			prettyEXPR(expr->val.binary.rhs);
			printf(")");
			break;
		case k_expressionKindSubtraction:
			printf("(");
			prettyEXPR(expr->val.binary.lhs);
			printf("-");
			prettyEXPR(expr->val.binary.rhs);
			printf(")");
			break;
        case k_expressionKindGreaterEqual:
            printf("(");
			prettyEXPR(expr->val.binary.lhs);
			printf(">=");
			prettyEXPR(expr->val.binary.rhs);
			printf(")");
			break;
        case k_expressionKindLessEqual:
            printf("(");
			prettyEXPR(expr->val.binary.lhs);
			printf("<=");
			prettyEXPR(expr->val.binary.rhs);
			printf(")");
			break;
        case k_expressionKindGreater:
            printf("(");
			prettyEXPR(expr->val.binary.lhs);
			printf(">");
			prettyEXPR(expr->val.binary.rhs);
			printf(")");
			break;
        case k_expressionKindLess:
            printf("(");
			prettyEXPR(expr->val.binary.lhs);
			printf("<");
			prettyEXPR(expr->val.binary.rhs);
			printf(")");
			break;
        case k_expressionKindEquals:
            printf("(");
			prettyEXPR(expr->val.binary.lhs);
			printf("==");
			prettyEXPR(expr->val.binary.rhs);
			printf(")");
			break;
        case k_expressionKindNotEquals:
            printf("(");
			prettyEXPR(expr->val.binary.lhs);
			printf("!=");
			prettyEXPR(expr->val.binary.rhs);
			printf(")");
			break;
        case k_expressionKindAnd:
            printf("(");
			prettyEXPR(expr->val.binary.lhs);
			printf("&&");
			prettyEXPR(expr->val.binary.rhs);
			printf(")");
			break;
        case k_expressionKindOr:
            printf("(");
			prettyEXPR(expr->val.binary.lhs);
			printf("||");
			prettyEXPR(expr->val.binary.rhs);
			printf(")");
			break;
	}
}

void prettyType(Type type)
{
    switch (type) {
        case boolType:
            printf("boolean");
            break;
        case intType:
            printf("int");
            break;
        case floatType:
            printf("float");
            break;
        case stringType:
            printf("string");
            break;
    }
}

void prettySTMT(STMT* stmt)
{
    switch (stmt->kind) {
        case k_statementKindRead:
            printf("print(%s);\n", stmt->val.read.identifier);
            break;
        case k_statementKindPrint:
            printf("print(");
            prettyEXPR(stmt->val.print.expression);
            printf(");\n");
            break;
        case k_statementKindDeclaration:
            printf("var %s: ", stmt->val.declaration.identifier);
            prettyType(stmt->val.declaration.type);
            printf(";\n");
            break;
        case k_statementKindDeclarationInitialized:
            printf("var %s: ", stmt->val.declaration.identifier);
            prettyType(stmt->val.declaration.type);
            printf(" = ");
            prettyEXPR(stmt->val.declarationInitialized.expression);
            printf(";\n");
            break;
        case k_statementKindAssignment:
            printf("%s = ", stmt->val.declaration.identifier);
            prettyEXPR(stmt->val.declarationInitialized.expression);
            printf(";\n");
            break;
        case k_statementKindIf:
            printf("if (");
            prettyEXPR(stmt->val.ifStmt.predicate);
            printf(") {\n");
            prettySTMTS(stmt->val.ifStmt.statements);
            printf("}\n");
            if (stmt->val.ifStmt.elseStmt != NULL) prettySTMT(stmt->val.ifStmt.elseStmt);
            break;
        case k_statementKindElse:
            printf("else {\n");
            prettySTMTS(stmt->val.elseStmt.statements);
            printf("}\n");
            break;
        case k_statementKindElseIf:
            printf("else ");
            prettySTMT(stmt->val.elseIfStmt.ifStatement);
            break;
        case k_statementKindWhile:
            printf("while (");
            prettyEXPR(stmt->val.ifStmt.predicate);
            printf(") {\n");
            prettySTMTS(stmt->val.ifStmt.statements);
            printf("}\n");
            break;
    }
}

void prettySTMTS(STMTS* stmts)
{
    STMTS* current = stmts;
    while (current->statements != NULL) {
        prettySTMT(current->statement);
        current = current->statements;
    }
}
