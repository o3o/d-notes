/*
 * Tratto da M. Parker pag. 57
 */
import std.stdio;
void main(string[] args) {
   /**
    * In un assegnamento fra array se entrambi sono dello stesso tipo
    * si puo aggiungere [] all'array a sinista
    */
   int[] a1 = new int[10]; // alloca 10 iny e li imposta a zero
   int[] a2 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]; // alloca memoria per 1 int e li imposta a 0, 1...

   /*
    * a2 = a1;
    * fa si che a1 e a2 condividano la stessa area di memoria.
    * Aggiungendo [] diciamo al compilatore di eseguire
    * a1[0] = a2[0];
    * a1[1] = a2[1];
    * a1[2] = a2[2];
    * ...
    */
   auto p1 = a1.ptr;
   a1[] = a2;

   /**
    * Anche se sembra equivalente a  .dup, esite una notevole differenza.
    * Chiamare `dup` implica che a1.ptr punta alla memoria allocata da dup, mentre con a1[] il puntatore a1.ptr rimane invariato..
    */
   assert(a1.ptr == p1);

   // il ptr cambia!
   a1 = a2.dup;
   assert(a1.ptr != p1);

   /**
    * pag 59
    * Eguaglianza fara array
    * ----------
    */
   auto ea1 = [1,2,3];
   auto ea2 = [1,2,3];
   /**
    * == e' un confronto elemento per elemento. Siccome ea1 e ea2 hanno lo stesso numero di element e ciascuno ha lo stesso valore
    * e' abbastanza ovvio che:
    */
   assert(ea1 == ea2);
   /**
    * L'operatore is verifica invece la lunghezza e il puntartore dei due array
    * Se i puntatori e la lunchezza dei due array sono uguali allora is ritorna true
    * Siccome puntano ad aree di memoria diverse si ha:
    */
   assert(ea1 !is ea2);

   /**
    * puntatori e lunghezza uguali
    */
   auto ea3 = ea1;
   assert(ea3 is ea1);

   /**
    * `==` confronta i dati degli array mentre `is` confronta i metadati
    */
   int[] n = [];
   /**
    * ritorna true se length e' zero
    */
   assert(n == null);
   assert(n is null);
}
