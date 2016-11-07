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
   import std.stdio;
   writeln(x, " = ", y);
}
