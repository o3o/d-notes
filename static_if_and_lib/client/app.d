import my_struct;
void main() {
   auto f = MyType!float();
   f.doWork();

   auto d = MyType!double();
   d.doWork();
   version(bug) {
      // questo genera un errore di compialzione perche' int non e' previsto in
      // my_struct
      auto i = MyType!int();
   }


}
