import std.stdio;
// http://simpleinjector.codeplex.com/wikipage?title=How-to&referringTitle=Documentation#Register-Factory-Delegates

/**
 * Serve a valutare la fattibilita' un array associativo di delegate
 */
void main() {
   // modo lungo
   IAction delegate()[string] longFactory = ["a": () => new Default(), "b": () => new Order()];

   // oppure piu' brevemente usando alias:
   alias funcReq = IAction delegate();
   funcReq[string] factory = ["a": () => new Default(), "b": () => new Order()];

   factory["a"] // ritorna il delegate
      () // lo esegue e quindi ritorna Default
      .exec(); // esegue default.exec()


   IAction a0 = factory["b"]();
   a0.exec();
   a0.exec();
   assert(a0.count == 2);

   // ogni volta e' tornata un'istanza differente, quindi count e' resettato
   IAction a1 = factory["b"]();
   a1.exec();
   assert(a0.count == 2);
   assert(a1.count == 1);


   /**
    * e' un delegate che accetta int e ritorna void
    */
   alias addDel = void delegate(int);
   auto def = new Default();
   auto ord = new Order();
   addDel[string] addFac = ["a": (i) => def.add(i), "b": (i) => ord.add(i)];
   addFac["a"](42);
   assert(def.count == 42);
   addFac["a"](2);
   assert(def.count == 44);
}

interface IAction {
   @property int count();
   void exec();
   void add(int offset);
}

class Default: IAction {
   private int _count;
   @property int count() { return _count; }
   void exec() {
      _count++;
      writeln("default");
   }

   void add(int offset) {
      _count += offset;
   }
}

class Order: IAction {
   private int _count;
   @property int count() { return _count; }
   void exec() {
      ++_count;
      writeln("order");
   }

   void add(int offset) {
      _count += offset;
   }
}
