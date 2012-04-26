/*
      example.y

 	Example of a yacc specification file.

      Grammar is:

        <expr> -> intconst | ident | foo <identList> <intconstList>
        <identList> -> lambda | <identList> ident
        <intconstList> -> intconst | <intconstList> intconst

      To create the syntax analyzer:

        flex example.l
        bison example.y
        g++ example.tab.c -o parser
        parser < inputFileName
 */

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
%token  T_IDENT T_INTCONST T_UNKNOWN T_FOO

/* Starting point */
%start		N_START

/* Translation rules */
%%
N_START			: N_EXPR
					{
					printRule ("START", "EXPR");
					printf("\n-- Completed parsing --\n\n");
					return 0;
					}
				;
N_EXPR			: T_INTCONST
					{
					printRule("EXPR", "INTCONST");
					}
                        | T_IDENT
                              {
					printRule("EXPR", "IDENT");
					}
                        | T_FOO N_IDENT_LIST N_INTCONST_LIST
                              {
					printRule("EXPR", 
                                      "foo IDENT_LIST INTCONST_LIST");
					}
				;
N_IDENT_LIST       	: /* lambda */
					{
					printRule("IDENT_LIST", "lambda");
					}
                        | N_IDENT_LIST T_IDENT
					{
					printRule("IDENT_LIST", 
                                        "IDENT_LIST IDENT");
					}
				;
N_INTCONST_LIST         : T_INTCONST
					{
					printRule("INTCONST_LIST", "INTCONST");
					}
                        | N_INTCONST_LIST T_INTCONST
					{
					printRule("INTCONST_LIST", 
                                        "INTCONST_LIST INTCONST");
					}
				;
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
  do {
	yyparse();
  } while (!feof(yyin));

  printf("%d lines processed\n", numLines);
  return 0;
}
