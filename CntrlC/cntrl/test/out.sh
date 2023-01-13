cd ..;
make;
pwd;
gcc MyVSM.c ../VSM.o lex.yy.o y.tab.o -ly -ll -o MyVSM;
cd test;