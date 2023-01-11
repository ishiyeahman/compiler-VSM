CC = gcc
OBJFILES = lex.yy.o y.tab.o ../VSM.o SymTable.o ../NameTable.o JumpChain.o \
            LabelDef.o ../MainFunc.o

calc2 : ${OBJFILES}
	${CC} ${OBJFILES} -ly -ll -o calc2

../MainFunc.o : ../MainFunc.c ../VSM.h

JumpChain.o : JumpChain.c ../VSM.h

LabelDef.o : LabelDef.c ../VSM.h

SymTable.o : SymTable.c

../NameTable.o : ../NameTable.c

../VSM.o : ../VSM.c ../VSM.h

lex.yy.o: lex.yy.c y.tab.h

lex.yy.c: calc2.l
	flex -l calc2.l

y.tab.o: y.tab.c ../VSM.h

y.tab.c y.tab.h : calc2.y
	bison -dv -y calc2.y


