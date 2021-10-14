import std.stdio;

void main() {
   //test();
   fun();
   //bar();
}
void test() {
   try {

      scope(exit) writeln("when exiting 1");

      scope(success) {
         writeln("if successful 1");
         writeln("if successful 2");
      }

      scope(failure) writeln("if thrown 1");
      scope(exit) writeln("when exiting 2");
      scope(failure) writeln("if thrown 2");

      throwsHalfTheTime();
   } catch (Exception e) {
      writeln("catch");

   }
}

void throwsHalfTheTime() {
   throw new Exception("Invalid operator");
}

void fun() {
   string msg;
   try {
      /*handle exception*/
      a(false);
      scope (failure)  msg = "A!";
      b(true);
      scope (failure)  msg = "B!";

   } catch (Exception e) {
      writeln(msg);

   }
}

void bar() {
   try {
      a(true);
   } catch (Exception e) {
      writeln("bar A");
   }
}
void a(bool e) {
   if (e) {
      throw new Exception("A operator");
   } else{
      writeln("A");

   }
}

void b(bool e) {
   if (e) {
      throw new Exception("B operator");
   } else {
      writeln("B");

   }
}
