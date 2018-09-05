module alg.filter;

import std.algorithm.iteration;
import std.stdio;
import unit_threaded;

@UnitTest
void filterArray() {
   string[] arr = ["a", "b", "c", "d"];

   // non si puo fare:
   // FilterResult noA = filter!(a => a != "a")(arr);
   // FilterResul e' privata

   auto noA = filter!(a => a != "a")(arr);
   noA.shouldEqual([ "b", "c", "d"]);


   string b = "b";
   auto noB = filter!(a => a != b)(arr);
   noB.shouldEqual([ "a", "c", "d"]);
   foreach (e; noB) {
      e.shouldNotEqual(b);
   }
}
