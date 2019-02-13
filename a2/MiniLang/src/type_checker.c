#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "type_checker.h"

void throw_error(const char* err, const char* arg) {
    fprintf(stderr, "Error: %s '%s'\n", err, arg);
    exit(1);
}

Type typeVar(char* ident) {
    getSymbol(st, ident);
}

void typeImplementationSTMT(STMT* stmt, Type* returnType) {
    if (stmt == NULL) return;

    switch (stmt->kind) {
        case k_statementKindRead:
            break;
        case k_statementKindPrint:
            typeImplementationEXPR(stmt->val.print.expression);
            break;
        case k_statementKindDeclaration:
            // Check for redeclaration?
            break;
        case k_statementKindDeclarationInitialized:
            // Type check here?
            typeImplementationEXPR(stmt->val.declarationInitialized.expression);
            break;
        case k_statementKindAssignment:
            {}
            EXPR* expr = stmt->val.assignment.expression;
            expr->type = typeVar(stmt->val.assignment.identifier);
            typeImplementationEXPR(expr);
            if (!assignTYPE(expr->type, expr->type)) {
                char num[11] = "0000000000\0";
                throw_error("illegal assignment", snprintf(num, sizeof(num), "%d", expr->lineno));
            }
            break;
        case k_statementKindIf:
            typeImplementationEXPR(stmt->val.ifStmt.predicate);
            // Make recursive/a statement*S* version?
            typeImplementationSTMT(stmt->val.ifStmt.statements->statement, returnType);
            if (stmt->val.ifStmt.elseStmt != NULL) typeImplementationSTMT(stmt->val.ifStmt.elseStmt, returnType);
            break;
        case k_statementKindElse:
            typeImplementationSTMT(stmt->val.elseStmt.statements->statement, returnType);
            break;
        case k_statementKindElseIf:
            typeImplementationSTMT(stmt->val.elseIfStmt.ifStatement, returnType);
            break;
        case k_statementKindWhile:
            typeImplementationEXPR(stmt->val.ifStmt.predicate);
            typeImplementationSTMT(stmt->val.ifStmt.statements->statement, returnType);
            typeImplementationSTMT(stmt->val.ifStmt.elseStmt, returnType);
            break;
        /*default:*/
    }
}

void typeImplementationEXPR(EXPR* expr) {
    switch (expr->kind) {
        case k_expressionKindIdentifier:
            expr->type = typeVar(expr->val.identifier);
            break;
		case k_expressionKindBoolLiteral:
            expr->type = boolType;
			break;
		case k_expressionKindIntLiteral:
            expr->type = intType;
			break;
		case k_expressionKindFloatLiteral:
            expr->type = floatType;
			break;
		case k_expressionKindStringLiteral:
            expr->type = stringType;
			break;
        case k_expressionKindMinus:
            break;
        case k_expressionKindNot:
            break;
		case k_expressionKindMultiplication:
		case k_expressionKindDivision:
		case k_expressionKindAddition:
		case k_expressionKindSubtraction:
            if ((expr->val.binary.lhs->type == intType && expr->val.binary.rhs->type == intType)
                || (expr->val.binary.lhs->type == floatType && expr->val.binary.rhs->type == floatType)) {
                expr->type = expr->val.binary.lhs->type;
            }
            if ((expr->val.binary.lhs->type == intType && expr->val.binary.rhs->type == floatType)
                || (expr->val.binary.lhs->type == floatType && expr->val.binary.rhs->type == intType)) {
                expr->type = floatType;
            }
            if ((expr->val.binary.lhs->type == stringType && expr->val.binary.rhs->type == stringType)) {
                expr->type = stringType;
            } else {
                char num[11] = "0000000000\0";
                throw_error("invalid operands to binary expression", snprintf(num, sizeof(num), "%d", expr->lineno));
            }
			break;
        case k_expressionKindGreaterEqual:
        case k_expressionKindLessEqual:
        case k_expressionKindGreater:
        case k_expressionKindLess:
        case k_expressionKindEquals:
        case k_expressionKindNotEquals:
			break;
        case k_expressionKindAnd:
        case k_expressionKindOr:
            typeImplementationEXP(expr->val.binary.lhs);
            typeImplementationEXP(expr->val.binary.rhs);
            checkBOOL(expr->val.binary.lhs->type, expr->lineno);
            checkBOOL(expr->val.binary.rhs->type, expr->lineno);
            expr->type = boolType;
            break;
        /*default:*/
    }
}
