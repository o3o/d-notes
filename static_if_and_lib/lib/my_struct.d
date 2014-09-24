module my_struct;
import std.stdio;

struct MyType(T) {
   static if (is (T == float)) {
      alias ResultType = double;
   } else static if (is (T == double)) {
      alias ResultType = real;
   } else {
      static assert(false, T.stringof ~ " is not supported");
   }

   ResultType doWork()  {
      writefln("The return type for %s is %s.",
            T.stringof, ResultType.stringof);
      ResultType result;
      // ...
      return result;
   }
}

