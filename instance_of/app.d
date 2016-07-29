interface IFoo {}
class Foo: IFoo {}
class Bar {}

void main(string[] args) {


   //Come testare se un oggetto e' una istanza di una classe?
   //Si utilizza *cast*:
   //sfruttando il fatto che *null* e' sempre falso.
   Bar bar = new Bar();
   assert(cast(Bar)bar);

   Foo foo = new Foo();
   assert(cast(Foo)foo);

   IFoo ifoo = new Foo();
   assert(cast(Foo)ifoo);

   // Oppure si usa *typeid*
   assert(typeid(bar) == typeid(Bar));
}

//Si puo' creare un wrapper:

bool instanceof(A, B)(B value) {
   return cast(A)value ? true : false;
}

//Infine da [d-idioms](http://p0nce.github.io/d-idioms/#Falsey-values)

// Equivalent for Java's instanceof
//if (auto derived = cast(Derived)obj) {
   //// derived only defined in this scope
   //doStuff(derived);
//}

//Infine si puo' creare una funzione generica che ritorna l' instanza:

T instanceof(T)(Object o) if(is(T == class)) {
   return cast(T)o;
}

