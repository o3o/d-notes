import std.stdio;
void main(string[] args) {
   foreach (i; 0 .. 5) {
      writeln(i); // stampa 0, 1, ..4
   }
   foreach (e; ["a", "b"]) {
      writeln(e);
   }
}
