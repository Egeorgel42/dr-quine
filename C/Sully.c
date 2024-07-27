#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>
#define I 5
#ifdef COMP
 #define X I-1
#else
 #define X I
#endif
#define NAME "Sully_%c.c"
#define NEWNAME "Sully_%c"
#define STR "#include <stdio.h>%c#include <fcntl.h>%c#include <unistd.h>%c#include <sys/wait.h>%c#include <stdlib.h>%c#define I %c%c#ifdef COMP%c #define X I-1%c#else%c #define X I%c#endif%c#define NAME %cSully_%%c.c%c%c#define NEWNAME %cSully_%%c%c%c#define STR %c%s%c%cvoid parent(pid_t pid)%c{%c	pid_t ret = waitpid(pid, NULL, 0);%c	if (ret < 0) {exit(1);}%c}%cvoid	child(char **params)%c{%c	execve(params[0], params, NULL);%c	exit(0);%c}%cvoid process(char **params)%c{%c	pid_t pid = fork();%c	if (pid < 0) {exit(1);}%c	else if (pid == 0) {child(params);}%c	else if (pid > 0) {parent(pid);}%c}%cint main()%c{%c	if (X < 0) {exit(0);}%c	char name[20];%c	sprintf(name, NAME, X+48);%c	char newname[20];%c	sprintf(newname, NEWNAME, X+48);%c	char *clang[] = {%c/bin/clang%c, %c-o%c, newname, %c-DCOMP=1%c, name, NULL};%c	char *exec[] = {newname, NULL};%c	FILE *file = fopen(name, %cw%c);%c	if (!file) {return 1;}%c	fprintf(file,STR,10,10,10,10,10,X+48,10,10,10,10,10,10,34,34,10,34,34,10,34,STR,34,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,34,34,34,34,34,34,10,10,34,34,10,10,10,10,10,10);%c	fclose(file);%c	process(clang);%c	process(exec);%c}"
void parent(pid_t pid)
{
	pid_t ret = waitpid(pid, NULL, 0);
	if (ret < 0) {exit(1);}
}
void	child(char **params)
{
	execve(params[0], params, NULL);
	exit(0);
}
void process(char **params)
{
	pid_t pid = fork();
	if (pid < 0) {exit(1);}
	else if (pid == 0) {child(params);}
	else if (pid > 0) {parent(pid);}
}
int main()
{
	if (X < 0) {exit(0);}
	char name[20];
	sprintf(name, NAME, X+48);
	char newname[20];
	sprintf(newname, NEWNAME, X+48);
	char *clang[] = {"/bin/clang", "-o", newname, "-DCOMP=1", name, NULL};
	char *exec[] = {newname, NULL};
	FILE *file = fopen(name, "w");
	if (!file) {return 1;}
	fprintf(file,STR,10,10,10,10,10,X+48,10,10,10,10,10,10,34,34,10,34,34,10,34,STR,34,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,34,34,34,34,34,34,10,10,34,34,10,10,10,10,10,10);
	fclose(file);
	process(clang);
	process(exec);
}