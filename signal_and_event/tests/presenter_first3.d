module tests.presenter_first3;

import std.event;

interface IModel3 {
   void execute(int cmd);
}

interface IView3 {
   void delegate(int i) executeRequested;
}

class View3: IView3 {
   Event!(void delegate(int i)) executeRequested;
}


class Presenter3 {
   this(IModel3 model, IView3 view) {
      view.executeRequested ~= &model.execute;
   }
}
