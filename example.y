%{
#include <stdio.h>

int numLines = 0; 

void printRule(const char *lhs, const char *rhs);
int yyerror(const char *s);
void printTokenInfo(const char* tokenType, const char* lexeme);

extern "C" {
    int yyparse(void);
    int yylex(void);
    int yywrap() { return 1; }
}

%}

/* Token declarations */
%token  T_LET T_IF T_DEFUN T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LPAREN T_RPAREN
T_INTCONST T_IDENT T_UNKNOWN

/* Starting point */
%start		N_START

/* Translation rules */
%%
N_START         : N_EXPR
                    {
                        printRule ("START", "EXPR");
                        printf("\n-- Completed parsing --\n\n");
                        return 0;
                    };

N_EXPR		    : T_INTCONST
                    {
                        printRule("EXPR", "INTCONST");
                    }
                | T_IDENT
                    {
                        printRule("EXPR", "IDENT");
                    }
                | T_LPAREN N_PAREN_EXPR T_RPAREN
                    {
                        printRule("EXPR", "( PAREN_EXPR )");
                    };
N_PAREN_EXPR    : N_ARITH_EXPR
                    {
                        printRule("PAREN_EXPR", "ARITH_EXPR");
                    }
                | N_IF_EXPR
                    {
                        printRule("PAREN_EXPR", "IF_EXPR");
                    }
                | N_LET_EXPR
                    {
                        printRule("PAREN_EXPR", "LET_EXPR");
                    }
                | N_DEFUN_EXPR
                    {
                        printRule("PAREN_EXPR", "DEFUN_EXPR");
                    }
                | N_EXPR_LIST
                    {
                        printRule("PAREN_EXPR", "EXPR_LIST");
                    };
N_ARITH_EXPR    : N_OP N_EXPR N_EXPR
                    {
                        printRule("ARITH_EXPR", "OP EXPR EXPR");
                    };
N_IF_EXPR       : T_IF N_EXPR N_EXPR N_EXPR
                    {
                        printRule("IF_EXPR", "if EXPR EXPR EXPR");
                    };
N_LET_EXPR      : T_LET T_LPAREN N_ID_EXPR_LIST T_RPAREN N_EXPR
                    {
                        printRule("LET_EXPR", "let ( ID_EXPR_LIST ) EXPR");
                    };
N_ID_EXPR_LIST  : /* lambda */
                    {
                        printRule("ID_EXPR_LIST", "lambda");
                    }
                | N_ID_EXPR_LIST T_LPAREN T_IDENT N_EXPR T_RPAREN
                    {
                        printRule("ID_EXPR_LIST", "ID_EXPR_LIST ( ident EXPR )");
                    };
N_DEFUN_EXPR    : T_DEFUN T_LPAREN N_ID_LIST T_RPAREN N_EXPR
                    {
                        printRule("DEFUN_EXPR", "defun ( ID_LIST ) EXPR");
                    };
N_ID_LIST       : /* lambda */
                    {
                        printRule("ID_LIST", "lambda");
                    }
                | N_ID_LIST T_IDENT
                    {
                        printRule("ID_LIST", "ID_LIST ident");
                    };
N_EXPR_LIST     : N_EXPR N_EXPR_LIST
                    {
                        printRule("EXPR_LIST", "EXPR EXPR_LIST");
                    }
                | N_EXPR
                    {
                        printRule("EXPR_LIST", "EXPR");
                    };
N_OP            : T_PLUS
                    {
                        printRule("N_OP", "+");
                    }
                | T_MINUS
                    {
                        printRule("N_OP", "-");
                    }
                | T_MULTIPLY
                    {
                        printRule("N_OP", "*");
                    }
                | T_DIVIDE
                    {
                        printRule("N_OP", "/");
                    };
                
%%

#include "lex.yy.c"
extern FILE	*yyin;

void printRule(const char *lhs, const char *rhs) {
  printf("%s -> %s\n", lhs, rhs);
  return;
}

int yyerror(const char *s) {
  printf("%s\n", s);
  return(1);
}

void printTokenInfo(const char* tokenType, const char* lexeme) {
  printf("TOKEN: %s  LEXEME: %s\n", tokenType, lexeme);
}

int main() {
  do
  {
	yyparse();
  } while (!feof(yyin));

  printf("%d lines processed\n", numLines);
  return 0;
}
