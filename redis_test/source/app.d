import std.stdio;
import vibe.d;

void main() {
   auto redis = new RedisClient();
   RedisDatabase db = redis.getDatabase(0);
   RedisReply!string reply = db.lrange!string("map", 0, -1);
   writeln(typeof(reply).stringof);
   writefln("len map  %s", db.llen("map"));
   writefln("len chart %s", db.llen("chart0"));



   foreach (e; reply) {
      writeln(e);
   }
}
