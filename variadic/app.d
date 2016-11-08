//http://dlang.org/variadic-function-templates.html
class Step {
   this(string name) {
      _name = name;
   }


   private string _name;
   @property string name() { return _name; }
   @property void name(string value) { _name = value; }

   private Step[] _subSteps;
   @property Step[] subSteps() { return _subSteps; }

   void add(Step[] steps ...) {
      _subSteps ~= steps;
   }
}

import std.stdio;

void main(string[] args) {
   auto main = new Step("main");
   main.add(new Step("a"));
   assert(main.subSteps.length == 1);

   Step[] ss = [new Step("s1"), new Step("s2"), new Step("s3")];

   main.add(ss);
   assert(main.subSteps.length == 4);

   foreach (s; main.subSteps) {
      writeln(s.name);
   }
}
