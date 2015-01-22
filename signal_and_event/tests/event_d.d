module tests.event_d;

import unit_threaded;

import std.stdio;
import std.string;
import core.thread;

import events;

class Fun {
   private auto list = new EventList!(void, int);
   private EventList!(void, int).Trigger trigger;
   this() {
      trigger = list.own;
   }

   @property EventList!(void, int) valueChanged() {
      return list;
   }

   private int _value;
   int value() { return _value; }
   int value(int v) {
      if (v != _value) {
         _value = v; // call all the connected slots with the two parameters
         trigger(v);
      }
      return v;
   } 
}

@UnitTest 
void eventlist_embedded_into_class_should_work() {
   int calls = 0;
   int rec = 0;

   Fun fun = new Fun();
   fun.valueChanged.addSync((value) { calls++; rec = value; });

   //! non funziona
   //fun.valueChanged.addSync( (int v) =>  calls++ );

   calls.shouldEqual(0);
   fun.value = 10;
   calls.shouldEqual(1);
   rec.shouldEqual(10);
}

@UnitTest
void fiber_test() {
   auto event = new EventList!(string, int);
   auto trigger = event.own;
   event ^^ (age) {
      return "third age is %d in Fiber %s".format(age, Fiber.getThis);
   };
   auto text = trigger(30);
   text.writeln;
}

@UnitTest
void changed_test() {
   auto event = new EventList!(string, int);
   auto trigger = event.own;
   trigger.changed = (op, item) {
      "%s %s".format(op, item).writeln;
   };
   event ^ (age) {
      return "first age is %d".format(age);
   };
   event ^ (age) {
      return "second age is %d".format(age);
   };
   event.addSync((age) {
         return "third age is %d".format(age);
         });
   auto text = trigger(30);
   text.writeln;
}
