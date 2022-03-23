import std.stdio;
void foo(scope int a) {
   int counter = a;
}

class A { }

A global_a;
void foo(scope A a) {
   global_a = a;
}

void main() {
   int num = 42;
   foo(num);

   A a = new A();
   foo(a);

   writeln(Fun.VAR_1);


}

class Fun {
   enum VAR_1 = 10;
   enum VAR_2 = 11;
   int sum() {
      return VAR_2 + VAR_1;
   }
}
