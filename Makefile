all: flex bison
	g++ example.tab.c -o parser

flexparse: flex
	g++ lex.yy.c -o flexparse

bison: example.y
	bison example.y

flex: example.l
	flex example.l

clean:
	rm -rf *.o *.exe *.out lex.yy.c example.tab.c