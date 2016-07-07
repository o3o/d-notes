
void foo(scope int a) {
   counter = a;
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
}
