import std.conv : parse;
import std.string : munch;

void main(string[] args) {
   // Convertire una stringa in numero
   //----------------------------------------
   string test = "123";
   assert(parse!uint(test) == 123);
   // non si puo' fare
   //assert(parse!uint("123") == 123);


   // anche questo genera  errore:
   // test = "  123  ";
   // assert(parse!uint(test) == 123);

   test = "123  ";
   assert(parse!uint(test) == 123);

   test = "19.64";
   assert(parse!double(test) == 19.64);
   // la variabile stringa e' `mangiata`, si deve quindi riassegnarla
   assert(test.length == 0);

   test = "  \t 19.64  \txx";
   munch(test, " \t\n\r"); // skip ws
   assert(parse!double(test) == 19.64);
   // in questo caso sono rimaste delle briciole
   assert(test.length > 0);



   test = "19.64";
   assert(parse!int(test) == 19);



   // Convertire una stringa in bool
   //----------------------------------------
   test = "true";
   assert(parse!bool(test));
   test = "false";
   assert(!parse!bool(test));

   // non si puo fare
   //test = "cul";
   //assert(!parse!bool(test));
   //test = "0";
   //assert(!parse!bool(test));


   // se la stringa non e' convertibile si genera errore ConvException
   import std.stdio;
   test = "true";
   try {
      int x = parse!int(test);
   } catch (std.conv.ConvException e) {
      writeln(e.msg);
   } catch (Exception e) {
      writeln(e);
   }
}
