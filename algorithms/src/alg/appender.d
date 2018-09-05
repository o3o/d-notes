module alg.appender;

import std.range;
import std.algorithm;
import std.stdio;
import std.array;

import unit_threaded;

void ap() {
   Appender!(ubyte[]) result = appender!(ubyte[])();
   ubyte[] buf = [0,1,2,3,4,5,6,7,8,9];
   result.put(buf);
   assert(result.data.length == 10);
   result.shrinkTo(10);
   assert(result.data.length == 10);
   result.shrinkTo(5);
   assert(result.data.length == 5);
   assert(result.data == [0,1,2,3,4]);
}
void ap2() {
   writeln("app2");

   Appender!(ubyte[]) result = appender!(ubyte[])();
   addBuf(result);
   assert(result.data.length == 10);
   assert(result.data == [0,1,2,3,4,5,6,7,8,9]);
}
void addBuf(Appender!(ubyte[]) root) {
   ubyte[] buf = [0,1,2,3,4,5,6,7,8,9];
   root.put(buf);
}


