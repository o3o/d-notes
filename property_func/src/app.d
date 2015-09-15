import std.stdio;

void main() {
   Ex ex = new Ex();
   writeln(ex.getName());

   ex.render!("A:");
   render!("B:")(ex);
   render!("C:") = ex;

   ex.reso();
   ex.reso;
   reso(ex);
   //reso() = ex; non valido!!
   reso = ex;
}

class Ex {
   string getName() {
      return "Ex";
   }
}

void render(string prefix)(Ex res) @property {
   writeln(prefix, res.getName());
}

void reso(Ex res) @property {
   writeln("::", res.getName());
}
