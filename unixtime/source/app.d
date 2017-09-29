import std.stdio;
import unixtime : UnixTime, UnixTimeHiRes, ClockType;
import std.datetime;

void main() {
   // attendere un tempo
   // ------------------

   // secondi
   UnixTime a = UnixTime(500) + UnixTime(250); // UnixTime(750)
   writefln("500 + 200 = %s", a.seconds);

   UnixTimeHiRes s = UnixTimeHiRes.now + UnixTime(5);
   writefln("now %s", UnixTime.now(ClockType.REALTIME));

   //writeln("s", s.seconds);
   writeln("ns ", s.nanos);

   SysTime now = Clock.currTime;
   auto ut0 = SysTime(DateTime(1970, 1, 1, 0, 0, 0)).stdTime;
   enum HNS_TO_MS = 1E-7;
   long time = cast(long)((now.stdTime - ut0) * HNS_TO_MS); // sono hnsec cioe' centinaia di nsec (1 = 100ns)
   UnixTime ut = UnixTime.now(ClockType.REALTIME);
   auto uth = UnixTimeHiRes.now;
   writefln("UT HI %s s %s ms %s ns", uth.seconds ,  uth.seconds * 1000, uth.nanos);
   writefln("UT    %s s %s ms", ut.seconds ,  ut.seconds * 1000);
   writefln("UT %s my %s diff %s", ut.seconds , time, ut.seconds  - time);
}
