module tests.foo;

import unit_threaded;

interface Foo {
   int foo(int, string) @safe pure;
   void bar() @safe pure;
}

void testFoo() {
   auto m = mock!Foo;
   m.expect!"foo";
}
