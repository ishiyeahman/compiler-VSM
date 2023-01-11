bison -y -dv calc2.y;
flex -l calc2.l;
mkdir out;
cp lex.yy.c out/;