import std.stdio;

void main(string[] args) {
   //http://dlang.org/spec/const3.html
   immutable int x = 3;
   immutable(int) y = 4;
   static assert(is(typeof(x) == immutable(int)));
   static assert(is(typeof(y) == immutable(int)));
   writeln(typeof(x).stringof);
   const int a = 3;
   const(int) b = 4;
   static assert(is(typeof(a) == const(int)));
   static assert(is(typeof(b) == const(int)));
}
void foo(const int x) {
   static assert(is(typeof(x) == const(int)));
}
void bar(ref int x) {
   static assert(is(typeof(x) == int));
}

void bar1(const ref int x) {
   int y = x;
   y++;
   static assert(is(typeof(x) == const(int)));
}

// in is a hybrid, since it's a synonym for scope const, and while scope is a storage class, const is a type qualifier.
void bar2(scope const int x) {
   static assert(is(typeof(x) == const(int)));
}

void bar3(in int x) {
   static assert(is(typeof(x) == const(int)));
}

void fun(const(int) x) {
   static assert(is(typeof(x) == const(int)));
}
