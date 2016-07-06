import std.stdio;

class Clock {
    void reset() {} // public
    protected void start( ) {}
    private void  stop();
    final void ring();
}

class Alarm: Clock {
   override void reset() {
      writeln("alarm reset");
   }
   override void start() {
      writeln("alarm start");
   }
   /* ERRORE
   override void stop() {
      writeln("alarm stop");
   }
   */
   /* ERRORE
   override void ring() {
      writeln("alarm start");
   }
   */

}

void main(string[] args) {
   auto a = new Alarm();
   a.start();
   a.reset();

}
