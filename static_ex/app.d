// dmd app.d
import std.stdio;
import std.concurrency;
import core.thread;

static int positive;

void worker() { }

void main(string[] args) {
   for (int i = -1; i < 2; ++i) {
      writefln("x: %d, calls %s positive %s", i, fun(i), positive);
   }
   spawn(&worker);
   thread_joinAll();
}

int fun(int x) {
   static int calls = 0;
   ++calls;
   if (x > 0) {
      ++positive;
   }
   return calls;
}


class Foo {
   static this() {
      positive = 51;
      writeln("classe:", positive);
   }
}

static this() {
   positive = 23;
   writeln("modulo:", positive);
}
