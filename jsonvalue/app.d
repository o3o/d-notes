import std.stdio;
import std.json;
void main(string[] args) {
   arrayOfArray;
}
void test0() {
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

   // creazione di un array
   // si deve sempre partire da un JSONValue che contine l'array al suo interno
   JSONValue obj;
   JSONValue[] c;
   c ~= JSONValue("a");
   obj.array = c;
   writeln(obj.toString);
   // non funziona:
   //obj.array = JSONValue[];


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

void arrayOfArray() {
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

