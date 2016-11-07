/**
  replace e' anche pubblicamente importato da string
  */
import std.array : replace;

void main(string[] args) {
   assert("Hello Wörld".replace("o Wö", "o Wo") == "Hello World");
   assert("Hello $(name)".replace("$(name)", "Homer") == "Hello Homer");

   assert("Hello Lisa".replace("$(name)", "cul") == "Hello Lisa");
   string x = "Hello $(name)";
   string y =  x.replace("$(name)", "Homer");

   string a = "Hello $(x) $(y) $(z)";
   string b = a.replace("$(x)", "10").replace("$(y)", "11");

   import std.datetime;
   import std.string;
   DateTime n = DateTime(1999, 7, 6, 9, 7, 5);
   string c = "$(yy)-$(mm)-$(dd) $(yyyy)";
   string d = c.replace("$(yy)", "%02d".format(n.year))
      .replace("$(yyyy)", "%04d".format(n.year))
      .replace("$(mm)", "%02d".format(n.month))
      .replace("$(dd)", "%02d".format(n.day));


   import std.stdio;
   writeln(c, " = ", d);
}
