module hello;

private import gtk.MainWindow;
private import gtk.Label;
private import gtk.Main;

class HelloWorld: MainWindow {
   this() {
      super("GtkD");
      setBorderWidth(10);
      add(new Label("Hello World"));
      showAll();
   }
}

void main(string[] args) {
   Main.init(args);
   new HelloWorld();
   Main.run();
}
