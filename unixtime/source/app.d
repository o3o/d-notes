import std.stdio;
import unixtime : UnixTime, UnixTimeHiRes;

void main() {
   // attendere un tempo
   // ------------------

   // secondi
   UnixTime a = UnixTime(500) + UnixTime(250); // UnixTime(750)
   writeln(a.seconds);

   UnixTimeHiRes s = UnixTimeHiRes.now + UnixTime(5);
   writeln(UnixTime.now);

   writeln("s", s.seconds);
   writeln("ns ", s.nanos);
}
