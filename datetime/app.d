//http://forum.dlang.org/post/yfbigktpvhprtxneejyx@forum.dlang.org
//http://forum.dlang.org/post/ip4eab$255p$1@digitalmars.com
import std.stdio;
import std.datetime;
import std.conv;
import std.string;
void main() {
   // Conversione in stringa di SysTime
   //----------------------------------------
   // SysTime rappresenta il tempo attuale del sistema.
   // A differenza di DateTime, la timezone e' parte integrante di SysTime
   // Clock.currTime will return the current time as a SysTime.
   SysTime now = Clock.currTime;
   writeln("With SysTime");
   writeln("----------");
   writeln("now.toUTC         : ", now.toUTC);
   writeln("now.toISOString   : ", now.toISOString);
   writeln("now.toSimpleString: ", now.toSimpleString);
   writeln("now.toString      : ", now.toString);
   writeln("now.toUnixTime    : ", now.toUnixTime);

   // Creazione
   //----------------------------------------
   auto y1 = DateTime(1970, 1, 1, 1, 2, 5); // 3_725 sec  3_725_000
   SysTime s0 = SysTime(DateTime(1970, 1, 1, 0, 0, 0));
   SysTime s1 = SysTime(y1);

   // 37_250_000_000 hn
   long hn = (s1.stdTime - s0.stdTime);
   writefln("3_725s            : %.3e hns, %.3e ns %e us %e ms",  cast(float)hn, hn * 1E-2, hn * 1E-1, hn * 1E-4);


   DateTime n = DateTime(1999, 7, 6, 9, 7, 5);
   string yy = "%d-%d-%d %02d:%02d:%02d".format(n.year, n.month, n.day, n.hour, n.minute, n.second);
   writeln("With format       : ", yy);
   writeln();

   DateTime dt = cast(DateTime)Clock.currTime;
   writeln("With DateTime");
   writeln("----------");
   writeln("dt.toUTC         :  (doesn't exist)");
   writeln("dt.toISOString   : ", dt.toISOString);
   writeln("dt.toSimpleString: ", dt.toSimpleString);
   writeln("dt.toString      : ", dt.toString);
   writeln("dt.toUnixTime    :  (doesn't exist)");
   writeln("dt.year          : ", dt.year);
   writeln();

   writefln("month            : %d", dt.month);
   writefln("month            : %s", dt.month);
   writeln("dt.month         : ", dt.month);
   writeln("dt.minute        : ", dt.minute);

   writeln();

   //http://dlang.org/intro-to-datetime.html
   // calcola utc, quindi per avere la mezzanotte UTC si deve usare l'una
   // italiana
   auto st = SysTime(DateTime(1970, 1, 2, 1, 0, 0));
   writeln("2 gen 1970 1:00 AM   : ", st);
   writeln("to unix time         : ", st.toUnixTime);

   // viceversa
   // sec dall'anno zero
   long stdTime = unixTimeToStdTime(86400);

   writeln("86400s in stdTime: ", stdTime);

   st = SysTime(stdTime);
   writeln("86400s: ", st);
   immutable(TimeZone) tz = TimeZone.getTimeZone("Etc/UCT");
   auto gtm = SysTime(stdTime, tz);
   writeln("GTM 86400s: ", gtm);

   auto x = DateTime(1970, 1, 1, 0, 0, 0) + dur!"seconds"(86400);
   writeln("con somma ", x);

   DateTime nowDt = to!DateTime(now);
   writeln("datetime iso:", nowDt.toISOString());
   writeln("datetime now Simple: ", nowDt.toSimpleString);
   writeln("datetime now tostring: ", nowDt.toString);
}
