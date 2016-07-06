// si compila con dmd app.d
import std.stdio;
void main(string[] args) {
   int[] values = [10 , 1, 2, 3];

   /*
    * ptr e' un puntatore a int, cioe' e' un area di memoria che deve contenere l'indirizzo di un int
    * &values[0] e' l'indirizzo del primo elemento dell'array
    */
   int* ptr = &values[0];
   writeln("Valore del puntatore : ", ptr);
   writeln("Valore del puntato: ", *ptr);

   assert(*ptr == 10);

   // un puntatore che ha valore null produce false
   // un puntatore non null produce true
   // ptr non e' nullo, quindi true
   assert(ptr);
   assert(ptr !is null);

   // nptr e' nullo, quindi considerato falso
   int* nptr;
   assert(nptr is null);
   assert(!nptr);

   // nptr e' falso, quindi !nptr e' vero: !nptr e' equivalente a nptr is null
   // !nptr si puo' leggere come "non punta"
   if (!nptr) {
      writeln("puntatore nullo");
   }

   writeln("Pointer value: ", nptr);
}
