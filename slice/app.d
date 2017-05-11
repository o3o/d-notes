#!/usr/bin/env dub
/+ dub.json:
{
	"name": "app"
}
+/

/+
M. Parker pag. 48
Un array puo' essere pensato come una struttura
struct(T) {
   size_t length;
   T* ptr;
}
+/

// dub  --single app.d
// dmd run app.d
import std.stdio;
void main(string[] args) {
   // Array statici
   //----------------------------------------
   // M. Parker pag. 49
   int[3] stat1;
   assert(stat1.length == 3);
   writeln(stat1);
   //stat1 ~= 1; non si puo'

   // Array dinamici
   //----------------------------------------
   // M. Parker pag. 49

   int[] dynArray1;
   // a differenza degli array statici dynArray1 e' empty, infatti:
   assert(dynArray1.length == 0);

   // Inizializzazione
   // ---------
   int[] arr = new int[0];
   int[] alternativeArr = new int[](0);
   /*
    * Pag 49
    * Some D users think the syntax auto arr = new int[3] is too
    * similar to the static array declaration auto arr = int[3]. D now
    * supports an alternative syntax, new int[](3). This new syntax is
    * recommended, but old habits die hard. There is a large body of D code
    * that uses the older syntax.
    */
   int[] dynArray2 = new int[](10);
   assert(dynArray2.length == 10);
   writeln("new int[](10) cap: ", dynArray2.capacity);

   dynArray2 ~= 2;
   assert(dynArray2.length == 11);

   int[] dynArray3;
   dynArray3.reserve(20);
   writefln("%s, %s", dynArray3.length, dynArray3.capacity);

   // Slices
   //----------------------------------------
   // M. Parker pag. 53
   // Gli array dinamici sono slices e le slices sono array dinamici
   auto tenArray = [5,10,15,20,25,30,35,40,45,50];
   auto sliced = tenArray[0 .. 5];

   // Quando una slice inizia a vivere, non e' allocata nessuna memoria,..
   assert(sliced.capacity == 0);
   // il pointer della slice e' quello dell'array
   assert(sliced.ptr == tenArray.ptr);

   // M. Parker pag 54:
   // Supponiamo pero' di aggiungere un elemento a sliced: siccome la capacita' iniziale e' 0, aggiungendo elementi
   // si rischia di sovrascrivere altri elementi esistenti in memoria, cioè quelli appartenenti all'array originale.
   // Al fine di evitare qualsiasi potenziale sovrascrittura, l'accodare interrompera' il collegamento tra i due array.
   // Si alloca quindi un nuovo blocco di memoria (abbastanza grande da contenere gli elementi esistenti più un quello aggiunto),
   // e si copiano tutti gli elementi di `tenArray`.
   // La proprieta' .prt dello slice sara' impostata all'indirizzo del nuovo blocco di memoria e `capacity` avra un valore non nullo
   // Infatti:
   sliced ~= 20;
   assert(sliced.ptr != tenArray.ptr);
   assert(sliced.capacity > 0);
   writeln(sliced.ptr, " ", tenArray.ptr);


   // Passaggio di array a funzioni
   //----------------------------------------
   // M.Parker pag 79
   // Un array e' concettualmente una struttura con lunghezza e un puntatore (struttura come sopra).
   // Mentre una slice può condividere la memoria con il suo array di origine (tenArray), la sua lunghezza e puntatore sono completamente indipendenti.
   // Come tale, una slice e' passato per valore a una funzione.
   // Nella funzione ogni modificazione alla lunghezza o al puntatore della slice passata modificano i metadata della slice non dell'array
   //
   // +-----+
   // |     |<-------+---------| tenArray |
   // +-----+        |
   // |     |        +---------| slice    |
   // +-----+

   append(tenArray, 52);
   // il dato non e' aggiunto all'array
   assert(tenArray.length == 10);

   assert(tenArray[0] == 5);
   update(tenArray, 100);
   assert(tenArray[0] == 100);
   /**
    * pag 234
    * Ogni modifica degli elementi esistenti di un array passato come parametro ad una  funzione, si riflette nell'array di origine,
    * ad eccezione di quelli realizzati sulle proprietà length o ptr.
    * `append` modifica la lunghezza, quindi non ha effetto nell'array originale
    * `update` modifica il valore (non la lunghezza ne il ptr) e quindi ha effetto sull' array originale
    */


   // Creazione
   //----------------------------------------
   // Gli slice sono definiti tramite `numeric range`  che corrispondono agli indici che specificano l'inizio e la fine dell'intervallo
   int[] src = [0, 1, 2, 3, 4];

   assert(src[$ - 1] == 4); // ultimo elemento
   int[] s0 = src[1 .. 3]; // 1 e 2 inclusi, ma non 3 => [1, 2]

   assert(s0.length == 2);
   assert(s0[0] == 1);
   assert(s0[1] == 2);

   int[] s1 = src[0 .. $];
   assert(s1.length == 5);

   // $ in questo caso vale 5, quindi $ - 1 = 4, includo gli indici 0, 1, 2, 3
   int[] s2 = src[0 .. $ - 1];
   assert(s2.length == 4);

   // chiedendo uno slice con piu' elementi del sorgente si genera un errore
   //int[] s3 = src[0 .. 20]; <- error

   assert(takeFirst(src, 20).length == 5);
   assert(takeFirst(src, 2).length == 2);
   assert(takeFirst(src, 0).length == 5);

   // Uso di take
   //----------------------------------------
   import std.range : take;
   import std.algorithm : equal;

   int[] t = take(src, 20);
   assert(t.length == 5);
   t = src.take(2);
   assert(t.length == 2);
   assert(equal(t, [ 0, 1]));
   t = take(src, 0);
   assert(t.length == 0);
}

/*
 * arr e' una copia di tenArray, aggiungere un dato modifica la lunghezza della copia
 * ma non dell'originale
 */
void append(int[] arr, int val) {
   writeln("Inside append: ", arr.ptr);
   arr ~= val;
   assert(arr.length == 11);
   writeln("after append: ", arr.ptr);
}

/**
  * Anche in questo caso arr e' una copia di tenArray, (cioe' della struttura sopra)
  * e quindi prt punta alla stessa area di memoria.
  * Modificando la memoria condivisa si modifica anche tenArray
 */
void update(int[] arr, int val) {
   arr[0] = val;
}

int[] takeFirst(int[] src, int num) {
   if (num < src.length && num > 0) {
      return src[0 .. num];
   } else {
      return src[0 .. $];
   }
}
