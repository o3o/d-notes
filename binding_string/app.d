import std.conv;
import std.stdio;
import std.string;
import libfoo;

void main() {
   //writeln("100 + 20", somma(100, 20));
   //assert(somma(100 + 20) == 120);

   // convertire stringa in  char*
   immutable(char)* z = "aBcD".toStringz();
   //char[] str = z.dup;
   char* a = z.dup;
   char* lowC = lower(a);
   // char* in stringa
   string low = to!string(lowC);
   writeln(low);
   

   char[] o = [0x4f, 0x53, 0x47, 0x0];
   orf(o.ptr);
   auto s = to!string(o);
   writeln(typeid(o).toString);
   writeln(s);

   // convertire stringa in const char*
   const(char)* orfeo = "Orfeo".toStringz();
   split(OrF);
}
