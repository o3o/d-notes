import std.stdio;

void main() {
   version (x) {
      writeln("version x");
   }
   debug {
      writeln("version debug");
   }

	writeln("all version");
}
