import std.datetime: Clock;
import std.datetime.stopwatch;
import std.stdio;
import core.thread;

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
   Duration t1 = sw.peek();
   sw.stop();

   Duration t2 = sw.peek();
   Duration t3 = sw.peek();
   assert(t1 <= t2);
   assert(t2 == t3);

   // Leggere il tempo
   //----------------------------------------
   // Peek ritorna Duration che ha la funzione total
   StopWatch wait;
   writefln("before start: %s ms clock: %s", wait.peek.total!"msecs", Clock.currTime);

   wait.start();
   Thread.sleep(seconds(1));

   wait.stop();
   writefln("after stop start: %s ms clock: %s", wait.peek.total!"msecs", Clock.currTime);
   wait.reset();
   writefln("after reset: %s", wait.peek.total!"msecs");


   // Reset
   //----------------------------------------
   // Per eseguire il reset e' necessario lo stop
   // Se si esegue il reset senza stop l'asserzione sotto fallisce
   StopWatch sw1;
   sw1.start();
   sw1.stop();
   sw1.reset();
   // senza stop queste asserzioni falliscono:
   assert(sw1.peek().total!"seconds" == 0);
   assert(sw1.peek().total!"msecs" == 0);


   // si puo' cmq eseguire il reset anche senza start
   sw1.reset();
   assert(sw1.peek().total!"msecs" == 0);
   assert(sw1.peek().total!"seconds" == 0);



   //si puo' eseguire il resert senza stop, ma il timer continua
   /+
      StopWatch sw2 = StopWatch(AutoStart.yes);
   assert(sw2.running);
   Thread.sleep(seconds(1));

   writeln();
   writeln("Reset without stop");
   writefln("Before reset %s ms", sw2.peek.total!"msecs");
   sw2.reset;
   assert(sw2.peek().total!"msecs" < 1);
   writefln("After reset  %s ms", sw2.peek.total!"msecs");
   Thread.sleep(msecs(2));
   writefln("After 2ms  %s ms", sw2.peek.total!"msecs");
   +/

      // non compilabile:
      //import std.typecons : Flag, Yes, No;
      //StopWatch sw2 = StopWatch(Yes.autoStart);
      //assert(sw2.running);
      //StopWatch sw3 = Yes.autoStart;
      //assert(sw3.running);
      //
      DoubleStopWatch dsw;
   dsw.startOn;
   assert(dsw.on.running);
   Thread.sleep(seconds(1));

   writeln();
   writeln("DSW reset without stop");
   writefln("DSW before reset %s ms", dsw.on.peek.total!"msecs");
   StopWatch on = dsw.on;
   writefln("dws.on ptr %s", &on);

   dsw.on.reset;
   writefln("DSW after reset  %s ms", dsw.on.peek.total!"msecs");
   assert(dsw.on.peek().total!"msecs" < 1);
   Thread.sleep(msecs(2));
   writefln("DSW after 2ms  %s ms", dsw.on.peek.total!"msecs");
}


struct DoubleStopWatch {
   import std.datetime.stopwatch : StopWatch, AutoStart;

   private StopWatch _watchOn = StopWatch(AutoStart.no);
   ref StopWatch on() {
      writefln("_watchOn ptr %s", &_watchOn);
      return _watchOn;
   }

   private StopWatch _watchOff = StopWatch(AutoStart.no);
   ref StopWatch off() {
      return _watchOff;
   }

   void startOn() {
      if (!_watchOn.running) {
         _watchOn.start();
      }
      if (_watchOff.running) {
         _watchOff.stop();
      }
   }

   void startOff() {
      if (!_watchOff.running) {
         _watchOff.start();
      }
      if (_watchOn.running) {
         _watchOn.stop();
      }
   }

   void resetOff() {
      _watchOff.reset();
   }
}
