%{
#include "y.tab.h"
#include "../VSM.h"
%}

ws  [ \t\n]
symbol [();]
digit   [0-9]
other .

%%
{ws}+       ;
{symbol}    { return(yytext[0]); }
"+"         { yylval = ADD; return(ADDOP);}
"-"         { yylval = SUB; return(ADDOP);}
"*"         { yylval = MUL; return(MULOP);}
"/"         { yylval = DIV; return(MULOP);}
"%"         { yylval = MOD; return(MULOP);}
"exp"       { yylval = EXP; return(FUNCOP); }
"log"       { yylval = LOG; return(FUNCOP); }
"sqrt"      { yylval = SQRT;return(FUNCOP); }
"max"       { yylval = MAX; return(COMPFUNCOP); }
"min"       { yylval = MIN; return(COMPFUNCOP); }
"!"         { yylval = FACTORIAL; return(FUNCOP); }
"pi"        { yylval = PI; return(NUM);}
"e"         { yylval = E; return(NUM);}
"abs"       {yylval = ABS; return(FUNCOP);}
"degree"        {yylval = DEGREE;  return(FUNCOP);}

{digit}+    { sscanf(yytext, "%d", &yylval); return(NUM);}

{other}     {fprintf(stderr, "Illegal char '%c' ignored\n", yytext[0]); }

%%