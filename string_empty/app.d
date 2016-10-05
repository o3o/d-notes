import std.stdio;
import std.array;

void main() {
   // vedi  http://stackoverflow.com/documentation/d/5760/strings/24157/test-for-an-empty-or-null-string

   // String vuota
   //----------------------------------------
   string emptyString = "";
   // una  stringa vuota non e' null
   assert(emptyString !is null);
   writeln("empty is null?", emptyString is null); // false

   // ma ha lunghezza zero
   assert(emptyString.length == 0);
   // necessario std.array
   assert(emptyString.empty);

   // String nulla
   //----------------------------------------
   string nullString = null;

   // string anulla e' null
   assert(nullString is null);
   // ha lunghezza zero
   assert(nullString.length == 0);
   // ed e' empty
   assert(nullString.empty);
}
