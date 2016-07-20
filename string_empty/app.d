import std.stdio;
import std.array;

void main() {
   // String vuoata
   //----------------------------------------
   string emptyString = "";
   // una  stringa vuota non e' null
   assert(emptyString !is null);
   writeln("empty is null?", emptyString is null); // false

   // ma ha lunghezza zero
   assert(emptyString.length == 0);
   // necessario std.array
   assert(emptyString.empty);

   writeln();
   writeln("==== null =====");
   string nullString = null;
   assert(nullString is null);
   assert(nullString.length == 0);
   assert(nullString.empty);

   writeln("is null?", nullString is null);
   writeln("length == 0?", nullString.length == 0);
   writeln("empty?", nullString.empty);
}
