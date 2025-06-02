#include <stdio.h>
char*f="#include <stdio.h>%cchar*f=%c%s%c;%cvoid	call(){printf(f,10,34,f,34,10,10,10,10,10,92,110,34,92,10,10,10,10,10);}%cint main(){%c	call();%c/*%c	10 = %c%c, 34 = %c, 92 = %c, 110 = n%c*/%c}%c/*%c	comment%c*/";
void	call(){printf(f,10,34,f,34,10,10,10,10,10,92,110,34,92,10,10,10,10,10);}
int main(){
	call();
/*
	10 = \n, 34 = ", 92 = \, 110 = n
*/
}
/*
	comment
*/