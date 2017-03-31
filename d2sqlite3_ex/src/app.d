import std.stdio;
import std.conv;

import d2sqlite3;
struct At {
   long id;
   string name;
   string surname;
   int yob;
}

void main() {
   Database db = Database("./db/ldg.sqlite");
   ResultRange result = db.execute("select id, name, surname, year_of_birth from athlete limit 4;");

   foreach(Row line; result) {
      // line[0] e' un Column
      writeln(typeof(line[0]).stringof);

      writefln("%s %s %d", line[0], line["name"], line.peek!long(0));

      At a = At();
      a.id = line.peek!long("id");
      a.name = line["name"].as!string;
      a.surname = line["surname"].as!string();
      a.yob = line["year_of_birth"].as!int();
      writeln(a);
   }
}
