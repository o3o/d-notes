module alg.filter;

import std.algorithm.iteration;
import std.range.primitives: ElementType, isInputRange;
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
@UnitTest
void filterHash() {
   string[] list = ["a", "b", "c", "d"];

   bool[string] buf = ["a": false, "b": true, "c":false, "d" : false];

   auto onlyT = list.filter!(a => buf[a]).front;

   onlyT.shouldEqual("b");
   //auto noB = filter!(a => a != b)(arr);
}

@UnitTest
void radio() {
   string[] list = ["a", "b", "c", "d"];

   bool[string] buf = ["a": false, "b": true, "c":true, "d" : false];

   // trova tutte le variabili true
   auto onlyT = list.filter!(a => buf[a]);
   if (!onlyT.empty) {
      string on = onlyT.front;
      on.shouldEqual("b");
      list.filter!(a => a != on).each!(a => buf[a] = false);
   }

   buf["b"].shouldBeTrue;
   buf["c"].shouldBeFalse;
   buf["d"].shouldBeFalse;
}

@UnitTest
void radio2() {
   string[] list = ["a", "b", "c", "d"];

   bool[string] buf = ["a": false, "b": true, "c":true, "d" : false];

   string primo = list.filter!(a => buf[a]).firstOrDefault();
   primo.shouldEqual("b");
   list.filter!(a => a != primo).each!(a => buf[a] = false);

   buf["a"].shouldBeFalse;
   buf["b"].shouldBeTrue;
   buf["c"].shouldBeFalse;
   buf["d"].shouldBeFalse;
}
@UnitTest
void radio3() {
   string[] list = ["a", "b", "c", "d"];

   bool[string] buf = ["a": false, "b": false, "c":false, "d" : false];

   string primo = list.filter!(a => buf[a]).firstOrDefault();
   primo.shouldEqual("");
   list.filter!(a => a != primo).each!(a => buf[a] = false);

   buf["a"].shouldBeFalse;
   buf["b"].shouldBeFalse;
   buf["c"].shouldBeFalse;
   buf["d"].shouldBeFalse;
}

//https://forum.dlang.org/thread/fkufaspwlgucuhmebwzy@forum.dlang.org
//
//ElementType e' descritto qui https://dlang.org/phobos/std_range_primitives.html#ElementType
ElementType!R firstOrDefault(R)(R r, ElementType!R def = (ElementType!R).init) if(isInputRange!R) {
   if(r.empty) return def;
   return r.front;
}

@UnitTest
void elementType() {
   import std.range : iota;

   // Standard arrays: returns the type of the elements of the array
   static assert(is(ElementType!(int[]) == int));

   // Accessing .front retrieves the decoded dchar
   static assert(is(ElementType!(char[])  == dchar)); // rvalue
   static assert(is(ElementType!(dchar[]) == dchar)); // lvalue

   // Ditto
   static assert(is(ElementType!(string) == dchar));
   static assert(is(ElementType!(dstring) == immutable(dchar)));

   // For ranges it gets the type of .front.
   auto range = iota(0, 10);
   static assert(is(ElementType!(typeof(range)) == int));
}
