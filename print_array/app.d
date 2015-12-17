//compilare con
//$ dmd app.d

import std.stdio;

void main(string[] args) {
   try {
      writefln("My items are %(%s, %).", [1,2,3]);
      writefln("My items are %(%s%).", [1,2,3]);
      writefln("My items are %(%d %).", [1,2,3]);
   } catch (Exception x) {
      writefln("oops: %s", x.msg);
   }
}
