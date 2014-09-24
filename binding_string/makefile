DEFAULT: cac
libfoo.o: libfoo.c
	gcc -c $^

cac: libfoo.o app.d libfoo.d
	dmd app.d libfoo.o -I. -ofcacc
