TDIR = ../test
AES = $(TDIR)/aes.a
AES_FULL = $(TDIR)/aes-full.a

VERILOG = iverilog
VVP = vvp
FLAGS = -g2012

$(mkdir -p $TDIR)

all: aes aesfull

aes:
	$(VERILOG) $(FLAGS) aes_tb.v -o $(AES)

aesfull:
	$(VERILOG) $(FLAGS) aes_full_tb.v -o $(AES_FULL)

clean:
	rm -f $(TDIR)/*.a