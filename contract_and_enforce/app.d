import std.stdio;
int main(string[] args) {
   
   writeln(enforceInsideIn(-5));
   writeln(assertInsideIn(-6));
   writeln(assertWithoutIn(-7));
   // questo fallisce
   // writeln(enforceWithoutIn(-8));
   
   return 0;
}

import std.exception;
int enforceInsideIn(int x) 
   in {
      enforce(x > 0);
   } body {
      return ++x;
   }


int assertInsideIn(int x) 
   in {
      assert(x > 0);
   } body {
      return ++x;
   }

int enforceWithoutIn(int x)  {
   enforce(x > 0);
   return ++x;
}

int assertWithoutIn(int x)  {
   assert(x > 0);
   return ++x;
}

