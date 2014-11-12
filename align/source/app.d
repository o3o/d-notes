import std.stdio;

struct X {
   char a;
   int b;
   char c;
   int d;
   char e;
} unittest {
   X s;
   assert(s.sizeof == 20);
   assert(s.a.offsetof == 0);
   assert(s.b.offsetof == 4);
   assert(s.c.offsetof == 8);
   assert(s.d.offsetof == 12);
   assert(s.e.offsetof == 16);
}
struct Y {
   char a;
   int b;
   char c;
   char d;
} unittest {
   Y s;
   assert(s.sizeof == 12);
   assert(s.a.offsetof == 0);
   assert(s.b.offsetof == 4);
   assert(s.c.offsetof == 8);
   assert(s.d.offsetof == 9);
}
struct Z {
   char a;
   int b;
   char c;
   char d;
   char e;
} unittest {
   Z s;
   assert(s.sizeof == 12);
   assert(s.a.offsetof == 0);
   assert(s.b.offsetof == 4);
   assert(s.c.offsetof == 8);
   assert(s.d.offsetof == 9);
   assert(s.e.offsetof == 10);
}


// se non indicato align == 4
struct S_1 {
   align(1):
   char a;
   int b;
   char c;
   char d;
} unittest {
   S_1 s = S_1(1,2,3,4);
   assert(s.sizeof == 8);
   assert(s.alignof == 4);
   assert(s.a.alignof == 1);
   assert(s.a.offsetof == 0);
   assert(s.b.offsetof == 1);
   assert(s.c.offsetof == 5);
   assert(s.d.offsetof == 6);
}

// se non indicato align == 4
align struct Sa_1 {
   align(1):
   char a;
   int b;
   char c;
   char d;
} unittest {
   Sa_1 s = Sa_1(1,2,3,4);
   assert(s.sizeof == 8);
   assert(s.a.offsetof == 0);
   assert(s.b.offsetof == 1);
   assert(s.c.offsetof == 5);
   assert(s.d.offsetof == 6);
}

align(4) struct S4_1 {
   align(1):
   char a;
   int b;
   char c;
   char d;
} unittest {
   S4_1 s = S4_1(1,2,3,4);
   assert(s.sizeof == 8);
   assert(s.alignof == 4);
   assert(s.a.offsetof == 0);
   assert(s.b.offsetof == 1);
   assert(s.c.offsetof == 5);
   assert(s.d.offsetof == 6);
}
// e' equivalente a align(4) struct
struct S_2 {
   align(2):
   char a;
   int b;
   char c;
   char d;
} unittest {
   S_2 s = S_2(1,2,3,4);
   assert(s.sizeof == 12);
   assert(s.alignof == 4);
   assert(s.a.alignof == 1);
   assert(s.a.offsetof == 0);
   assert(s.b.offsetof == 2);
   assert(s.c.offsetof == 6);
   assert(s.d.offsetof == 8);
}
align(2) struct S2_2 {
   align(2):
   char a;
   int b;
   char c;
   char d;
} unittest {
   S2_2 s = S2_2(1,2,3,4);
   // cambia solo la dimensione della struttura.
   // Non sono inseriti i due byte finali.
   assert(s.sizeof == 10);
   assert(s.alignof == 4);
   assert(s.a.offsetof == 0);
   assert(s.b.offsetof == 2);
   assert(s.c.offsetof == 6);
   assert(s.d.offsetof == 8);
}
struct S_32 {
   align(32):
   char a;
   int b;
   char c;
   char d;
} unittest {
   S_32 s = S_32(1,2,3,4);

   assert(s.sizeof == 32*4);
   assert(s.alignof == 32);

   assert(s.a.offsetof == 0);
   assert(s.b.offsetof == 32);
   assert(s.c.offsetof == 64);
   assert(s.d.offsetof == 96);
}

void main() { }

ubyte[] toBuffer(T)(T s) {
   void* ptr = &s;
   ubyte* bufferPointer = cast(ubyte*)ptr;
   return bufferPointer[0 .. s.sizeof].dup;
}

