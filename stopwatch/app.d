import std.datetime;
import std.stdio;

void main(string[] args) {
   StopWatch sw;
   // Avvio
   //----------------------------------------
   // avviare piu' volte non genera problemi
   // in realta' nel codice di phobos c'e un assert che verifica se start e' chaiato piu'
   // volte, ma prob. phobos e' compilato coem release e l;assert eliminato


   sw.start();
   sw.start();
   sw.start();
   auto t1 = sw.peek();
   sw.stop();
   auto t2 = sw.peek();
   auto t3 = sw.peek();
   assert(t1 <= t2);
   assert(t2 == t3);

   writefln("%s sec, %s msec %s", t1.seconds, t1.msecs, typeid(t1.seconds));


   // Reset
   //----------------------------------------
   // Per eseguire il reset e' necessario lo stop
   // Se si esegue il reset senza stop l'asserzione fallisce
   sw.start();
   sw.stop();
   sw.reset();
   assert(sw.peek().to!("seconds", real)() == 0);
   assert(sw.peek().msecs == 0);

   // si puo' cmq eseguire il reset anche senza start
   sw.reset();
   assert(sw.peek().msecs == 0);
   assert(sw.peek().seconds == 0);
}
