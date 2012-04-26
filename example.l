WSPACE              [ \t\r]+
NEWLINE             \n

DIGIT               [0-9]
LETTER              [a-zA-Z]

IDENT               (_|{LETTER})({LETTER}|{DIGIT}|_)*
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