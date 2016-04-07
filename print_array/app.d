//compilare con
//$ dmd app.d

import std.stdio;

void main(string[] args) {
   try {
      writefln("My items are %(%s, %).", [1,2,3]);
      writefln("My items are %(%s%).", [1,2,3]);
      writefln("My items are [%(%d %)]", [10,15,30]);
      writefln("My items Hex [%(%x %)]", [10,15,30]);
      writefln("My items Hex [%(0x%X %)]", [10,15,30]);

   } catch (Exception x) {
      writefln("oops: %s", x.msg);
   }
}
