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
   int err = 0;
   assert(aa2["x"] == 7); // funziona
   try {
      int dummy = aa2["xx"]; // genera errore e salta a catch
      assert(false);
   } catch (Error e) {
      ++err;
   }
   assert(err == 1);

   // modo 2
   if (int* ptr = "x" in aa2) {
      assert(*ptr == 7);
   } else {
      assert(false);
   }

   if (auto ptr = "yy" in aa2) {
      assert(false);
   } else {
      ++err;
   }
   assert(err == 2);

   string[string] aa3 = ["a": "10", "b": "11"];
   foreach (k, v; aa3) {
      writeln(k, " == ", v);
   }


   /**
   * Passare AA a funzioni
   *----------------------------------------
   * http://ddili.org/ders/d.en/function_parameters.html
   * Passare AA come parametri di funzione puo' causare sorprese anche perché gli array associativi iniziano la loro vita come null, non come empty.
   * In questo contesto, `null` significa un AA non inizializzato.
   * Gli array associativi vengono inizializzati automaticamente quando si aggiunge la loro prima coppia chiave-valore.
   * Di conseguenza, se una funzione aggiunge un elemento in un array associativo nullo, allora tale elemento *non* può essere visto nella variabile originale
   * perché anche se il parametro è inizializzato, la variabile originale rimane
   * nulla.
   */
   int[string] originale;    // originale e' null, cioe' il suo prt punta a null
   assert(!originale.length);
   appendElement(originale);
   // non e' aggiunto
   assert(!originale.length);

   int[string] nn = ["blue": 10];    // nn non e' null,
   assert(nn.length == 1);
   appendElementNN(nn);
   // e' aggiunto
   assert(nn.length == 2);
}

/**
 * `originale` e' passato come copia, o meglio la struttura che descrive `originale` e' copiata in copia.
 * Se originale.prt e' null anche copia.prt e' null.
 * Aggiungendo un dato a copia e' allocata memoria e copia.ptr punta a tale memoria,
 * ma **non** originale.ptr che punta ancora a null.
 *
 * Se invece originale.ptr non e' null, ma punta ad una area di memoria,
 * copia.ptr punta alla stessa area e quindi aggiungendo a copia, si aggiunge anche ad originale
 */
void appendElement(int[string] copia) {
   assert(!copia.length);
   copia["red"] = 100;
   assert(copia.length);

   writefln("Inside appendElement()       : %s", copia);
}

/*
   Se invece aa.ptr non e' null e punta ad una area di memoria,
   cc.per punta alla stessa area e' quindi aggiungendo a cc si aggiunge all'area condivisa
 */
void appendElementNN(int[string] cc) {
   assert(cc.length);
   cc["red"] = 100;
}
