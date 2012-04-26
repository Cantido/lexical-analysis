WSPACE		[ \t\v\r]+
NEWLINE           \n

DIGIT	            [0-9]
LETTER            [a-zA-Z]

IDENT			{LETTER}({LETTER}|{DIGIT})* 
INTCONST          {DIGIT}+

%%

"foo"             {
				printTokenInfo("FOO", yytext);
				return T_INTCONST;
			}
{INTCONST}	      {
				printTokenInfo("INTCONST", yytext);
				return T_INTCONST;
			}
{IDENT}		{
				printTokenInfo("IDENT", yytext);
				return T_IDENT;
			}
{NEWLINE}		{
                        numLines++;
                  }
{WSPACE}		{ }
.			{
				printTokenInfo("UNKNOWN", yytext);
				return T_UNKNOWN;
			}

%%

