// dmd app_s.d -ofas
import std.stdio;
import std.concurrency;
import core.thread;

int a;              // thread-local
immutable int b;    // shared by all threads

void worker() { }

void main() {
   writeln("main");
   spawn(&worker);

   thread_joinAll();
}

static this() {
   writeln("Initializing per-thread variable at ", &a);
   a = 42;
}

shared static this() {
   writeln("Initializing per-program variable at ", &b);
   b = 43;
}

