interface IFoo {}
interface IFun {}

class Foo: IFoo {}
class Fun: IFoo, IFun {}

class Bar {}

void main(string[] args) {
   //Come testare se un oggetto e' una istanza di una classe?
   //Si utilizza *cast* sfruttando il fatto che *null* e' sempre falso.

   // test di una classe concreta
   //----------------------------------------
   Bar bar = new Bar();
   assert(cast(Bar)bar);
   assert(!cast(IFoo)bar);
   assert(!cast(IFun)bar);

   // test di una classe concreta con interfaccia
   //----------------------------------------
   Foo foo = new Foo();
   assert(cast(Foo)foo);

   IFoo ifoo = new Foo();
   assert(cast(Foo)ifoo);
   assert(cast(IFoo)ifoo);

   // test di una classe concreta con due interfacce
   //----------------------------------------
   Fun fun = new Fun();
   assert(cast(Fun)fun);
   assert(cast(IFun)fun);
   assert(cast(IFoo)fun);

   IFun ifun = new Fun();
   assert(cast(Fun)ifun);
   assert(cast(IFun)ifun);
   assert(cast(IFoo)ifun);
   assert(!cast(Bar)ifun);

   // Oppure si usa *typeid*
   assert(typeid(bar) == typeid(Bar));
}

//Si puo' creare un wrapper:

bool instanceof(A, B)(B value) {
   return cast(A)value ? true : false;
}

//Infine da [d-idioms](http://p0nce.github.io/d-idioms/#Falsey-values)

// Equivalent for Java's instanceof
/*
 *if (auto derived = cast(Derived)obj) {
 *   // derived only defined in this scope
 *   doStuff(derived);
 *}
 */

//Infine si puo' creare una funzione generica che ritorna l' instanza:

T instanceof(T)(Object o) if(is(T == class)) {
   return cast(T)o;
}

