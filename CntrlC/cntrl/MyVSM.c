/* プログラム 7.5 : 関数main() （MainFunc.c，134, 135ページ） */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "../VSM.h"


// int        StartP=0, SymPrintSW=0;                  /* オプション用の */
static int ExecSW=1, ObjOutSW=0, TraceSW=0, StatSW=0;   /* フラグ変数 */
static INSTR Iseg;

int readObject(char fileName[]){
    FILE *fp;

    fp = fopen(fileName, "r");

    while (fscanf(fp, "%d,%d,%d", &Iseg.Op, &Iseg.Reg, &Iseg.Addr) != EOF){
        SetI(Iseg.Op, Iseg.Reg, Iseg.Addr);   
    }

    fclose(fp); 

    return 0;
}


int main(int argc, char *argv[])
{   

    if(argc > 1){
        SetPC(0);
        readObject(argv[1]);            // run  : setI()
        DumpIseg(0, PC() - 1);
        printf("Enter execution phase\n"); 
        if( StartVSM(0, TraceSW) != 0)
            printf("Execution aborted\n");

    }

    return 0;

}
