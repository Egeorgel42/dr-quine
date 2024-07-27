CC = clang

NAMES = Colleen Grace

all: $(NAMES) Sully

Sully: Sully.c
	mkdir -p Sully
	cd Sully; \
	$(CC) -o Sully ../Sully.c

Colleen: Colleen.c
	$(CC) -o Colleen Colleen.c
Grace: Grace.c
	$(CC) -o Grace Grace.c

clean:
	rm -f Grace_kid.c
	rm -f Sully/*_

fclean: clean
	rm -f $(NAMES)
	rm -fR Sully

re: fclean all

.PHONY: all clean flcean re