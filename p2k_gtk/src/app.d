import gtk.Builder;
import gtk.Button;
import gtk.Main;
import gtk.Widget;
import gtk.EventBox;
import gtk.Window;
import gtk.Dialog;
import gtk.Label;
import gtk.DrawingArea;

import gobject.Type;

import std.stdio;
import std.concurrency;
import std.c.process;
import plot2kill.all;
//import plot2kill.util;

/**
 * Usage ./builder /path/to/your/glade/file.glade
 */
int main(string[] args) {
   string gladefile;

   Main.init(args);
   if (args.length > 1) {
      writefln("Loading %s", args[1]);
      gladefile = args[1];
   } else {
      writefln("No glade file specified, using default \"main.glade\"");
      gladefile = "main.glade";
   }

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
      }

      EventBox eb = cast(EventBox)builder.getObject("eb");

      // Test error bars.
      auto errs = [0.1, 0.2, 0.3, 0.4];
      // usa static opCall...anche se e' deprecato
      LineGraph linesWithErrors = LineGraph([1,2,3,4], [1,2,3,8], errs, errs);
      linesWithErrors.lineColor = getColor(255, 0, 0);

      LineGraph line2 = LineGraph([1,2,3,4], [8,3,2,1]);
      line2.lineColor = getColor(0, 255, 0);

      /*
       * Il construttore di Figure e' scope `package` e quindi non puo'
       * essere chiamato:
       * auto fig = new Figure; ///NON funziona
       * pero Figure ha una `static opCall` che permettono di creare la classe
       * (senza new). L'uso di opCall e' comunque deprecato
       */

      Figure fig = Figure(linesWithErrors, line2);

      fig.title = "Error Bars";
      auto wid = fig.toWidget();
      eb.add(wid);
   } else {
      writefln("No window?");
      exit(1);
   }

   w.showAll();
   Main.run();

   return 0;
}
