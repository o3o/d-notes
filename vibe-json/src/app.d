import std.stdio;
import vibe.data.json;

version (unittest) {
   import unit_threaded;
} else {
   void main(string[] args) {
      writeln("USE dub test -- -d testname");
   }
}

unittest {
   auto j = parseJsonString(`{"title": {
            "text": "Acquisitore 0"
        },
        "xAxis": {
            "type": "datetime",
            "gridLineWidth": 1,
            "labels": {
                "overflow": "justify"
            }
        }
        }`);

   j["title"]["text"] = "cul";
   j["title"]["frit"] = "piss";
   writefln("JSON: %s", j.toString());
}

unittest {
   auto j = Json.emptyObject;
   j["title"] = Json.emptyObject;

   j["title"]["text"] = "cul";
   j["title"]["frit"] = "piss";
   writefln("JSON: %s", j.toPrettyString());
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
*  [[10,11],20,21]]
* --------------------
*/
unittest {
   Json jA = Json.emptyArray;
   jA ~= Json(10);
   jA ~= Json(11);
   jA.length.shouldEqual(2);
   jA.toString().shouldBeSameJsonAs(`[10, 11]`);

   Json jB = Json.emptyArray;
   jB ~= Json(20);
   jB ~= Json(21);
   jB.length.shouldEqual(2);



   Json jrow = Json.emptyArray;
   //Json[] jrow;
   jrow ~= jA;
   jrow ~= jB;
   writefln("jr %s", jrow);

   //assert(jrow.length == 2);
}


/**
* Dimostra che con appendArray si ottengono array di array
*
*/
@("append")
unittest {
   Json j0 = Json.emptyArray;
   j0 ~= 11;
   j0 ~= 12;
   j0.toString.shouldBeSameJsonAs(`[11, 12]`);

   Json j1 = Json.emptyArray;
   j1 ~= 21;
   j1 ~= 22;

   Json j2 = Json.emptyArray;
   j2 ~= 31;
   j2 ~= 32;

   Json jrow = Json.emptyArray;
   jrow.appendArrayElement(j0);
   jrow.appendArrayElement(j1);
   jrow.appendArrayElement(j2);

   jrow.length.shouldEqual(3);
   jrow[0].length.shouldEqual(2);
   jrow[1].length.shouldEqual(2);
   jrow.toString.shouldBeSameJsonAs(`[[11,12], [21,22], [31,32]]`);

}
