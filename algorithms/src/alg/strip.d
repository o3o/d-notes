module alg.strip;

import std.range;
import std.algorithm;
import std.stdio;
import std.array;

import unit_threaded;

void testSripL() {
   writeln( [7, 1, 1, 0, 1, 1].stripLeft(1));
   [7, 1, 1, 0, 1, 1].stripLeft(1).shouldEqual([7, 1, 1, 0, 1, 1]);

   ubyte[] buf = [0,1,2,3,4,5,6,7,8,9];
   ubyte[] s = buf.stripLeft(6);
   writeln(s);
   
   buf.stripLeft(cast(ubyte)6);
   writeln(buf);
   writeln();
}
