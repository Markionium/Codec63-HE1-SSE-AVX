CC = gcc
CFLAGS = -O3 -Wall -g
LDFLAGS = -lm

all: c63enc c63dec c63pred

%.o: %.c
	$(CC) $< $(CFLAGS) -c -o $@

#c63enc: c63enc.o dsp.o tables.o io.o c63_write.o c63.h common.o me.o
c63enc: c63enc.o dsp.o tables.o io.o c63_write.o common.o me.o
	$(CC) $^ $(CFLAGS) $(LDFLAGS) -o $@
#c63dec: c63dec.c dsp.o tables.o io.o c63.h common.o me.o
c63dec: c63dec.c dsp.o tables.o io.o common.o me.o
	$(CC) $^ $(CFLAGS) $(LDFLAGS) -o $@
#c63pred: c63dec.c dsp.o tables.o io.o c63.h common.o me.o
c63pred: c63dec.c dsp.o tables.o io.o common.o me.o
	$(CC) $^ -DC63_PRED $(CFLAGS) $(LDFLAGS) -o $@

clean:
	rm -f *.o c63enc c63dec c63pred

foreman-e:
	rm -f test.c63
	./c63enc -w 352 -h 288 -f 100 -o test.c63 foreman.yuv

foreman-d:
	rm -f output.yuv
	./c63dec test.c63 output.yuv
