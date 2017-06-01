// dmd app.d
import std.variant;
import std.stdio;
import std.conv;

void main(string[] args) {
   //Costruttori
   //----------------------------------------
   // Variant deve essere assegnato prima dell'uso
   Variant a;
   Variant b = 42;
   Variant c = Variant(52);

   assert(*c.peek!int == 52);

   // Ottenere il tipo
   //----------------------------------------
   // typeid ritorna la classe TypeInfo, e qui si verifica che sia uguale al TypeInfo degli interi
   assert(b.type == typeid(int));
   assert(typeid(b) == typeid(Variant));

   // Ottenere il valore con peek
   //----------------------------------------
   // peek ritorna il puntatore alla variabile
   // 42 e' un int quindi si ottiene un puntatore valido
   assert(b.peek!int);
   // 42 non puo' essere convertito in stringa e si ottiene un puntatore null
   assert(!b.peek!string);
   // come sopra con sintassi diversa
   assert(b.peek!string is null);


   // Allowed: valori permessi
   //----------------------------------------
   // allowed indica se il tipo passato puo' essere memorizzato nel variant
   assert(b.allowed!bool);

   // Verificare se inizializzato
   //----------------------------------------
   Variant x;
   assert(!x.hasValue);

   Variant y;
   x = y;
   assert(!x.hasValue); // still no value

   x = 5;
   assert(x.hasValue);

   // Assegnazione fra variant
   //----------------------------------------
   Variant lh = 42;
   assert(lh.hasValue);
   Variant rh = lh;
   // ha quento punto sia rh che lh hanno valore e il valore e' uguale

   assert(rh.hasValue);
   assert(lh.get!int == 42);
   assert(rh.get!int == 42);
   // ma puntano ad aree diverse!
   assert(&rh != &lh);

   // modifico lh
   lh = 43;
   assert(lh.get!int == 43);
   // rh NON cambia perche' e' una copia
   assert(rh.get!int == 42);

   // modifico lh tramite peek
   *(lh.peek!int) = 64;
   assert(lh.get!int == 64);
   // ma lh e rh puntano a interi diversi
   assert(lh.peek!int != rh.peek!int);
   // infatti rh non cambia
   assert(rh.get!int == 42);


   // Conversione
   //----------------------------------------
   // convertsTo!u ritorna true solo se il variant contine un tipo implicitamente convertibile al tipo U
   Variant intero = 42;
   assert(intero.convertsTo!int);
   assert(intero.convertsTo!double);
   assert(!intero.convertsTo!string);
   assert(!intero.convertsTo!bool);

   Variant doppio = 3.14;
   // un double non e' implicitamente convertibile in int
   assert(!doppio.convertsTo!int);
   assert(doppio.convertsTo!double);
   assert(!doppio.convertsTo!string);
   assert(!doppio.convertsTo!bool);

   // e' analogo a
   assert(!doppio.peek!int);
   assert(doppio.peek!double);
   assert(!doppio.peek!string);

   // Ottenere il valore
   //----------------------------------------
   b = 1964;
   assert(b.get!int == 1964);
   assert(b.get!double == 1964.0);

   // double
   //........................................
   a = 3.14;
   // non si puo' convetire implicitamente in int o bool
   //assert(a.get!int == 3);
   //assert(a.get!bool);

   // questo si:
   assert(a.coerce!int == 3);

   // con bool nemmeno la coercizione funziona
   //assert(a.coerce!bool);

   int ex = 0;
   try {
      a.get!int();
   } catch (VariantException e) {
      ++ex;
   } catch (Exception e) {
      // non e' chiamato
      assert(false);
   } finally {
      // questo si
      ++ex;
   }
   assert(ex == 2);

   // long e int
   //........................................
   Variant l = 12L;
   // long NON e' convertibile in int
   assert(!l.convertsTo!int, "long to int");
   // ma si puo' costringere a int
   assert(l.coerce!int == 12);

   Variant i = 10;
   // si possono pero' fare confronti
   assert (i.get!int < l.get!long);

   // Uso con AA
   //----------------------------------------
   Variant[string] buffer;
   buffer["a"] = 42;
   buffer["b"] = true;
   buffer["x"] = 19.64;
   assert(buffer["a"].get!int == 42);
   assert(buffer["x"].get!double == 19.64);
   assert(buffer.get!double("x") == 19.64);
   Variant* va = "x" in buffer;
   assert((*va).get!double == 19.64);


   // Ottenere il tipo
   //----------------------------------------
   Variant t = 19.64;
   // switch non si puo' usare perche'
   //` t.type must be of integral or string type`
   // switch (t.type) {
   //    case typeid(double):
   //       assert(true);
   //       break;
   //    default:
   //       assert(false);
   // }
   if (t.type == typeid(double)) {
      assert(true);
   } else {
      assert(false);
   }

   // Assegnazione ad un tipo semplice
   //----------------------------------------
   // Dato il variant:
   Variant l0 = 42L;
   // l'assegnazione diretta ad un long non si puo fare:
   // long longV = l0; // <- Error: cannot implicitly convert expression (l) of type VariantN!32LU to long
   // cosi si:
   long longV = l0.get!long;
   assert(longV == 42L);

   // Uso in alyx
   //----------------------------------------
   // In alyx pensavo che modificando la copia, si modificasse anche l'originale:
   // in realta' e' ovvio che NON accada perche' i variant sono strutture quindi assegnadole
   // NON si assegna il puntatore come per le classi.
   Parm[string] params;
   params["originale"] = 19.64;

   Parm copia = params["originale"];
   assert(copia.hasValue);

   // i due oggetti sono uguali
   assert(params["originale"] == copia);
   // ma non gli indirizzi
   assert(&params["originale"] != &copia);
   // infatti cambiando valore...
   copia = 52.;
   //... l'oggetto originale NON cambia!
   assert(copia.get!double != params["originale"].get!double);
   // ripristino
   copia = 19.64;
   assert(params["originale"] == copia);

   // Stesso problema usando `in`
   Parm* ptr = "originale" in params;
   assert(typeid(ptr) == typeid(Parm*));

   // ricopia e' una stuttura con gli stessi dati del puntato, ma in area di mem. diversa
   Parm ricopia = *ptr;
   // infatti l'oggetto e' uguale
   assert(params["originale"] == ricopia);
   assert(ricopia == copia);

   // cambiando il valore...
   ricopia = 42.;
   //... l'oggetto originale NON cambia!
   assert(params["originale"].get!double == 19.64);
   assert(ricopia.get!double == 42.);
   assert(params["originale"] != ricopia);

   // se modifico direttamente il puntatore
   *ptr = 2007.;
   // allora il valore originale cambia
   assert(params["originale"].get!double == 2007.);
   // mentre la copia resta invariata
   assert(ricopia.get!double == 42.);

   // i puntatori infatti sono diversi...
   assert(&params["originale"] != &copia);
   assert(&copia != &ricopia);
   writefln("&params   %s", &(params["originale"]));
   writefln("&copia    %s ", &copia);
   writefln("&ricopia  %s", &ricopia);

   // proviamo con peek
   assert(params["originale"].get!double == 2007.);
   double* valueptr = params["originale"].peek!(double);

   // valueptr ora punta al double contenuto in originale
   assert(valueptr !is null);
   // cambiandone il valore...
   *valueptr = 64.;

   // cambia anche l'originale
   assert(params["originale"] == 64.);


   Parm[string] buf0;
   buf0.setX();
   assert(buf0.length == 0);
}

private void setX(Parm[string] b) {
   b["x"] = 19.64;
}

alias Parm = Algebraic!(bool, int, double, string);

private T get(T)(Variant[string] buf, string key) {
   return buf[key].get!T;
}
