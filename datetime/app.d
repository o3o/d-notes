//http://forum.dlang.org/post/yfbigktpvhprtxneejyx@forum.dlang.org
//http://forum.dlang.org/post/ip4eab$255p$1@digitalmars.com
import std.stdio;
import std.datetime;
import std.conv;
import std.string;
void main() {
   SysTime now = Clock.currTime;
   writeln("With SysTime");
   writeln("----------");
   writeln("now.toUTC         : ", now.toUTC);
   writeln("now.toISOString   : ", now.toISOString);
   writeln("now.toSimpleString: ", now.toSimpleString);
   writeln("now.toString      : ", now.toString);
   writeln("now.toUnixTime    : ", now.toUnixTime);
   writefln("now in format    : %.0s", now);

   auto y1 = DateTime(1970, 1, 1, 1, 2, 5); // 3_725 sec  3_725_000
   SysTime s0 = SysTime(DateTime(1970, 1, 1, 0, 0, 0));
   SysTime s1 = SysTime(y1);

   // 37_250_000_000 hn
   long hn = (s1.stdTime - s0.stdTime);
   writefln("%d hn, %f us %f ms",  hn, hn * 1E-1, hn * 1E-4);




   DateTime n = DateTime(1999, 7, 6, 9, 7, 5);
   string yy = "%d-%d-%d:%d".format(n.year, n.month, n.day, n.hour);
   writeln("With format       :", yy);
   writeln();

   DateTime dt = cast(DateTime)Clock.currTime;
   writeln("With DateTime");
   writeln("----------");
   writeln("dt.toUTC         : (doesn't exist)");
   writeln("dt.toISOString   : ", dt.toISOString);
   writeln("dt.toSimpleString: ", dt.toSimpleString);
   writeln("dt.toString      : ", dt.toString);
   writeln("dt.toUnixTime    :(doesn't exist)");
   writeln("dt.year          :", dt.year);
   writefln("month %d", dt.month);
   writeln("dt.month          : ", dt.month);
   writeln("dt.minute         : ", dt.minute);
   writefln("dt in format     : %s", dt);

   writeln();

   //http://dlang.org/intro-to-datetime.html
   // calcola utc, quindi per avere la mezzanotte UTC si deve usare l'una
   // italiana
   auto st = SysTime(DateTime(1970, 1, 2, 1, 0, 0));
   writeln("3-1-1970: ", st);
   writeln("to unix time:", st.toUnixTime);

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
