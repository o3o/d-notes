#include<stdio.h>
int somma(int, int);
char* lower(char*);
void split(const char*);
void orf(char*);

int somma(int a, int b) {
   return a + b;
}

/*http://www.programmingspark.com/2012/03/c-program-to-convert-string-to.html*/
void orf(char* str) {
   *str = 0x4f;
   *str = 0x52;
   *str = 0x52;
}

void split(const char* str1) {
   while (*str1 != '\0') {
      printf("|%c",*str1++);
   }
   printf("|\n");
}

char* lower(char* str1) {
   while (*str1 != '\0') {
      if (*str1 < 91 && *str1 > 64) {
         *str1 = *str1 + 32; 
      }
      str1++;
   }
   return str1;
}
