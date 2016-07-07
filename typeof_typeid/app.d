/import std.stdio;

/* # typeid
 * Da TDPL pag. 32:
 * > The typeid(T) primary expression returns information about the type T
 * e poi a pag 37:
 * > The built-in operator typeof fetches the type of an expression, and typeid makes
 * > that type into a printable string.
 * typeid ritorna una classe TypeInfo
 *
 * # typeof
 * Da http://dlang.org/declaration.html:
 * > Typeof is a way to specify a type based on the type of an expression
 */
void main() {
   writeln("typeid int:", typeid(int)); //=> typeid int:int

   // non si puo' fare:
   // writeln("typeof int:", typeof(int));

   int x = 10;
   writeln("typeid x:", typeid(x)); //=> typeid x:int
   writeln("===class===");

   Label label = new Label();
   writeln("typeid label:", typeid(label)); //=> app.Label
   writeln("size label:", typeid(label).tsize); //=> 8
   writeln("class info:", label.classinfo); //=>  app.Label
   writeln("class info name:", label.classinfo.name); //=> app.Label
   writeln("tostring label:", label.toString()); //=> app.Label

   // non si puo' fare:
   // writeln("typeof x:", typeof("aa"));

   writeln("typeid(typeof(x)):", typeid(typeof(x))); //=> typeid(typeof(x)):int
   // non si puo' fare:
   //writeln("x.typeof.typeid", x.typeof().typeid());

   typeof(3 + 6.0) y; // y is of type double

   writeln("typeid y:", typeid(y)); //typeid y:double
   // verifica del tipo
   Label labelA = new Label();
   writeln(is (labelA == label));


}
class Label{}

