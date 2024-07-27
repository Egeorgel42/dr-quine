NASM = nasm

LD = ld

NASMFLAGS = -f elf64

NAMES = Colleen Grace

all: $(NAMES) Sully

Sully: Sully.s
	mkdir -p Sully
	$(NASM) $(NASMFLAGS) $<
	cd Sully; \
	$(LD) -o $@ ../Sully.o
	$(clean)

Colleen: Colleen.s
	$(NASM) $(NASMFLAGS) $<
	$(LD) -o $@ Colleen.o

Grace: Grace.s
	$(NASM) $(NASMFLAGS) $<
	$(LD) -o $@ Grace.o

clean:
	rm -f *.o

fclean: clean
	rm -f $(NAMES)
	rm -fR Sully
	rm -f Grace_kid.s

re: fclean all

.PHONY: all clean flcean re