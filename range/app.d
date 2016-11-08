import std.stdio;
/*
   The std.array module to use slices as ranges
   Merely importing the std.array module makes the most common container type conform
   to the most capable range type: slices can seamlessly be used as RandomAccessRange objects.

   [ranges](http://ddili.org/ders/d.en/ranges.html)
 */
import std.array;

void main(string[] args) {
   string[] algs = ["p", "p", "f", "f", "p"];
   assert(algs.length == 5);
   printAll(algs, 5);
   string[] e;
   assert(e.empty);
   printAll(e, 0);

   assert(algs.length == 5);
   writeln();
   printPass(algs);
   assert(algs.length == 5);
   writeln();
   printPass2(algs);
   assert(algs.length == 5);
}

void printAll(string[] algs, int len) {
   writeln("print all len ", len);

   string[] a = algs;
   assert(a.length == len);
   int i = 0;
   for ( ; !a.empty; a.popFront()) {
      writefln("%d %s", i++, a.front);
   }
   assert(a.length == 0);
   assert(algs.length == len);
}

void printPass(string[] algs) {
   assert(algs.length == 5);

   int i = 0;
   for ( ; !algs.empty; algs.popFront()) {
      writefln("%d %s", i++, algs.front);
      if (algs.front == "f") {
         break;
      }
   }
   assert(algs.length == 3);
}

void printPass2(string[] algs) {
   assert(algs.length == 5);

   int i = 0;
   while (!algs.empty) {
      if (algs.front == "f") {
         break;
      }
      writefln("%d %s", i++, algs.front);
      algs.popFront;
   }
   assert(algs.length == 3);
}
