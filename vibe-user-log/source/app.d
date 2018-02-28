import std.stdio;
import vibe.core.log;
import vibe.db.redis.redis;


void main() {
   setLogLevel(LogLevel.info);
   logInfo("INIT");

   RedisClient redisClient = new RedisClient();
   auto db = redisClient.getDatabase(0);
   auto logger = cast(shared)new RedisLogger(db, "log");
   registerLogger(logger);

   logDiagnostic("diagnosi");
   logInfo("prova con %s", "Format");
   logWarn("warn!");
}

static class TextLogger : Logger {
   string[] lines;
   override void beginLine(ref LogLine msg) { lines.length += 1; }
   override void put(scope const(char)[] text) { lines[$-1] ~= text; }
   override void endLine() { }
}

static class RedisLogger : Logger {
   private RedisDatabase _db;
   private string _name;
   this(RedisDatabase db, string name) {
      _db = db;
      _name = name;
      multilineLogger = true;
   }

   private LogLine logLine;
   override void beginLine(ref LogLine msg) {
      logLine = msg;
   }

   private string lines;
   override void put(scope const(char)[] text) {
      import std.conv;
      lines ~= text.to!string();
   }

   override void endLine() {
      import std.datetime: Clock, SysTime;
      import std.string : format;

      if (logLine.level > LogLevel.diagnostic) {
         immutable(SysTime) tm = Clock.currTime;
         string msg = "[%d-%02d-%02d %02d:%02d:%02d] %s".format(tm.year, tm.month, tm.day, tm.hour, tm.minute, tm.second, lines);
         _db.lpush(_name, msg);
         _db.ltrim(_name, 0, 9);
      }
      lines = "";
      logLine.level = LogLevel.none;
   }
}
