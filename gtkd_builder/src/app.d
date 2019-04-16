import gtk.Builder : Builder;
import gtk.Button;
import gtk.Main;
import gtk.Widget;
import gtk.Window;
import gtk.ApplicationWindow;

import gobject.Type;
import std.stdio;
//import std.c.process;

/**
 * Usage ./builder /path/to/your/glade/file.glade
 */
int main(string[] args) {
   string gladefile;
   // in gtk.Main.d
   Main.init(args);

   if (args.length > 1) {
      writefln("Loading %s", args[1]);
      gladefile = args[1];
   } else {
      writefln("No glade file specified, using default \"../glade/x1.glade\"");
      gladefile = "./glade/x1.glade";
   }

   // in gtk.Builder
   Builder builder = new Builder();

   if (!builder.addFromFile(gladefile)) {
      writefln("Oops, could not create Glade object, check your glade file ;)");
      exit(1);
   }
   auto w = new View(builder);
   w.show();
   Main.run();

   return 0;
}

class View {
   private Builder builder;
   private ApplicationWindow main;

   this(Builder builder) {
      assert(builder !is null);
      this.builder = builder;
      main = builder.getW!ApplicationWindow("window1");
      assert(main !is null);

      main.setTitle("This is a glade window");
      main.addOnHide(delegate void(Widget aux) { exit(0); });

      Button b = cast(Button)builder.getObject("button1");
      if (b !is null) {
         b.addOnClicked((Button aux) => exit(0));
      }
   }
   void show() {
      main.showAll();
   }
}

T getW(T)(Builder b, string key) {
   return cast(T)b.getObject(key);
}
