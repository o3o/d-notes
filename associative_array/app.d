// dmd app.d -unittest -of aa

// Learning D pag 64

import std.stdio;
import std.exception;
void main() {
   // Literals
   // --------------
   auto aa1 = ["x": 5.0, "y": 6.0];
   int[string] aa2 = ["x": 5, "y": 6];  //int value, string key

   // Aggiungere
   // --------------

   // se esiste e' sovrascritto...
   aa2["x"] = 7;
   // .. se no aggiunto
   aa2["z"] = 8;

   assert(aa2["x"] == 7);
   assert(aa2["z"] == 8);


   // Rimuovere
   // --------------
   // se esiste e' rimosso e ritorna true
   assert(aa1.remove("x"));
   //.. altrimenti non fa nulla e ritorna false
   assert(!aa1.remove("z"));


   // Leggere
   // --------------
   // modo 1
   writeln(aa2["x"]); // funziona
   try {
      writeln(aa2["xx"]); // genera errore
   } catch (Error e) {
      writeln("errore xx");
   }

   // modo 2
   if (int* ptr = "x" in aa2) {
      writeln(*ptr);
   }

   if (auto ptr = "yy" in aa2) {
      writeln(*ptr);
   } else {
      writeln("errore yy");
   }

   string[string] aa3 = ["a": "10", "b": "11"];
   foreach (k, v; aa3) {
      writeln(k, " == ", v);
   }


   // Passare AA a funzioni
   //----------------------------------------
   //http://ddili.org/ders/d.en/function_parameters.html
   // Passare AA come parametri di funzione puo' causare sorprese anche perché gli array associativi iniziano la loro vita come null, non come empty.
   // In questo contesto, `null` significa un array associativo non inizializzato.
   // Gli array associativi vengono inizializzati automaticamente quando si aggiunge la loro prima coppia chiave-valore.
   // Di conseguenza, se una funzione aggiunge un elemento in un array associativo nullo, allora tale elemento non può essere visto nella variabile originale
   // perché anche se il parametro è inizializzato, la variabile originale rimane
   // nulla.
   int[string] aa;    // aa e' null, cioe' il suo prt punta a null
   assert(!aa.length);
   appendElement(aa);
   assert(!aa.length);

   int[string] nn = ["blue": 10];    // nn non e' null,
   assert(nn.length == 1);
   appendElementNN(nn);
   assert(nn.length == 2);
}

/**
  aa e' passato come copia, o meglio la struttura che descrive aa e' copiata in cc
  Se aa.prt e' null anche cc.prt e' null.
  Aggiungendo un dato a cc e' allocata memoria e cc.ptr punta a tale memoria,
  ma **non** aa.pter che punta ancora  null.

  Se invece aa.ptr non e' null, ma punta ad una area di memoria, cc.per punta alla stessa area e' quindi aggiungendo

*/
void appendElement(int[string] cc) {
   assert(!cc.length);
   cc["red"] = 100;
   assert(cc.length);

   writefln("Inside appendElement()       : %s", cc);
}

/*
  Se invece aa.ptr non e' null e punta ad una area di memoria,
  cc.per punta alla stessa area e' quindi aggiungendo a cc si aggiunge all'area condivisa dd
*/
void appendElementNN(int[string] cc) {
   assert(cc.length);
   cc["red"] = 100;
}
