import std.stdio;
import binrange;
import std.array: appender;

/*
 * Il compito e' convertire un array di ubyte in array di double
 * Si prova con due modi:
 * 0. union
 * 1. binrange https://github.com/p0nce/binrange
 */
void main() {
   // Usando union
   //----------------------------------------
   // Non si possono usare array dinamici, ma solo statici
   ubyte[16] all = [0x0, 0x0, 0x0, 0x0, 0x0, 0xb0, 0x9e, 0x40,
      0x33, 0x33, 0x33, 0x33, 0x33, 0xb3, 0x32, 0xc0]; //1964, -18.7
   double[2] u = bytetod(all);
   assert(u.length == 2);
   assert(u[0] == 1964.0);
   assert(u[1] == -18.7);

   // Con binrange (https://github.com/p0nce/binrange)
   //----------------------------------------
   ubyte[] input = [0x0, 0x0, 0x0, 0x0, 0x0, 0xb0, 0x9e, 0x40,
      0x33, 0x33, 0x33, 0x33, 0x33, 0xb3, 0x32, 0xc0]; //1964, -18.7
   // pop si "mangia" il vettore!
   assert(input.length == 16);
   double p0 = popLE!double(input);
   assert(input.length == 8); // eliminati 8

   double p1 = popLE!double(input);
   assert(input.length == 0); // altri 8!

   assert(p0 == 1964.0);
   assert(p1 == -18.7);


   ubyte[] input1 = [
      0x0, 0x0, 0x0, 0x0, 0x0, 0xb0, 0x9e, 0x40, //1964
      0x33, 0x33, 0x33, 0x33, 0x33, 0xb3, 0x32, 0xc0, // -18.7
      0, 0, 0, 0, 0, 0, 0xe0, 0x3f, //0.5
      0x1, 0x2 ]; // questi sono in piu
   //1964, -18.7
   writefln("ubyte array [%(0x%x, %)]", input1);
   double[] r = parseBlob(input1);
   assert(r.length == 3);
   assert(r[0] == 1964.0);
   assert(r[1] == -18.7);
   assert(r[2] == .5);
   writefln("double array [%(%f, %)]", r);


   // Creazione di un array di ubyte da un float
   //----------------------------------------
   ubyte[] arr0;
   auto app0 = appender(arr0);
   writeBE!float(app0, 80.0f);

   writefln("appender BE array [%(0x%x, %)]", app0.data);

   ubyte[] arr1;
   auto app1 = appender(arr1);
   writeLE!float(app1, 80.0f);
   writefln("appender LE array [%(0x%x, %)]", app1.data);
   assert(app1.data[0] == 0x0);
   assert(app1.data[1] == 0x0);
   assert(app1.data[2] == 0xA0);
   assert(app1.data[3] == 0x42);

   // Creazione di un array di ubyte da un int16
   //----------------------------------------
   ubyte[] arr2;
   auto app2 = appender(arr2);
   writeLE!ushort(app2, 0x0126);
   assert(app2.data[0] == 0x26);
   assert(app2.data[1] == 0x01);
}

union double_ubyte {
   double[2] f;
   ubyte[16] i;
}

double[2] bytetod(ubyte[16] x) pure nothrow {
   double_ubyte db;
   db.i = x;
   return db.f;
}

double[] parseBlob(ubyte[] blob) {
   double[] d;
   while (blob.length >= 8) {
      d ~= popLE!double(blob);
   }
   return d;
}
