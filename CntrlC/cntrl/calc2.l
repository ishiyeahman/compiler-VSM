%{
#include "y.tab.h"
#include "../VSM.h"
%}

ws  [ \t\n]
symbol [.,();]
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
"^"         { yylval.ival = POW; return(MULOP);}
"log"       { yylval.ival = LOG; return(FUNCOP);}
"exp"       { yylval.ival = EXP; return(FUNCOP);}
"sqrt"      { yylval.ival = SQRT;return(FUNCOP); }
"abs"       { yylval.ival = ABS;return(FUNCOP); }
"degree"    { yylval.ival = DEGREE;return(FUNCOP); }
"pi"        { yylval.ival = PI;return(MATHCHAR); }
"e"         { yylval.ival = E;return(MATHCHAR); }
"max"      { yylval.ival = MAX;return(COMPFUNCOP); }
"min"      { yylval.ival = MIN;return(COMPFUNCOP); }


"++"       { yylval.ival = INC; return PPMM; }
"--"       { yylval.ival = DEC; return PPMM; }
"&&"       { return LAND; }
"||"       { return LOR; }
"<"        { yylval.ival = BLT; return RELOP; }
"<="       { yylval.ival = BLE; return RELOP; }
"=="       { yylval.ival = BEQ; return RELOP; }
"!="       { yylval.ival = BNE; return RELOP; }
">="       { yylval.ival = BGE; return RELOP; }
">"        { yylval.ival = BGT; return RELOP; }
"break"    { return BREAK; }
"case"     { return CASE; }
"continue" { return CONTI; }
"default"  { return DEFAULT; }
"do"       { return DO; }
"else"     { return ELSE; }
"for"      { return FOR; }
"if"       { return IF; }
"int"      { return TYPE; }
"read"     { return READ; }
"switch"   { return SWITCH; }
"while"    { return WHILE; }
"write"    { return WRITE; }

{digit}+    { sscanf(yytext, "%d", &yylval.ival); return(INTC);}
{digit}+"."{digit}* { sscanf(yytext, "%lf", &yylval.rval); return(REALC);}

{other}     {fprintf(stderr, "Illegal char '%c' ignored\n", yytext[0]); }

%%