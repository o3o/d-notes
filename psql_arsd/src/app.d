import std.stdio;
import std.random;
import std.conv;
import std.string;

import arsd.postgres;
void main() {
   writeln("START");
   
   //http://www.postgresql.org/docs/9.2/static/libpq-connect.html#LIBPQ-CONNSTRING
   //string conn  = "host=192.168.221.1 port=5432 user=postgres password=postgres dbname=egbert connect_timeout=10";
   version(linux) {
      string conn = "host=localhost port=5432 user=postgres password=postgres dbname=ldg connect_timeout=10";
   }
   version(Windows) {
      string conn = "host=192.168.0.10 port=5432 user=postgres password=postgres dbname=ldg connect_timeout=10";
   }
   auto db = new PostgreSql(conn);

   foreach(Row line; db.query("SELECT * FROM athlete;")) {
      writeln(line.toAA); // restituisce una hash column:value
      writeln(line[0], line["id"]);
   }
}
