module tests.presenter_first;
import std.signals;

interface IModel {
   void execute(int cmd);
}

interface IView {
   void fire(int cmd);
   void subscribeExecute(void delegate(int) listener);
}

class View: IView {
   void fire(int cmd) {
      executeRequested.emit(cmd);
   }
   void subscribeExecute(void delegate(int) listener) {
      executeRequested.connect(listener);
   }
   mixin Signal!(int) executeRequested;
}


class Presenter {
   this(IModel model, IView view) {
      view.subscribeExecute(&model.execute);
   }
}



