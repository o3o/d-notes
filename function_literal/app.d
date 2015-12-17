// vedi http://dlang.org/expression.html#FunctionLiteral
import std.stdio;

void main() {
   how_to_reduce_function_declaration();
   how_to_reduce_delegate_declaration();

   auto i = 3;
   auto twice  = function (int x) => x * 2;
   auto square = delegate (int x) => x * x;

   auto n = 5;
   auto mul_n = (int x) => x * n;

   writeln(twice(i));   // prints 6
   writeln(square(i));  // prints 9
   writeln(mul_n(i));   // prints 15

   // dichiarazione lunga:
   //int function(char c) fp;
   // oppure piu' breve:
   int function(char) fp;

   fp = function int (char c) { return 6; };
   writeln(fp('a'));   // prints 6

   fp = (char c) =>  7;
   writeln(fp('a'));   // prints 7

   fp = &cul;
   writeln(fp('a'));   // prints 64
}

int cul(char x) {
   return 64;
}

void how_to_reduce_function_declaration() {
   double function(int) f0 = function double(int x) { return x /10.; };
   double function(int) f1 = function       (int x) { return x /10.; };
   double function(int) f2 =                (int x) { return x /10.; };
   double function(int) f3 =                    (x) { return x /10.; };
   double function(int) f4 =                    (x) => x /10.; 
   writeln("f0", f0(5));
   writeln("f1", f1(5));
   writeln("f2", f2(5));
   writeln("f3", f3(5));
   writeln("f4", f4(5));
}

void how_to_reduce_delegate_declaration() {
   double delegate(int) df0 = delegate double(int x)  { return x /10.; };
   double delegate(int) df1 = delegate (int x)  { return x /10.; };
   double delegate(int) df2 =  (int x) { return x /10.; };
   double delegate(int) df3 =  (x) { return x /10.; };
   double delegate(int) df4 =  (x) => x /10.; 
   writeln("df0", df0(5));
   writeln("df1", df1(5));
   writeln("df2", df2(5));
   writeln("df3", df3(5));
   writeln("df4", df4(5));
}

