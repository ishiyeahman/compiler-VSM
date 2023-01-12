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
}

/* %token <ival> EXP LOG SQRT MAX MIN FACTORIAL PI E ABS DEGREE */
%token  <ival> NUM



/* %token <ival> INTC
%token <rval> REALC */

/* %type  <ival> program expr  expr_list  */
%type  <ival> expr

%right '='
%left <ival> ADDOP
%left <ival> MULOP
%left <ival> FUNCOP
%left <ival> COMPFUNCOP
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
        |   NUM             { Cout(PUSHI, $1); }
        ;
%%
/* 
#include <ctype.h>
#define TraceSW 0

int main(){
    SetPC(0);
    yyparse();
    DumpIseg(0, PC()-1);
    printf("[calc2.y] Enter execution phrase\n");
    if (StartVSM(0, TraceSW) != 0){
        printf("[calc2.y] Execution aborted\n");
    }
}

void yyerror( char *msg){
    printf("%s\n", msg);
}

double degree(double rad){
    return rad*180/M_PI;
} */