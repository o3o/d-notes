module alg.find;

import std.stdio;

import std.algorithm;
import std.array; // per la property array
import std.range;

import unit_threaded;

void testFindSkip() {
   ubyte[] buf = [0,1,2,3,4,5,6,7,8,9];
   bool found = findSkip(buf, [6]);
   found.shouldBeTrue;
   buf.shouldEqual([7,8,9]);
   writeln("found",buf);

   buf = [0,1,2,3];
   found = findSkip(buf, [66]);
   found.shouldBeFalse;
   buf.shouldEqual([0, 1, 2, 3]);
   writeln("!found",buf);
}


void testFindSplitBefore() {
   ubyte[] buf = [0,1,2,3,4,5,6,7,8,9];
   auto r = buf.findSplitBefore([6, 7]);

   r[0].shouldEqual([0, 1, 2, 3, 4, 5]);
   r[1].shouldEqual([6,7,8,9]);

   typeof(r[1]).stringof.shouldEqual("ubyte[]");
}
struct Foo {
   string name;
   string surname;
}

void testFindLambda() {
   Foo[] foos = [Foo("Homer", "Da Via"), Foo("Homer", "Simpson"), Foo("Bart",
         "Simpson"), Foo("Lisa", "Simpson")];
   Foo[] simpson = foos.find!((a, b) => a.surname == b)("Simpson");
   simpson.length.shouldEqual(3);

   auto homer = foos.find!((a, b) => a.name == b.name && a.surname ==
         b.surname)(Foo("Homer", "Simpson"));

   homer.length.shouldEqual(3);

   Foo[] none = foos.find!(f => f.name == "Orfeo" && f.surname == "Simpson");
   none.length.shouldEqual(0);
}

void Filter() {
   Foo[] foos = [Foo("Homer", "Da Via"), Foo("Homer", "Simpson"), Foo("Bart",
         "Simpson"), Foo("Lisa", "Simpson")];

   auto homer = foos.filter!(a => a.name == "Homer" && a.surname ==
         "Simpson")
         .array;
   homer.length.shouldEqual(1);

   auto none = foos.filter!(a => a.name == "Orfeo" && a.surname =="Simpson");
   none.empty.shouldBeTrue;

   Foo[] noneA = none.array;
   noneA.take(1).empty.shouldBeTrue;
   noneA.length.shouldEqual(0);
   assert(noneA.take(1) is null);
   Foo h = noneA[0];
   //assert(h is null);
}

/**
 * Verifica se una stringa contiene una sottostringa
 */
void testContains() {
   string foo = "../../../.dub/packages/vibe-d-0.8.3-beta.1/vibe-d/http/vibe/http/server.d";
   foo.canFind("beta").shouldBeTrue;
   foo.canFind("packages").shouldBeTrue;
   foo.canFind("cul").shouldBeFalse;
   //foo.canFind("").shouldBeFalse;
}

