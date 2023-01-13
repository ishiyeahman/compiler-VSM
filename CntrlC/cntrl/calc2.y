%{
#include <stdio.h>
#include <math.h>
#include "../VSM.h"

int yylex(void);
void  yyerror( char *s);
// int yyparse(void);
int getchar(void);
char usingChar[] = {'\n', '+', '-', '*', '/', '%', '(', ')', '0', '1','2','3','4', '5', '6','7','8','9', 'r', '^'};
char END = 'q';
int arraySize =  sizeof(usingChar) / sizeof(char);
int isUsedChar(int);
void exit(int);

double degree(double rad);
%}


%union{
    int ival;
    double rval;
    char *Name;
}

/* %token <ival> EXP LOG SQRT MAX MIN FACTORIAL PI E ABS DEGREE */
/* %token  <rval> NUM */


%token        TYPE IF ELSE WHILE DO FOR
%token        SWITCH CASE DEFAULT BREAK CONTI READ WRITE
%token <ival>  RELOP ADDOP MULOP PPMM NUM
%token <Name> ID

%token <ival> INTC
%token <rval> REALC 

/* %type  <ival> program expr  expr_list  */
%type  <rval> expr 
%type <rval> expr_list
%type <rval> program

%right '='

%right '='
%right '?' ':'
%left  LOR
%left  LAND
%left  RELOP
%left  ADDOP
%left  MULOP
%right '!' PPMM UM
%left  POSOP
%left <ival> ADDOP
%left <ival> MULOP
%left <ival> FUNCOP
%left <ival> COMPFUNCOP
%left <ival> MATHCHAR
%right <ival> UMINUS

%start program

%%
program : expr_list     {Pout(HALT); }
        ;

expr_list   :
            | expr_list   expr ';'  {Pout(OUTPUT); }
            | expr_list   error ';' { yyerrok; }
            ;

expr    :   expr ADDOP expr     { Pout($2); } 
        |   expr MULOP expr     { Pout($2); } 
        |  '(' expr ')'        
        |   FUNCOP'(' expr ')'                  { Pout($1); }
        |   COMPFUNCOP '(' expr ',' expr ')'    { Pout($1); }
        |   '(' expr')'FUNCOP                   { Pout($4); } 
        |   ADDOP expr  %prec UMINUS { if( $1 == SUB) Pout(CSIGN); }
        |   MATHCHAR             {   Pout($1); }
        |   INTC                {  { Cout(PUSHI, (double)$1); } }
        |   REALC               {  { Cout(PUSHI, $1); } }
        ;
%%
