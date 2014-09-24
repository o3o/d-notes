// compilare con dmd *.d
import std.conv;
import std.stdio; 

void main(string[] args) {
   void[] voidarr;
   writeln("void[] has type: ", typeof(voidarr).stringof);

   void* voidptr;
   writeln("void* has type: ", typeof(voidptr).stringof);
   writeln("void* has size: ", typeof(voidptr).sizeof);
   
   int[] inta = [1,2,3];
   voidptr = cast(void*)inta;
   writeln("cast int array to void* has type: ", typeof(voidptr).stringof);

   char a = 'x';
   writeln("a is:", a);
   increase(&a, a.sizeof);
   writeln("after increase a is:", a);
   
   writeln();

   int b = 1602;
   writeln("b is:", b);
   increase(&b, b.sizeof);
   writeln("after increase b is:", b);
   writeln();

   int[] ar = [10, 20, 30];

   writeln("print array ", ar);
   printWithPointer(ar.ptr, 3);
}

void printWithPointer(void* data, int length) {
   int* pint = cast(int*)data;
   for (int i = 0; i < length; ++i) {
      writefln("[%s] %d", i, *pint);
      //writeln(*pint);
      ++pint;
   }
}

void increase(void* data, int psize) {
   writeln("pointer size is ", typeof(data).sizeof);

   if (psize == char.sizeof) { 
      char* pchar; 
      // converte un punt. a void in uno a char
      pchar = cast(char*)data;
      ++(*pchar);
   } else if (psize == int.sizeof ) { 
      int* pint; 
      pint=cast(int*)data;
      ++(*pint); 
   }
}
