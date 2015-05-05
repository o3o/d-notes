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
   assert(w !is null);

   w.setTitle("Plot2Kill test");
   w.addOnHide(delegate void(Widget aux) { exit(0); });

   Button quit = cast(Button)builder.getObject("quit");
   assert(quit !is null);
   quit.addOnClicked((Button aux) => exit(0));

   Button add = cast(Button)builder.getObject("add");
   assert(add !is null);

   EventBox eb = cast(EventBox)builder.getObject("eb");
   assert(eb !is null);
   // Test error bars.
   auto errs = [0.1, 0.2, 0.3, 0.4];
   // usa static opCall...anche se e' deprecato
   LineGraph line0 = LineGraph([1,2,3,4], [1,2,3,8], errs, errs);
   line0.lineColor = getColor(255, 0, 0);

   LineGraph line1 = LineGraph([1,2,3,4], [8,3,2,1]);
   line1.lineColor = getColor(0, 255, 0);

   LineGraph line2 = LineGraph([1,2,3,4], [9,2,3,4]);
   line2.lineColor = getColor(0, 0, 255);

   /*
    * Il construttore di Figure e' scope `package` e quindi non puo'
    * essere chiamato:
    * auto fig = new Figure; ///NON funziona
    * pero Figure ha una `static opCall` che permettono di creare la classe
    * (senza new). L'uso di opCall e' comunque deprecato
    */
   Figure fig = Figure();
   int count = 0;
   auto wid = fig.toWidget();
   eb.add(wid);
   add.addOnClicked(delegate void (Button aux) {
         switch (count) {
            case 0:
               fig.addPlot(line0);
               break;
            case 1:
               fig.addPlot(line1);
               break;
            case 2:
               fig.addPlot(line2);
               break;
            default:
         }
         ++count;
         wid.draw();
         //eb.removeAll();
         //eb.add(wid);
         eb.showAll();
         } );

   fig.title = "Error Bars";

   w.showAll();
   Main.run();

   return 0;
}
