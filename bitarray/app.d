// dmd app.d -ofb
import std.bitmanip;
import std.stdio;
import std.algorithm : equal;


void main(string[] args) {
   writeln("Dim di size_t ", size_t.sizeof);

   // creazione
   // --------------------
   BitArray b0;
   BitArray b1 = BitArray([1, 0, 0, 1, 0]);
   BitArray b2 = BitArray([true, false, true, false]);
   bool[8] init = 0;
   BitArray b4 = BitArray(init);

   // lunghezza
   // --------------------
   writeln("b0.length: ", b0.length);
   writeln("b1.length: ", b1.length);
   writeln("b2.length: ", b2.length);
   writeln("b4.length: ", b4.length);


   // get di un bit
   // --------------------
   writeln("b1[0]: ", b1[0]);
   assert(b1[0]);
   writeln("b1[4]: ", b1[4]);
   assert(!b1[4]);
   // si puo' fare
   writeln("b1[15]: ", b1[15]);

   // set di un bit
   // Si puoi usare 0, 1 oppure true false
   // --------------------
   b1[3] = false;
   b1[4] = 1;
   writeln("set b1[4]: ", b1[4]);
   assert(b1[4]);

   // Verificare i bit a 1
   // --------------------
   auto b3 = BitArray([0, 1, 0, 0, 1, 0]);
   assert(b3.bitsSet.equal([1, 4]));


   // convertire un intero in bitarray
   // ----------------------
   ulong x = 5; // 101
   // questa funzione e' deliberatamente non documentata
   BitArray b5 = BitArray(8, &x);
   assert(b5.bitsSet.equal([0, 2]));

   // convertire un intero in bitarray 2
   // ----------------------
   /*
    * void[] e' un array di otteti, 5 e' un intero rappresentato con 4 bytes quindi  v ha lunghezza 4
    * In phobos binmanip e' scritto
    * in {
    *     assert(numbits <= v.length * 8);
    *     assert(v.length % size_t.sizeof == 0);
    * }
    * cioe' la lunghezza in bytes di v deve essere multiplo di 8.
    * Probabilmente non e' applicato perche' phobos e' compilato in modalita release
    */
   void[] v = [5];

   writefln("[%( 0x%x %)] : len %d, sizeof %d, mod %d", v, v.length, size_t.sizeof, v.length % size_t.sizeof);
   BitArray b6 = BitArray(v, 8);
   assert(b6.bitsSet.equal([0, 2]));

   /**
     In questo caso il valore da converire ha piu di 8 bit
     ma indicando 8, usa solo i primi 8 bit
    */
   v = [0xA05];
   writefln("%s len %d, sizeof %d, mod %d",v, v.length, size_t.sizeof, v.length % size_t.sizeof);
   b6 = BitArray(v, 8);
   assert(b6.bitsSet.equal([0, 2]));


   /*
    *v ha lunghezza 8 e si puo rappresentare cosi
    *[0x5, 0x0, 0x0, 0x0, 0x7, 0x0, 0x0, 0x0]
    */
   v = [0x05, 0x7];
   writefln("[%( 0x%x,%)] : len %d, sizeof %d, mod %d", v, v.length, size_t.sizeof, v.length % size_t.sizeof);
   // uso solo 16 bit quindi [0x5 0x0]
   b6 = BitArray(v, 16);
   assert(b6.bitsSet.equal([0, 2]));

   /* dovrebbe usare 40 bit cioe'
    * [0x5, 0x0, 0x0, 0x0, 0x7]
    * ma alla fine utilizza solo i primi 8
    */
   b6 = BitArray(v, 40);
   assert(b6.bitsSet.equal([0, 2]));
   writeln("bit set");
   foreach (e; b6.bitsSet) {
      writeln("\t", e);
   }

   // forach
   // ----------------------
   writeln("Without index");
   foreach (e; b6) {
      writeln("\t", e);
   }
   writeln("With index");

   foreach (i, e; b6) {
      writefln("\tb6[%d] = %d",i, e);
   }
}
