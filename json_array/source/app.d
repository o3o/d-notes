import std.stdio;
import vibe.data.json;

void main() {
   //writeln(create2.toPrettyString);
   //testExist;
   //useAppend;
   //noAppend;
   string json = `{"v_supply_sp": "a"}`;
   Data data = deserializeJson!Data(json);
   writeln(data);
}

/**
* Verifica che aggiungendo jsonarray con ~, si ottiene un array e non un array di array
*
* Examples:
* Si ottiene
* --------------------
*  [10,11,20,21]
* --------------------
*
* e non
* --------------------
*  [[10,11],[20,21]]
* --------------------
*
*/
void noAppend() {
   Json jA = Json.emptyArray;
   jA ~= Json(10);
   jA ~= Json(11);
   assert(jA.length == 2);
   writefln("jA %s", jA);


   Json jB = Json.emptyArray;
   //Json[] jB;
   jB ~= Json(20);
   jB ~= Json(21);
   writefln("jB %s", jB);


   Json jrow = Json.emptyArray;
   //Json[] jrow;
   jrow ~= jA;
   jrow ~= jB;
   writefln("jr %s", jrow);

   //assert(jrow.length == 2);

   Json j = Json.emptyObject;
   j["data"] = jrow;
   writeln(j.toString);
}

void testExist() {
   Json j = create1();
   auto ptr = "key" in j;
   // ptr e' true se punta a qualcosa
   assert(ptr);
   writeln(*ptr);

   ptr = "pss" in j;
   assert(!ptr);
   auto ptrA = "try" in j;
   assert(ptrA);
   writeln(*ptrA);

   ptrA = "cul" in j;
   assert(!ptrA);

}

void testCreate0() {
   Json jrow = Json.emptyArray;
   jrow.appendArrayElement(Json([ "type": Json("null"), "key": Json("00") ]));
   jrow.appendArrayElement(Json([ "type": Json("null"), "key": Json("01") ]));
   jrow.appendArrayElement(Json([ "type": Json("null"), "key": Json("02") ]));
   Json j = Json(
         [
         "type": Json("seq"),
         "key": Json("s0"),
         "try": jrow
         ]);
   writeln(j.toString);
}

Json create1() {
   return Json([
         "type": Json("seq"),
         "key": Json("s0"),
         "try": Json([
            Json([ "type": Json("null"), "key": Json("00") ]),
            Json([ "type": Json("null"), "key": Json("01") ]),
            Json([ "type": Json("null"), "key": Json("02") ])
         ])
   ]);
}

Json create2() {
   Json x = Json.emptyArray;
   x ~= Json(10);
   x ~= Json(11);
   x ~= Json(12);
   Json j = Json(
         [
         "id": Json("octave"),
         "type": Json("octave_chart"),
         "value": Json(["x": x, "y": Json(2), "z": Json(3)])
         ]);

   Json e = Json.emptyArray;
   e ~= j;
   e ~= Json(         [
         "id": Json("cul"),
         "type": Json("pela"),
         "value": Json("cacc")
         ]);
   Json c = Json(
         [
         "container": e
         ]
         );
      return c;
}

/**
* Dimostra che con appendArray si ottengono array di array
*
*/
void useAppend() {
   // con append array
   //----------------------------------------
   Json jA = Json.emptyArray;
   jA ~= 11;
   jA ~= 12;
   // jA = [11, 12]

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


struct Data {
   @name("v_supply_sp") string vSupplySp;
}

