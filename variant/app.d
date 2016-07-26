// dmd app.d
import std.variant;
import std.stdio;
import std.conv;

void main(string[] args) {
   //Costruttori
   //----------------------------------------
   //Variant deve essere assegnato prima dell'uso
   Variant a;
   Variant b = 42;
   Variant c = Variant(52);

   assert(*c.peek!int == 52);

   // typeid ritorna la classe TypeInfo, e qi si verifica che sia uguale al TypeInfo degli interi
   assert(b.type == typeid(int));
   writeln("b typeid: ", typeid(b));
   writeln("b type: ", b.type);

   // Ottenere il valore con peek
   //----------------------------------------
   // peek ritorna il puntatore alla variabile
   // 42 e' un int quindi si ottien un puntatore valido
   assert(b.peek!int);
   // 42 non puo' essere convertiot in stringa e si ottien un puntaore null
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

   // Conversione
   //----------------------------------------
   // convertsTo!u ritorna true solo se il varian contine un tipo implicitamente convertibile al tipo U
   assert(b.convertsTo!int);
   assert(b.convertsTo!double);
   assert(!b.convertsTo!string);

   a = 3.14;
   // un double non e' implicitamente convertibile in int
   assert(!a.convertsTo!int);
   assert(a.convertsTo!double);
   assert(!a.convertsTo!string);

   // e' analogo a
   assert(!a.peek!int);
   assert(a.peek!double);
   assert(!a.peek!string);


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
   try {
      writeln("try get!int");
      a.get!int();
   } catch (VariantException e) {
      writeln("variant Exception");
   } catch (Exception e) {
      writeln("generic Exception");
   } finally {
      writeln("finally");
   }

   // long e int
   //........................................
   Variant l = 12L;
   // long NON e' convertibile in int
   assert(!l.convertsTo!int, "long to int");
   Variant i = 10;
   // si possono pero fare confronti
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

   // Assegnazione
   //----------------------------------------
   // l'assegnazione diretta non si puo fare
   Variant l0 = 42L;
   // long longV = l0; // <- Error: cannot implicitly convert expression (l) of type VariantN!32LU to long
   // cosi si:
   long longV = l0.get!long;
   assert(longV == 42L);


   // Uso in alyx
   //----------------------------------------
   Parm[string] bufferFoo;
   bufferFoo["foo"] = 19.64;

   Parm foo = bufferFoo["foo"];
   // i due oggetti sono uguali
   assert(bufferFoo["foo"] == foo);
   // cambiando valore...
   foo = 52.;
   //... l'oggetto originale NON cambia!
   assert(foo.get!double != bufferFoo["foo"].get!double);

   foo = Parm(53.);
   assert(foo.get!double != bufferFoo["foo"].get!double);


   // Stesso problema usando `in`
   auto ptr = "foo" in bufferFoo;
   writeln("Typeid ptr: ", typeid(ptr));
   Parm bar = *ptr;
   // l'oggetto e' uguale
   assert(bufferFoo["foo"] == bar);
   // ..ma non e' uguale alla copia
   assert(foo != bar);

   // ma cambiando il valore...
   bar = 42.;
   //... l'oggetto originale NON cambia!
   assert(bufferFoo["foo"].get!double == 19.64);
   assert(bar.get!double == 42.);

   // se modifico direttamente il puntatore
   *ptr = 2007.;
   // allora il valore originale cambia
   assert(bufferFoo["foo"].get!double == 2007.);
   // mentre la copia resta invariata
   assert(bar.get!double == 42.);

   // i puntatotori infatti sono diversi...
   writefln("&bufferFoo %s", &(bufferFoo["foo"]));
   writefln("&foo       %s ", &foo);
   writefln("&bar       %s", &bar);

   // proviamo con peek
   assert(bufferFoo["foo"].get!double == 2007.);
   auto foopeek = bufferFoo["foo"].peek!(double);
   writeln("Typeid foopeek: ", typeid(foopeek));

   assert(foopeek !is null);
   *foopeek = 64.;
   assert(bufferFoo["foo"] == 64.);
}

alias Parm = Algebraic!(bool, int, double, string);

private T get(T)(Variant[string] buf, string key) {
   return buf[key].get!T;
}
