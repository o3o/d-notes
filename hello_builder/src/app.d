import gtk.Builder;
import gtk.Button;
import gtk.Main;
import gtk.Widget;
import gtk.Window;

import gobject.Type;


import std.stdio;
import std.c.process;

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
      gladefile = "../glade/x1.glade";
   }

   // in gtk.Builder
   Builder builder = new Builder();

   if (!builder.addFromFile(gladefile)) {
      writefln("Oops, could not create Glade object, check your glade file ;)");
      exit(1);
   }

   Window w = cast(Window)builder.getObject("window1");

   if (w !is null) {
      w.setTitle("This is a glade window");
      w.addOnHide(delegate void(Widget aux) {
         exit(0);
      });

      Button b = cast(Button)builder.getObject("button1");
      if (b !is null) {
         b.addOnClicked((Button aux) => exit(0));
         //b.addOnClicked(delegate void(Button aux) {
            //exit(0);
         //});
      }
   } else {
      writefln("No window?");
      exit(1);
   }

   w.showAll();
   Main.run();

   return 0;
}
