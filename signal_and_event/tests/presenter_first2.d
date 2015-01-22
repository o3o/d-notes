module tests.presenter_first2;
import std.signals;

interface IModel2 {
   void execute(int cmd);
}

interface IView2 {
   void connect(void delegate(int) listener);
   void emit(int i);
}
/**
  Cosi facendo il mixin NON puo' avere nome
  Se si dichiarasse 
     mixin Signal!(int) foo;
  cosa di dovrebbe  scrivere nell'interfaccia?
*/
class View2: IView2 {
   mixin Signal!(int);
}


class Presenter2 {
   this(IModel2 model, IView2 view) {
      view.connect(&model.execute);
   }
}



