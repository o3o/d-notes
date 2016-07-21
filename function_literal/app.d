// vedi http://dlang.org/expression.html#FunctionLiteral
import std.stdio;

void main() {
   how_to_reduce_function_declaration();
   how_to_reduce_delegate_declaration();

   // Assegnazione ad una function pointer
   //----------------------------------------
   // dichiarazione lunga:
   //int function(char c) fp;
   // oppure piu' breve:
   int function(char) fp;

   // assegnazione con lambda estesa
   fp = function int (char c) { return 6; };
   assert(fp('a') == 6);

   // con lambda breve
   fp = (char c) =>  7;
   assert(fp('a') == 7);

   // con indirizzo di una funzione non inner
   fp = &cul;
   assert(fp('a') == 64);

   // Assegnazione di un delegate
   //----------------------------------------
   int delegate() dg;
   // in modo esteso
   dg = delegate int () { return 42; };
   assert(dg() == 42);
   dg = delegate () { return 43; };
   assert(dg() == 43);
   // con blocco
   dg = { return 44; };
   assert(dg() == 44);
   // con lambda
   dg = () => 45;
   assert(dg() == 45);


   // Passaggio di un delegate
   //----------------------------------------
   int x = 100;
   // e' una inner function
   void myDel() { writeln(x); }
   // & ritorna un delegate
   proxy(&myDel);
   // passando il blocco di codice
   proxy( { writeln(x); });
   // con lambda
   proxy( delegate () => writeln(x));

   // Esempi da parker
   // Innner function
   //----------------------------------------
   // Questa e' un inner function
   void myFunc(int x) { writeln(x); }

   // l'istruzione seguente genera errore perche' l'indirizzo di un inner function non genera un function pointer, ma un delegate:
   // void function(int) funcPtr = &myFunc;

   // questa invece si compila
   void delegate(int) funcPtr = &myFunc;
   funcPtr(22);

   // Literal
   //----------------------------------------
   // Si possono creare function pointer e delegate da literal
   int function(int) fp1 = function int (int i) { return i * 2; };
   void delegate() d1 = delegate void  { writeln(fp1(10)); };

   // si possono anche usare le parentesi
   void delegate() d0 = delegate void () { writeln(fp1(10)); };

   // in forma breve (lambda)
   //........................................
   auto fp2 = function (int i) => i + 1;
   auto d2 = delegate () => "hello";
   string delegate() d3 = delegate () => "hello";

   parker1();
}

int cul(char x) {
   return 64;
}

void proxy(void delegate() dg) { dg(); }

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


void performTest(int a, int b, bool function(int, int) test) {
   writeln("The result is ", test(a, b));
}

void parker1() {
   performTest(1, 2, (a, b) { return a == b; });
   performTest(1, 2, (a, b) => a < b);
   performTest(1, 2, function bool (int a, int b) => a < b);
   performTest(1, 2, &extFunc);
}

bool extFunc(int x, int y) {
   return x == y - 1;
}
