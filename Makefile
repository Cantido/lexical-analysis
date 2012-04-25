all: flex bison
	g++ bisonfile.tab.c -o parser

bison: bisonfile.y
	bison bisonfile.y

flex: flexfile.l
	flex flexfile.l

clean:
	rm -rf *.o *.exe *.out lex.yy.c bisonfile.tab.c