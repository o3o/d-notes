import std.stdio;
import unixtime : UnixTime, UnixTimeHiRes;
import std.datetime;

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

   SysTime now = Clock.currTime;
   auto ut0 = SysTime(DateTime(1970, 1, 1, 0, 0, 0)).stdTime;
   enum HNS_TO_MS = 1E-7;
   long time = cast(long)((now.stdTime - ut0) * HNS_TO_MS); // sono hnsec cioe' centinaia di nsec (1 = 100ns)
   UnixTime ut = UnixTime.now;
   writefln("UT %s my %s diff %s", ut.seconds , time, ut.seconds  - time);
}
