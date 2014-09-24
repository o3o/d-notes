import std.stdio;
import std.array;

void main() {
   string emptyString = "";
   writeln("==== empty =====");
   assert(emptyString !is null);
   writeln("is null?", emptyString is null); // false

   assert(emptyString.length == 0);
   writeln("length == 0?", emptyString.length == 0);
   // necessario std.array
   assert(emptyString.empty);
   writeln("empty?", emptyString.empty);

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
