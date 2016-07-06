// dmd app.d -of s
import std.algorithm.sorting: sort;
import std.file: dirEntries, SpanMode, DirIterator;
import std.stdio;
import std.array;

void main(string[] args) {
   string dir = "./json";
   auto files = dirEntries(dir, "*.json", SpanMode.shallow);
   writeln(typeof(files).stringof);

   string[] names;
   foreach(s; files) {
      writeln(s.name);
      names ~= s.name;
   }
   auto ff = sort(names);

   writeln("================");

   //auto ff = .sort!((a,b) => a.name < b.name);
   //auto sorted = sort!("a < b")(files.array);
   foreach(s; ff) {
      writeln(s);
   }

   writeln("================");
   auto files2 = dirEntries(dir, "*.json", SpanMode.shallow).array().sort!((a, b) => a.name < b.name);
   foreach(s; files2) {
      writeln(s);
   }

}
