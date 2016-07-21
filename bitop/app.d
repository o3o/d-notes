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

   // cosi non si puo' fare perche'
   //`cast(ulong)d is not an lvalue`:
   //assert(bt(&(cast(size_t)d), 0));

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
}

int bitTest(ubyte b, size_t bitnum) {
   size_t input = b;
   return bt(&input, bitnum);
}
