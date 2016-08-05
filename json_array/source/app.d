import std.stdio;
import vibe.data.json;

void main() {

   Json jA = Json.emptyArray;
   jA ~= Json(10);
   jA ~= Json(11);
   assert(jA.length == 2);


   //Json jB = Json.emptyArray;
   Json[] jB;
   jB ~= Json(20);
   jB ~= Json(21);

   //Json jrow = Json.emptyArray;
   Json[] jrow;
   jrow ~= jA;
   jrow ~= jB;

   //assert(jrow.length == 2);

   Json j = Json.emptyObject;
   j["data"] = jrow;
   writeln(j.toString);

   foo;
}

void foo() {
   // con append array
   //----------------------------------------
   Json jA = Json.emptyArray;
   jA ~= 11;
   jA ~= 12;

   Json jB = Json.emptyArray;
   jB ~= 21;
   jB ~= 22;

   Json jrow = Json.emptyArray;
   jrow.appendArrayElement(jA);
   jrow.appendArrayElement(jB);


   Json j = Json.emptyObject;
   j["data"] = jrow;
   writeln();

   writeln("con appendArrayElement");
   writeln(j.toString);

}
