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

   RedisLogger logger = new RedisLogger(db);
   writefln("len logger %s", logger.len());
   writefln("len logger %s", logger.length);
}


class RedisLogger {
   private RedisDatabase db;
   this(RedisDatabase db) {
      this.db = db;
   }
   long len() {
      return db.llen("chart0");
   }

   long length() {
      writefln("try to llen");
      long ll = 0;
      try {
         ll = db.llen("");
      } catch (Exception e) {
         writefln(e.msg);
      }
      return ll;
   }
}

