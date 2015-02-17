//http://forum.dlang.org/post/yfbigktpvhprtxneejyx@forum.dlang.org

import std.stdio;
import std.datetime;
void main() {
   SysTime now = Clock.currTime; 
   writeln("now: ", now);
   writeln("now utc: ", now.toUTC);
   writeln("now ISO: ", now.toISOString);
   writeln("now Simple: ", now.toSimpleString);
   writeln("now tostring: ", now.toString);

   writeln("now unix time:", now.toUnixTime);
   //http://dlang.org/intro-to-datetime.html

   // calcola utc, quindi per avere la mezzanotte UTC si deve usare l'una
   // italiana
   auto st = SysTime(DateTime(1970, 1, 2, 1, 0, 0));
   writeln("3-1-1970: ", st);
   writeln("to unix time:", st.toUnixTime);

   // viceversa
   auto stdTime = unixTimeToStdTime(86400);
   st = SysTime(stdTime);
   writeln("86400s: ", st);

}
