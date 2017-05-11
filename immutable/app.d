struct A {
   void fun() {}
   void gun() immutable {}
}
struct B {
   int x;
   int y;

}

void main(string[] args) {

   /*
    * Perche' devo metterci new?
    */
   auto a1 = new A();
   auto a2 = new immutable(A);
   a1.fun();

   //a1.gun(); //immutable method app.A.gun is not callable using a mutable object
   //a2.fun(); // Error: mutable method app.A.fun is not callable using a immutable object
   a2.gun();

   /*
    * e qui no?
    */
   B b = B();

   // B c = new B(); // Error: cannot implicitly convert expression (new B(0, 0)) of type B* to B
}
