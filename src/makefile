TDIR = ../test
AES = $(TDIR)/aes.a

VERILOG = iverilog
VVP = vvp
FLAGS = -g2012

$(mkdir -p $TDIR)

all: aes

aes:
	$(VERILOG) $(FLAGS) aes_tb.v -o $(AES)

clean:
	rm -f $(TDIR)/*.a