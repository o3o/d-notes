import std.stdio;
import std.variant;

import pegged.grammar;



mixin(grammar(`
Logic:
    Term     < Factor (OrExp)*
    OrExp    < "||" Factor
    Factor   < Primary (AndExp)*
    AndExp   < "&&" Primary
    Primary  < Parens / Neg / Literal/ Variable
    Parens   < :"(" Term :")"
    Neg      < "!" Primary
    Literal  < "false" / "true"
    Variable <- identifier
`));

void main() {
   /*
   mixin(grammar(`
      Logic:
         Term <- OrExpr
         OrExpr  <- AndExpr ("||" AndExpr)*
         AndExpr <- NotExpr ("&&" NotExpr)*
         NotExpr <- "!"? Primary
         Primary <- identifier
         `));
         */
   ParseTree parseTree = Logic("A||B");
   assert(parseTree.name == "Logic");

   writeln(parseTree.children[0].name);
   Parm[string] buf;
   buf["a"] = true;
   buf["b"] = false;
   buf["c"] = true;
   writeln("a ", interpreter("a", buf));
   writeln("a && false ", interpreter("a && false", buf));
   writeln("b && false ", interpreter("b && false", buf));
   writeln("b ", interpreter("b", buf));
   writeln("!a ", interpreter("!a", buf));
   writeln("!b ", interpreter("!b", buf));
   writeln("a||b ", interpreter("a || b", buf));
   writeln("a&&b ", interpreter("a&&b", buf));
   writeln("a&&b ", interpreter("a && b", buf));
   writeln("a && (b || c) ", interpreter("a && (b || c", buf));
   buf["b"] = true;
   writeln("a&&b ", interpreter("a && b", buf));


}



alias Parm = Algebraic!(bool, int, double, string);

bool interpreter(string expr, Parm[string] buffer) {
    auto p = Logic(expr);

    //writeln(p);

    bool value(ParseTree p) {
        switch (p.name) {
            case "Logic":
                return value(p.children[0]);
            case "Logic.Term":
                bool v = false;
                foreach(child; p.children) {
                   v |= value(child);
                }
                return v;
            case "Logic.OrExp":
                return value(p.children[0]);
            case "Logic.Factor":
                bool v = true;
                foreach(child; p.children) {
                   v &= value(child);
                }
                return v;
            case "Logic.AndExp":
                return value(p.children[0]);
            case "Logic.Primary":
                return value(p.children[0]);
            case "Logic.Parens":
                return value(p.children[0]);
            case "Logic.Neg":
                return !value(p.children[0]);
            case "Logic.Literal":
                return p.matches[0] == "true" ? true : false;
            case "Logic.Variable":
                return buffer[p.matches[0]].get!bool;
            default:
                return false;
        }
    }
    return value(p);
}
