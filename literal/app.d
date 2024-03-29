import std.stdio;
void main(string[] args) {
   // Learning D M. Parker pag. 38

   // Integer
   //----------------------------------------
   // Senza suffisso -> int
   // U oppure u     -> uint
   // L              -> uint
   // UL             -> ulong

   writeln("10  : ", typeid(10));
   writeln("10U : ", typeid(10U));
   writeln("10u : ", typeid(10u));
   writeln("10L : ", typeid(10L));
   writeln("10UL: ", typeid(10UL));

   // floating
   //----------------------------------------
   // Senza suffisso -> double
   // F oppure f     -> float
   // L              -> real
   writeln("10. : ", typeid(10.));
   writeln("10f : ", typeid(10f));
   writeln("10.L: ", typeid(10.0L));

   Daq[] dd;

   auto d0 = Daq();
   d0.init!0("aa");
   writeln(d0.index);

}

struct Daq {
   private string _t;
   void init(int N)(string t) {
      _index = N;
      _t = t;
   }

   private int _index;
   int index() {
      return _index;
   }
}
