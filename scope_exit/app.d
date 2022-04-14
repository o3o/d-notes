import std.stdio;
/+
void main() {
   test();
   test();
   //fun();
   //bar();
}
+/

/**
 * tratto dal libro di Ali
 * http://ddili.org/ders/d.en/scope.html
 */
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

/**
 * Esperimenti con scope(failure)
 *
 *
 */
void fun() {
   string msg;
   try {
      a(false);
      scope (failure) msg = "A!";
      b(true);
      scope (failure)  msg = "B!";

   } catch (Exception e) {
      writeln(msg);
   }
}
// il comportamento dello scope dipende dalla posizione?
string bar0() {
   string msg = "0";
   scope (failure) msg = "1!";
   raiseExc(true, "A");
   return msg;
}

unittest {
   writeln(bar0);
}

/**
 * Genera una eccezione se raise e' true
 */
void raiseExc(bool raise, string msg) {
   if (e) {
      throw new Exception(msg);
   }
}

void b(bool e) {
   if (e) {
      throw new Exception("B operator");
   } else {
      writeln("B");
   }
}
