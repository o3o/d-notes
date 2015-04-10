## In C++
Un puntatore di tipo _void_ e' un puntatore speciale:

    void* ptr

In C++ void rappresenta l'assenza di tipo, quindi i puntatori void puntano
a valori che non hanno tipo (e che quindi hanno lunghezza e "proprieta' di dereferenziare" indeterminate).

Questo permette ai puntatori void di puntare a qualsiasi tipo di dati, da un
intero a una stringa di caratteri. Ma per contro hanno un
grande limite: i dati da essi puntati non possono essere direttamente
dereferenziati (il che è logico, dal momento che non abbiamo nessun tipo a cui
risolvere il riferimento), e per questo motivo dobbiamo sempre convertire
l'indirizzo contenuto nel puntatore a void in qualche altro tipo di puntatore
che punta a un tipo di dati concreti prima di deferenziandolo.

```
// increaser
#include <iostream>
using namespace std;

void increase (void* data, int psize) {
  if (psize == sizeof(char)) { 
     char* pchar; 
     // converte un punt. a void in uno a char
     pchar = (char*)data;
     ++(*pchar);
  } else if (psize == sizeof(int) ) { 
     int* pint; 
     pint=(int*)data;
     ++(*pint); 
  }
}

int main () {
  char a = 'x';
  int b = 1602;
  increase (&a,sizeof(a));
  increase (&b,sizeof(b));
  cout << a << ", " << b << endl;
  return 0;
}
// out y, 1603
```

[Tutorial sui pointer](http://www.cplusplus.com/doc/tutorial/pointers/)

## In D
`void[]` e' un array di bytes simile a `void*` in C++ con la differenza che il
numero di bytes e' noto. Vedi anche la [domanda sul forum](http://forum.dlang.org/thread/uhlqqyruigazvpyprgaz@forum.dlang.org)
