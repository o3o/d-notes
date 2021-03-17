// compilare con dmd *.d
import std.conv;
import std.stdio;

/**
 * Ci sono due tipi di is
 *
 * - operatore (a is b)
 * - espressione (is(xxx)) pg.147 Parker
 */

void main(string[] args) {
   int[] x = [1, 2, 3];
   int[] y = [1, 2, 3];
   //hanno gli stessi elementi quindi
   assert(x == y);
   //pero' i riferimenti sono diversi
   assert(x !is y);

   //struct
   A a = A(10);
   A b = A(10);
   // sono bit a bit uguali: sono uguali
   assert(a == b);
   // e anche identiche
   assert(a is b);

   // class
   C c1 = new C();
   c1.foo= 10;
   C c2 = new C();
   c2.foo= 10;
   assert(c1 != c2);
   assert(c1 !is c2);

   C c3 = c1;
   assert(c1 is c3);
   assert(c1 == c3);
   C c4;
   // assert(c4 == null); errore
   assert(c4 is null);



}

struct A {
   int foo;
}

class C {
   //this(int f) {
      //foo = f;
   //}
   int foo;
}

