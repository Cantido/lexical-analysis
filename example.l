%{
/* Definitions of constants, variables, & function prototypes go here */

#define T_LET       1
#define T_IF        2
#define T_DEFUN     3
#define T_PLUS      4
#define T_MINUS     5
#define T_MULTIPLY  6
#define T_DIVIDE    7
#define T_LPAREN    8
#define T_RPAREN    9
#define T_INTCONST  10
#define T_IDENT     11
#define T_UNKNOWN   12

//int numLines = 0;

void printTokenInfo(const char* tokenType, char* lexeme);

%}


WSPACE              [ \t\r]+
NEWLINE             \n

DIGIT               [0-9]
LETTER              [a-zA-Z]

IDENT               (_|{LETTER})({LETTER}|{DIGIT}|_)+
INTCONST            ("+"|"-")?{DIGIT}+

%%

"let"       {
                printTokenInfo("LET", yytext);
                return T_LET;
            }
"if"        {
                printTokenInfo("IF", yytext);
                return T_IF;
            }
"defun"     {
                printTokenInfo("DEFUN", yytext);
                return T_DEFUN;
            }
"+"         {
                printTokenInfo("PLUS", yytext);
                return T_PLUS;
            }
"-"         {
                printTokenInfo("MINUS", yytext);
                return T_MINUS;
            }
"*"         {
                printTokenInfo("MULTIPLY", yytext);
                return T_MULTIPLY;
            }
"/"         {
                printTokenInfo("DIVIDE", yytext);
                return T_DIVIDE;
            }
"("         {
                printTokenInfo("LPAREN", yytext);
                return T_LPAREN;
            }
")"         {
                printTokenInfo("RPAREN", yytext);
                return T_RPAREN;
            }
{INTCONST}  {
                printTokenInfo("INTCONST", yytext);
                return T_INTCONST;
            }
{IDENT}     {
                printTokenInfo("IDENT", yytext);
                return T_IDENT;
            }
{NEWLINE}   {
                numLines++;
            }
{WSPACE}    { }
.           {
                printTokenInfo("UNKNOWN", yytext);
                return T_UNKNOWN;
            }

%%


void printTokenInfo(const char* tokenType, char* lexeme)
{
  printf("TOKEN: %s  LEXEME: %s\n", tokenType, lexeme);
}

//int yywrap(void) { return 1; }

/*int main(void)
{
  while(yylex());
  printf("Processed %d lines\n", numLines);
  return 0;
}*/