module alg.take;

import std.range;
import std.algorithm;
import std.stdio;
import std.array;

import unit_threaded;

void takeTest() {
   ubyte[] buf = [0,1,2,3,4,5,6,7,8,9];
   auto s = take(buf, 3);
   writeln("take 3", s);


   ubyte[] buf1 = [0,1,2];
   ubyte[] s1 = buf1.take(7);
   writeln(s1);
}

void testJoin() {
   import std.conv : to;
   import std.stdio;

   Foo[] foos;
   foreach (i; 0 .. 10) {
      foos ~= Foo(i, "a");
   }

   string list = foos
      .map!(f => f.id.to!string)
      //.map!(to!string)
      .join(",");

   writeln(list);

}

struct Foo {
   long id;
   string name;
}
