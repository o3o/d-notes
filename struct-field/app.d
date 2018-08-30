/**
 * Come elencare i campi di una struttura
 *
 * Riferimenti
 * - A.Ruppe pag. 200
 * - [forum](http://forum.dlang.org/post/qmlahmzcdxukanynomys@forum.dlang.org)
 * - forum.dlang.org/thread/nmbfuzoachoowbjxvdqp@forum.dlang.org
 */
struct Res {
   int a;
   double d;
   string s;
}

import std.stdio;
void main(string[] args) {
   writeln("with traits");

   foreach (m; __traits(allMembers, Res)) {
      writefln("type:%s  name:%s value", typeof(m).stringof, m);
   }

   writeln("with tupleof");
   Res r;
   foreach (m;  r.tupleof) {
      writefln("%s  %s", typeof(m).stringof, m);
   }

   auto s = getMember!Res;
   writefln("%s", s);

   Foo f = new Foo();
   f.x = 12;
   writeln(__traits(getMember, f, "x")); // 12


   writeln("test foo");

   test(f);
}

string[] getMember(T)() {
   string[] met;
   foreach (m; __traits(allMembers, T)) {
      met ~= m;
   }
   return met;
}

class Foo { int x; long y; }
void test(Foo foo) {
    foo.tupleof[0] = 1; // set foo.x to 1
    foo.tupleof[1] = 2; // set foo.y to 2
    foreach (x; foo.tupleof)
        writeln(x);
}
