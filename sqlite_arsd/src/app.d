import std.stdio;
import std.conv;
import arsd.sqlite;
struct At {
   long id;
   string name;
   string surname;
   int yob; // year of birth
}

void main() {
   Database db = new Sqlite("../db/ldg.sqlite");
   ResultSet result = db.query("select id, name, surname, year_of_birth from
         athlete limit 2;");

   foreach(Row line; result) {
      writefln("%s %s", line[0], line["name"]);
      At a = At();
      a.id = to!(long)(line["id"]);
      a.name = to!string(line["name"]);
      // notazione postfissa
      a.surname = line["surname"].to!string();
      a.yob = to!int(line["year_of_birth"]);
      writeln(a);
      writeln("ToAA       : ",line.toAA); // restituisce una hash column:value
      writeln();
   }
}	
