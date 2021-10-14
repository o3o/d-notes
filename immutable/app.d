import std.stdio;
struct A {
   void fun() {}
   void gun() immutable {}
}

struct B {
   int x;
   int y;
}

void main(string[] args) {

   A a1 = A();
   a1.fun();
   //a1.gun(); //immutable method app.A.gun is not callable using a mutable object

   auto a2 = new immutable(A);
   //a2.fun(); // Error: mutable method app.A.fun is not callable using a immutable object
   a2.gun();

   /*
    * Cosa accade se si dichiara
    * B b = new B();
    * Error: cannot implicitly convert expression (new B) of type B* to B
    */
   B* b = new B();
   B c = *b;
   (*b).x = 42;
   assert(c.x == 0);
   auto r = Reader();
   for (size_t i = 0; i < 10; ++i) {
      immutable(int) x = r.read;
      writeln(x + i);

   }
}
struct Reader {
   int read() {
      writeln("read:::");
      return 6;
   }
}

