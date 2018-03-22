import unit_threaded;
import std.stdio;
import vibe.db.redis.redis;
version (unittest) {
   import unit_threaded;
} else {
/+
void main(string[] args) {
      assert(args.length > 0);

      writeln("USE:", args[1]);

      switch (args[1]) {
         case "0":
            fun0;
            break;
         case "1":
            fun1;
            break;
         case "2":
            fun2;
            break;
         case "3":
            fun3;
            break;
         case "4":
            fun4;
            break;
         default:
            writeln("NO args");
      }
}
+/
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

void fun0() {
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

/**
 * Uso degli hash
 */
void fun1()  {
   auto redis = new RedisClient();
   RedisDatabase db = redis.getDatabase(0);
   db.del("myset");

   //HMSET myhash field1 "Hello" field2 "World"
   db.hmset("myhash", "field1", "Hello",  "field2", "World");

   //HMGET myhash field1 field2 nofield
   string[] f = ["field1",  "field2", "nofiled" ];
   RedisReply!string reply = db.hmget!string("myhash", f);
   foreach (e; reply) {
      writefln("> %s", e);
   }

   //HSET myhash field1 "Hello"
   db.hset("myhash", "field1", "Cul");

   //HGET myhash field1
   string s = db.hget!(string)("myhash", "field1");
   writeln(s);
}

/**
 * Rinominare oggetti
 */
void fun2() {
   auto redis = new RedisClient();
   RedisDatabase db = redis.getDatabase(0);
   db.del("mykey");
   db.hmset("mykey", "field1", "Hello");
   db.rename("mykey", "myotherkey");
   string s0 = db.hget!(string)("myotherkey", "field1");
   string s1 = db.hget!(string)("mykey", "field1");
   assert(s0 == "Hello");
   assert(!s1.length);
   writeln(s0);
}

/**
 * Uso di keys
 */
void fun3() {
   auto redis = new RedisClient();
   RedisDatabase db = redis.getDatabase(0);
   RedisReply!string reply = db.keys!string("chart:0:series:*");
   foreach (e; reply) {
      writefln("> %s", e);
   }
}


/**
 * Elencare tutti i field di una hash
 */
@("fun4")
void fun4() {
   auto redis = new RedisClient();
   RedisDatabase db = redis.getDatabase(0);
   db.del("myset");

   //HMSET myhash field1 "Hello" field2 "World"
   db.hmset("myhash", "key", "K1", "field2", "World");
   db.hmset("myhash", "key", "K8", "field2", "World");
   db.hmset("myhash", "key", "K9", "field2", "World");
}

@("hgetall")
unittest {
   auto redis = new RedisClient();
   RedisDatabase db = redis.getDatabase(0);

   //HMSET myhash field1 "Hello" field2 "World"
   db.hmset("hh", "field1", "Hello",  "field2", "World", "fint", 1);
   RedisReply!string reply = db.hgetAll("hh");
   while (!reply.empty) {
      string k = reply.front;
      reply.popFront;
      string v = reply.front;
      reply.popFront;
      writefln("k: %s v:%s", k, v);
   }
   db.del("hh");
}

@("copy")
unittest {
   import std.array : array;
   import std.string;
   auto redis = new RedisClient();
   RedisDatabase db = redis.getDatabase(0);
   db.hmset("hh", "field1", "Hello",  "field2", "World", "fint", 1);

   RedisReply!string reply = db.hgetAll("hh");
   db.hmset("c%s".format("c"), reply.array());

   foreach (e; db.hgetAll!string("cc")) {
      writefln("> %s", e);
   }

   db.del("hh");
   db.del("cc");
}

@("copy2")
unittest {
   import std.array : array;
   import std.string;
   auto redis = new RedisClient();
   RedisDatabase db = redis.getDatabase(0);
   db.del("hh");
   RedisReply!string reply = db.hgetAll("hh");
   writeln(reply.empty);

   //db.hmset("cc", reply.array());
}

@("ex")
unittest {
   import std.array : array;
   import std.string;
   auto redis = new RedisClient();
   RedisDatabase db = redis.getDatabase(0);
   db.lpush("ee", "a");
   db.lpush("ee", "b");
   db.lpush("ee", "c");
   db.existsInList("ee", "a").shouldBeTrue;
   db.existsInList("ee", "b").shouldBeTrue;
   db.existsInList("ee", "bc").shouldBeFalse;
   db.existsInList("ee", "bc").shouldBeFalse;
   db.existsInList("", "b").shouldBeFalse;
   db.del("ee");
}

private bool existsInList(RedisDatabase db, string list, string el) {
   bool ex;
   if (list.length) {
      RedisReply!string reply = db.lrange(list, 0, -1);
      foreach (e; reply) {
         if (e == el) {
            ex = true;
            break;
         }
      }
   }
   return ex;
}

@("copylist")
unittest {
   import std.array : array;
   import std.string;
   auto redis = new RedisClient();
   RedisDatabase db = redis.getDatabase(0);
   db.del("lll");
   db.del("cul");

   db.lpush("lll", "a");
   db.lpush("lll", "b");
   db.lpush("lll", "c");

   db.copyList("lll", "cul");
}

private void copyList(RedisDatabase db, string src, string dst) {
   auto list = db.lrange(src, 0, -1);
   foreach (l; list) {
      db.rpush(dst, l);
   }
}

@("inc")
unittest {
   import std.array : array;
   import std.string;
   auto redis = new RedisClient();
   RedisDatabase db = redis.getDatabase(0);
   //.b.del("ii");
   db.set!long("ii", 10);
   db.incr("ii");
   db.get!long("ii").shouldEqual(11);
   db.del("ii");
}

