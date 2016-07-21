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
   int[string] bb = ["x": 5, "y": 6];
   setAA(bb);
   assert(bb["x"] == 42);

}

void setAA(int[string] aa) {
   aa["x"] = 42;
}
