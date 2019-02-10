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
