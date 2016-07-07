import std.stdio;
void main(string[] args) {
   // Learning D M. Parker pag. 38

   // Integer
   //----------------------------------------
   // Senza suffisso -> int
   // U oppure u     -> uint
   // L              -> uint
   // UL             -> ulong

   writeln("10: ", typeid(10));
   writeln("10U: ", typeid(10U));
   writeln("10u: ", typeid(10u));
   writeln("10L: ", typeid(10L));
   writeln("10UL: ", typeid(10UL));
   writeln("10f: ", typeid(10f));
   writeln("10.: ", typeid(10.));
}
