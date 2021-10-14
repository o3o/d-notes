// rdmd -unitest app.d
import std.stdio;
import std.json;
void main(string[] args) {
   //test0;
   //arrayOfArray;
}
unittest {
   //come aggiunge elementi ad un oggetto json?
   // di fatto on oggetto josn e' un array associativo
   JSONValue a = parseJSON(`{"a":10, "b": 20}`);
   // per aggiungere b..
   JSONValue b = parseJSON(`{"a":12, "d": 22}`);
   // e' necessario aggiungere le chiavi singolarmente
   foreach (string k, v; b) {
      a[k] = v;
   }
   writeln(a.toPrettyString);
}
unittest {
   // elencare le chiavi di un oggetto json
   JSONValue a = parseJSON(`{
         "iso":{
            "rmin" : { "value"  : 45, "unit": "omm"},
            "duration" : { "value"  : 47, "unit": "s"},
         },
         "iso2":{
            "rmin" : { "value"  : 46, "unit": "omm"}
         },
         "iso3":{
            "rmin" : { "value"  : 47, "unit": "omm"}
         }
      }`);
   foreach (string k, v; a) {
      writeln(k);
   }
   assert(a.object.keys == ["iso", "iso2", "iso3"]);
}

unittest {
   // come ottenere la chiave (iso) dalla struttura?
   /* {
      "iso":{
         "rmin" : { "value"  : 45, "unit": "omm"},
         "duration" : { "value"  : 47, "unit": "s"},
      },
    */
   JSONValue a = parseJSON(`{
         "iso":{
            "rmin" : { "value"  : 45, "unit": "omm"},
            "duration" : { "value"  : 47, "unit": "s"},
         }}`);
   assert(a.object.length == 1);
   assert(a.object.keys[0] == "iso");
   // come ottenere il contenuto di iso?
   JSONValue c = a.object[a.object.keys[0]];
   assert(c.object.length == 2);
   assert(c["rmin"]["unit"].str == "omm");
 }


unittest {
   // come creare la struttura:
   // {
   //    "iso":{
   //    "rmin" : { "value"  : 45, "unit": "omm"},
   //    "duration" : { "value"  : 47, "unit": "s"},
   //},

   JSONValue a;
   JSONValue s;
   JSONValue p;
   // si crea il contento di rmin
   p["value"] = 46;
   p["unit"] = "ohm";
   // si crea rmin
   s["rmin"] = p;

   // si crea un oggetto duration vuoto..
   s["duration"] = JSONValue();
   // si puo' ora assegnare un valore
   s["duration"]["value"] = 5 ;
   a["iso"] = s;
   assert(a["iso"]["rmin"]["value"].integer == 46);

   // usando la stessa tecnica di duration...
   JSONValue b;
   b["iso"] = JSONValue();
   b["iso"]["rmin"] = JSONValue();
   b["iso"]["rmin"]["value"] = 1964;
   assert(b["iso"]["rmin"]["value"].integer == 1964);
}
unittest {

   JSONValue a = parseJSON(`[
         "Messaggio 0",
         "Messaggio 1",
         "Messaggio 2",
         "Messaggio 3"
   ]`);
   writefln("len: %s", a.array.length);
   // se si usa una var. si deve fare il cast
   string m3 = a[3].get!string;
   writefln("m[3]: %s", m3);
   a[0] = "nuovo";
   writefln("m[0]: %s", a[0]);
}
// creazione di un array `["a", "b"...]
unittest {
   // si deve sempre partire da un JSONValue che contine l'array al suo interno
   JSONValue obj;
   JSONValue[] c;
   c ~= JSONValue("a");
   obj.array = c;
   writeln(obj.toString);
   // non funziona:
   //obj.array = JSONValue[];
}
// creazione di un array `["z", "b"...]
unittest {
   JSONValue obj2  =  ["z"];
   obj2.array ~= JSONValue("b");
   writeln("obj2 ", obj2.toString);

   // non funziona:
   //JSONValue obj3 ;
   //obj3.array ~= JSONValue("b");
   //writeln("obj3 ", obj3.toString);
   // funziona
   int[] aa;
   JSONValue obj4 = JSONValue(aa);
   obj4.array ~= JSONValue(2);
   writeln("obj4 ", obj4.toString);

   int[] a5;
   a5 ~= 1;
   a5 ~= 2;
   JSONValue obj5 = JSONValue(a5);
   obj5.array ~= JSONValue(42);
   writeln("obj5 ", obj5.toString);
   // per accedere
   writeln(obj5[0].get!int);

   // creare unn array all'nterno di un json
   // {
   // a : "a",
   // tasks : []
   // }
   JSONValue root;
   root["a"] = JSONValue("x");
   JSONValue[] arr;
   arr ~= JSONValue("ar");
   arr ~= JSONValue("cul");
   root["tasks"] = arr;
   writeln(root.toString);

   /+
      //creare un array di array
      JSONValue[] point0;
   point0 ~= JSONValue(0.);
   point0 ~= JSONValue(3.);
   JSONValue ap0;
   ap0.array = point0;
   writeln("p0;", ap0);


   JSONValue[] point1;
   point1 ~= JSONValue(30.);
   point1 ~= JSONValue(42.);
   JSONValue ap1;
   ap1.array = point1;
   //ap1.array = [JSONValue(30), JSONValue(40)];

   JSONValue[] s0;
   s0 ~= ap0;
   s0 ~= ap1;
   JSONValue as0;
   as0.array = s0;
   writeln("as0", as0);

   /+
      JSONValue s1;
   s1.array ~= point0;
   s1.array ~= point1;
   +/

      JSONValue all;
   all.array = s0;
   /+   all.array ~= s1;
   +/
      writeln(all.toString);
   +/

      JSONValue curr;
   JSONValue volt;
   JSONValue[] s;
   s ~= JSONValue([0. , 42]);
   s ~= JSONValue([30.,  43]);

   curr.array = s;
   volt.array = s;
   JSONValue all = JSONValue([curr, volt]);
   writeln(all.toString);
}


// array di array
unittest {
   // si vuole
   // [
   //   [[0,1],[1,2],[2,3],[3,4]],
   //   [[0,11],[1,12],[2,13],[3,14]],
   //   [[0,21],[1,22],[2,23],[3,24]]
   // ]

   int[] a;
   int[] b;
   enum SERIES = 3;

   JSONValue seriesArray = JSONValue(a);
   foreach (s; 0 .. SERIES) {
      seriesArray.array ~= JSONValue(b);
   }
   foreach (t; 0 .. 4) {
      foreach (s; 0 .. SERIES) {
         seriesArray[s].array ~= JSONValue([t, 1 + s * 10]);
      }
   }

   writeln(seriesArray);
}

void test1() {
   JSONValue a = parseJSON(`{
         "general" : ["A", "B", "C"],
         "electric" : ["E", "F", "G"],
         "support" : ["H", "I", "L"],
         }`);
   foreach (string s, JSONValue j; a.object) {
      writeln(s);
      foreach (e; j.array) {
         writeln("\t", e.str);
      }
   }
}

void test2() {
   JSONValue a = parseJSON(`
         [
         {
         "alarm_no": 42,
         "task_code": 1964,
         "type": 1
         },
         {
         "alarm_no": 43,
         "task_code": 2004,
         "type": 2
         }
         ]
         `);
   for (size_t i = 0; i < 5 && i < a.array.length; ++i) {
      writeln(a[0]["type"].get!int);
   }
}
unittest {
   writeln();
   writeln( "creare un array di object");
   writeln("----------");
   // creare un array di object
   // tipo
   // [
   //   { ...},
   //   { ...},
   // ]
   JSONValue[] a;
   a ~= JSONValue(["a" : 10]);
   a ~= JSONValue(["b" : 11]);
   JSONValue obj = JSONValue(a);
   // oppure
   //JSONValue obj;
   //obj.array = a;
   writeln(obj.toPrettyString);
   writeln();
}
unittest {
   writeln( "creare un array di object ottenuti da stringhe");
   writeln("----------");
   // creare un array di object
   // tipo
   // [
   //   { ...},
   //   { ...},
   // ]
   JSONValue[] a;
   a ~= parseJSON(`{"action": "start", "source": "cul"}`);
   a ~= parseJSON(`{"action": "stop", "source": "cacc"}`);
   JSONValue obj = JSONValue(a);
   // oppure
   //JSONValue obj;
   //obj.array = a;
   writeln(obj.toPrettyString);
   writeln();
}


unittest {
   writeln( "creare un array di object all'interno di un object");
   writeln("----------");

   // es:
   // {
   //   name: iso,
   //   tasks: [
   //     { ...},
   //     { ...},
   //   ]
   JSONValue[] a;
   a ~= JSONValue(["a" : 10]);
   a ~= JSONValue(["b" : 11]);
   JSONValue tasks;
   tasks.array = a;

   JSONValue obj;
   obj["name"] = "iso";
   obj["tasks"] = tasks;
   writeln(obj.toPrettyString);
}


