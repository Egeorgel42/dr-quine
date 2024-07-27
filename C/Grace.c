#include <stdio.h>
#include <fcntl.h>
#define NAME "Grace_kid.c"
#define STR "#include <stdio.h>%c#include <fcntl.h>%c#define NAME %cGrace_kid.c%c%c#define STR %c%s%c%c#define FT(x)int main(){FILE *file = fopen(NAME, x); if (!file) {return 1;} fprintf(file,STR,10,10,34,34,10,34,STR,34,10,10,34,34,10,10,10); fclose(file);}%cFT(%cw%c)%c/*%c	comment%c*/"
#define FT(x)int main(){FILE *file = fopen(NAME, x); if (!file) {return 1;} fprintf(file,STR,10,10,34,34,10,34,STR,34,10,10,34,34,10,10,10); fclose(file);}
FT("w")
/*
	comment
*/