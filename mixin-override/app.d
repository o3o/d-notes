/**
https://blog.dicebot.lv/posts/2015/08/OOP_composition_with_mixins
 */
import std.stdio;
// shadowing
mixin template Inject() {
   void foo() { writeln("foo injected"); }
   void bar() { writeln("bar injected"); }
   void fun() {}
}

struct S {
   // si puo' scrivere anche:
   // mixin Inject;
   mixin Inject!();
   void bar() { writeln("bar overriden"); }
   void fun() { writeln("fun overriden"); }
}

// reimplementing

// fornisce il metodo foo base
mixin template BaseFooImpl() {
   void baseFoo() { writeln("Default FOO injected"); }
}

// fornisce il metodo foo
mixin template BarImpl(alias imp) {
   void foo() {
      imp();
   }
}

struct S1 {
   mixin BaseFooImpl!(); // provides `this.baseFoo`
   mixin BarImpl!(baseFoo);
}

struct S2 {
   void myFoo() { writeln("My foo"); }
   mixin BarImpl!(myFoo);
}

void main() {
   reimplementing();
}

void shadowing() {
   S s;
   s.foo();
   s.bar();
   s.fun();
}

void reimplementing() {
   S1 s1;
   writeln("S1");
   writeln("----------");

   s1.foo();
   writeln("S2");
   writeln("----------");

   S2 s2;
   s2.foo();
}
