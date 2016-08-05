module tests.foo;

import unit_threaded;

interface Foo {
   int foo(int, string) @safe pure;
   void bar() @safe pure;
}
class Bar {
   private Foo _f;
   this(Foo f) {
      _f = f;

      /*code*/
   }
   int bar(int x) {
      return _f.foo(x, "a") * 5;
   }

}
void testFoo() {
   auto m = mock!Foo;
   Bar b = new Bar(m);
   m.expect!"foo"(10, "a");
   m.returnValue!"foo"(3);

   int x = b.bar(10);
   x.shouldEqual(15);
   m.verify;
}
void testFoo2() {
   auto m = mock!Foo;
   Bar b = new Bar(m);
   m.returnValue!"foo"(3);

   int x = b.bar(10);
   x.shouldEqual(15);
   m.expectCalled!"foo"(10, "a");
}
