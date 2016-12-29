/**
https://blog.dicebot.lv/posts/2015/08/OOP_composition_with_mixins
 */
import std.stdio;

// shadowing
//----------------------------------------
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
//----------------------------------------
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

// con interfacce
//----------------------------------------
interface IAlgorithm {
   @property string key();
   @property string description();
   int execute();
   void reset();
}

import std.traits;
import std.string;
mixin template Algorithm(T) {
   static assert( is(T t == struct) );
   static assert(hasMember!(T, "key"));
   static assert(hasMember!(T, "type"));
   static assert(hasMember!(T, "description"));

   private T data;
   @property string key() { return data.key; }
   @property string description() { return "type: %s key: %s description %s".format(data.type, data.key, data.description); }

   void reset() { writeln("reset injected"); }
}

struct Data {
   string type;
   string key;
   string description;
}

struct DataB {
   string type;
   string key;
   string description;
   int b;
}

// passando questa struttura non si compila
struct DataInv {
   string type;
}


class A: IAlgorithm {
   //mixin Algorithm!(DataInv);
   // genera
   //app.d(59): Error: static assert  (hasMember!(DataInv, "key")) is false

   mixin Algorithm!(Data);

   int execute() {
      return 0xa;
   }
}
class B: IAlgorithm {
   mixin Algorithm!(DataB);

   this(DataB data) {
      this.data = data;
   }

   int execute() {
      return 0xb;
   }
   void reset() { writeln("reset overriden"); }
}

void main() {
   //reimplementing();
   interfaces();
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

void interfaces() {
   IAlgorithm a = new A();
   assert(a.execute == 0xa);
   a.reset();
   writefln("a key: `%s`, desc: `%s`", a.key, a.description);

   DataB d = {key: "kk", type: "bbb", description: "data b"};
   IAlgorithm b = new B(d);
   assert(b.execute == 0xb);
   b.reset();
   writefln("b key: `%s`, desc: `%s`", b.key, b.description);
}
