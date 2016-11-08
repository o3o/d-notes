import std.datetime;
import std.stdio;

void main(string[] args) {
   StopWatch sw;
   // Avvio
   //----------------------------------------
   // Avviare piu' volte non genera problemi.
   // In realta' nel codice di phobos c'e' un assert che verifica se start e' chiamato piu'
   // volte, ma prob. phobos e' compilato coem release e l'assert eliminato

   sw.start();
   sw.start();
   sw.start();
   auto t1 = sw.peek();
   sw.stop();
   TickDuration t2 = sw.peek();
   TickDuration t3 = sw.peek();
   assert(t1 <= t2);
   assert(t2 == t3);

   writefln("%s sec, %s msec %s", t1.seconds, t1.msecs, typeid(t1.seconds));

   // Leggere il tempo
   //----------------------------------------
   // Peek ritorna TickDuration che ha le funzioni seconds e msecs che ritornano long
   StopWatch wait;
   writeln("before start: ", wait.peek.msecs);
   writeln("clock: ", Clock.currTime);

   wait.start();
   int max = 1;
   while (wait.peek.seconds < max) {
      //writeln(wait.peek.seconds);
   }
   wait.stop();
   writeln("clock: ", Clock.currTime);
   writeln("after stop: ", wait.peek.msecs);
   wait.reset();
   writeln("after reset: ", wait.peek.msecs);


   // Reset
   //----------------------------------------
   // Per eseguire il reset e' necessario lo stop
   // Se si esegue il reset senza stop l'asserzione sotto fallisce
   sw.start();
   sw.stop();
   sw.reset();
   // senza stop queste asserzioni falliscono:
   assert(sw.peek().to!("seconds", real)() == 0);
   assert(sw.peek().msecs == 0);

   // si puo' cmq eseguire il reset anche senza start
   sw.reset();
   assert(sw.peek().msecs == 0);
   assert(sw.peek().seconds == 0);


   StopWatch sw1 = StopWatch(AutoStart.yes);
   assert(sw1.running);

   // non compilabile:
   //import std.typecons : Flag, Yes, No;
   //StopWatch sw2 = StopWatch(Yes.autoStart);
   //assert(sw2.running);
   //StopWatch sw3 = Yes.autoStart;
   //assert(sw3.running);
}
