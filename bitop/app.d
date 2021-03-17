import std.stdio;
import core.bitop;
/*
 *Test del modulo bitop http://dlang.org/phobos/core_bitop.html
 *This module contains a collection of bit-level operations
 */
void main(string[] args) {
   // Test del bit
   // ----------------------------------------
   // Si usa bt (BitTest?), il prototipo e'
   // int bt(in size_t* p, size_t bitnum);
   // quindi non si puo' passare direttamente un byte
   ubyte five = 0x05;
   ulong input = five;
   assert(bt(&input, 0)); // bit 0
   assert(!bt(&input, 1));
   assert(bt(&input, 2));
   assert(bt(&input, 2) == 1); // equivalente

   ubyte effe = 0x0F;
   ulong finput = effe;
   assert(bt(&finput, 0)); // bit 0
   assert(bt(&finput, 1));
   assert(bt(&finput, 2));
   assert(bt(&finput, 3));
   assert(!bt(&finput, 4));
   assert(!bt(&finput, 5));
   assert(!bt(&finput, 6));
   assert(!bt(&finput, 6));

   // cosi non si puo' fare:
   //assert(bt(&(cast(size_t)d), 0));
   // perche' `cast(ulong)d is not an lvalue`:

   // con una funzione
   // ........................................
   ubyte d = 0x0d;
   assert(bitTest(d, 0));
   assert(!bitTest(d, 1));
   assert(bitTest(d, 2));
   assert(bitTest(d, 3));


   // Test e reset del bit
   // ----------------------------------------
   // Si usa btr (BitTestReset?)
   //
   // il bit 0 era a 1...
   assert(btr(&input, 0) == 1);
   // ora e' a zero
   assert(input == 4);
   // il bit 1 era a 0...
   assert(btr(&input, 1) == 0);
   // rimane e' a zero
   assert(input == 4);

   // Test e set del bit
   // ----------------------------------------
   // Si usa bts (BitTestSet?)
   //
   // il bit 0 era a 0...
   input = 0x2;
   assert(bts(&input, 0) == 0);
   // ora e' a 1
   assert(input == 3);

   // il bit 1 era a ...
   assert(bts(&input, 1) == 1);
   // rimane e' a 1
   assert(input == 3);


   // probabilmente conviene lavorare con ulong e convertire alla bisogna:
   ubyte three = cast(ubyte)input;
   assert(three == 3);
   // oppure
   three = input & 0xFF;
   assert(typeid(three) == typeid(ubyte));
   assert(three == 3);


   // Test con array
   // ----------------------------------------
   size_t[2] array;
   array[0] = 0x2;
   array[1] = 0x3;

   assert(bt(array.ptr, 1));
   // sono ulong cioe 8 byte => 64 bit
   static assert(array[0].sizeof == 8);
   // test del bit 0 e 1 di array[1]
   assert(bt(array.ptr, 0 + 64));
   assert(bt(array.ptr, 1 + 64));

   assert(array[0] == 2);
   assert(array[1] == 0x3);

   // and
   int engMask = 1;
   assert(0xFF & engMask);
   assert(0x01 & engMask);
   assert(!(0x02 & engMask));
   engMask = 3; // 1, 2 e 3
   assert(0xFF & engMask);
   assert(0x01 & engMask);
   assert(2 & engMask);
   assert(!(4 & engMask));
}

int bitTest(ubyte b, size_t bitnum) {
   size_t input = b;
   return bt(&input, bitnum);
}
