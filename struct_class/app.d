import std.stdio;
struct Foo {
   string name;
   int weight;
   int net;
   bool connected;
}
void main(string[] args) {
   // vedi pag. 95 e 102  Parker

   // Literals
   //----------------------------------------
   // i parametri devono essere in ordine
   Foo f0 = Foo("a", 64, 10, true);
   assert(f0.name == "a");
   assert(f0.weight == 64);
   assert(f0.net == 10);
   assert(f0.connected);


   // C#-style: si possono omettere solo i parametri finali
   Foo f1 = Foo("a", 64); // net e connected omessi
   assert(f1.name == "a");
   assert(f1.weight == 64);
   assert(f1.net == 0);
   assert(!f1.connected);

   // C-style: deprecato
   Foo f2 = { "a", 64};
   assert(f2.name == "a");
   assert(f2.weight == 64);
   assert(f2.net == 0);
   assert(!f2.connected);

   // Nominale: i parametri possono essere non in ordine
   Foo f3 = {name: "a", connected: true, net: 12, weight:64};
   assert(f3.name == "a");
   assert(f3.weight == 64);
   assert(f3.net == 12);
   assert(f3.connected);

   auto f4 = getFoo();
}

Foo getFoo() {
   // La riga seguente non funziona
   // return {name: "a", connected: true, net: 12, weight:64};
    // return Foo(name: "a", connected: true, net: 12, weight:64);
   return Foo("a", 64);
}
