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
"+"         { yylval.ival = ADD; return(ADDOP);}
"-"         { yylval.ival = SUB; return(ADDOP);}
"*"         { yylval.ival = MUL; return(MULOP);}
"/"         { yylval.ival = DIV; return(MULOP);}
"%"         { yylval.ival = MOD; return(MULOP);}
"exp"       { yylval.ival = EXP; return(FUNCOP); }
"log"       { yylval.ival = LOG; return(FUNCOP); }
"sqrt"      { yylval.ival = SQRT;return(FUNCOP); }
"max"       { yylval.ival = MAX; return(COMPFUNCOP); }
"min"       { yylval.ival = MIN; return(COMPFUNCOP); }
"!"         { yylval.ival = FACTORIAL; return(FUNCOP); }
"pi"        { yylval.ival = PI; return(NUM);}
"e"         { yylval.ival = E; return(NUM);}
"abs"       {yylval.ival = ABS; return(FUNCOP);}
"degree"        {yylval.ival = DEGREE;  return(FUNCOP);}

{digit}+    { sscanf(yytext, "%d", &yylval.ival); return(NUM);}

{other}     {fprintf(stderr, "Illegal char '%c' ignored\n", yytext[0]); }

%%