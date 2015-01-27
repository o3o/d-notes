module tests.phobos_signal;


/*
   Esempio da http://dlang.org/phobos/std_signals.html
*/
import std.signals;
import std.stdio;
import unit_threaded;

// observer. Riceve una notifica quando un evento si genera
class Observer {
   int calls = 0;
   string message;
   int value;
   // slot, cioe' funzione da chiamare quando si veriica l'evento
   void watch(string msg, int i) {
      this.message = msg;
      this.value = i;
      ++calls;
   }
}

// subject
class Foo {
   private int _value;
   int value() { return _value; }
   int value(int v) {
      if (v != _value) {
         _value = v; // call all the connected slots with the two parameters
         emit("setting new value", v); // e' equivalente a notify
      }
      return v;
   } 

   // Mix in all the code we need to make Foo into a signal 
   mixin Signal!(string, int) valueChanged;
}

@UnitTest
void slot_with_address() {
   Foo a = new Foo;
   Observer o = new Observer;

   a.value = 3; // should not call o.watch()
   o.calls.shouldEqual(0);

   // si passa un puntatore ad una funzione che
   // deve avere la firma dichiaratanel mixin
   a.valueChanged.connect(&o.watch); // o.watch is the slot
   a.value = 4; // should call o.watch()
   o.calls.shouldEqual(1);
   o.value.shouldEqual(4);
   a.disconnect(&o.watch); // o.watch is no longer a slot

   a.value = 5; 
   o.calls.shouldEqual(1);

}
@UnitTest
void slot_with_delegate() {
   Foo a = new Foo;
   Observer o = new Observer;

   void delegate(string m, int i) dg = &o.watch;
   a.valueChanged.connect(dg);

   /*
    * questo:
    * auto dg = delegate(string m, int x) { writeln("cc") };
    * a.cul.connect(dg);
    * non funziona perche:
    * BUGS:
    * Slots can only be delegates formed from class objects or interfaces to class objects.
    */

   a.value = 5; // so should not call o.watch()
   o.calls.shouldEqual(1);
}
