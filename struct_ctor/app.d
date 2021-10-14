import std.stdio;
import foo;

unittest {


   Bar b0 = Bar();
   assert(b0.value == "");
   assert(b0.key == "");

   //Error: struct foo.Bar member _key is not accessible
   //b0._key == "";
}
unittest {
   Bar b = Bar("K");
   b.value = "aaa";
   assert(b.key == "K");
   assert(b.value == "aaa");


   //Error: constructor foo.Fun.this is not callable because it is annotated with @disable
   //Fun f = Fun();
   //
}
unittest {
   Fun f = Fun("x");
   assert(f.value == "a");
   assert(f.key == "x");

   f.value = "b";
   assert(f.value == "b");

}
