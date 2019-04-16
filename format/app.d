/**
http://dlang.org/phobos/std_format.html#formattedWrite

la stringa di formattazione e' definita:
```
FormatString:
    FormatStringItem*
FormatStringItem:
   '%%'
   '%' Position Flags Width Precision FormatChar
Position:
    empty
    Integer '$'
Flags:
    empty
    '-' Flags
    '+' Flags
    '#' Flags
    '0' Flags
    ' ' Flags
Width:
    empty
    Integer
    '*'
Precision:
    empty
    '.'
    '.' Integer
    '.*'+
FormatChar:
    's'|'c'|'b'|'d'|'o'|'x'|'X'|'e'|'E'|'f'|'F'|'g'|'G'|'a'|'A'
```
quindi FormatChar deve essereci
*/
import std.stdio;
import std.string: format;


void main(string[] args) {
   double x = 19.6432132231132;
   int i = 42;
   string s = "cul";
   // Precision
   // -----------
   //Flags:empty Width:empty Precision:3 FormatChar:f
   assert("%.3f".format(x) == "19.643");

   // Flag #
   // -----------
   // il flag # mette sempre il punto decimale
   //Flags:# Width:empty Precision:0 FormatChar:f
   assert("%#.0f".format(3.) == "3.");
   assert("%#.1f".format(3.) == "3.0");
   //Flags:empty Width:empty Precision:0 FormatChar:f
   assert("%.0f".format(3.) == "3");

   // Width
   // -----------
   // width indica la lunghezza mimima
   //Flags:empty Width:4 Precision:empty FormatChar:d
   assert("%4d".format(i) == "  42");
   //Flags:0 Width:4 Precision:empty FormatChar:d
   assert("%04d".format(i) == "0042");
   //Flags:empty Width:4 Precision:3 FormatChar:f
   assert("%4.3f".format(3.14) == "3.140");
   assert("%4.3f".format(3.) == "3.000");
   writeln("%6.3f".format(27.7));
   //assert("%6.3f".format(27.7) == "27.7000");
   // la lunghezza minima del campo e' 6, "3.140"  ha lunghezza 5 quindi si aggiunge uno spazio
   assert("%6.3f".format(3.14) == " 3.140");

   //Flags:0 Width:4 Precision:3 FormatChar:f
   assert("%06.3f".format(3.14) == "03.140");
   assert("%#6.3f".format(3.14) == " 3.140");

   // FormatChar
   // -----------
   // se il dato e' floating point allora e' usato  %g
   assert("%#6.3s".format(3.14) == "  3.14");
   assert("%#6.3g".format(3.14) == "  3.14");


   // Esadecimale
   // -----------
   //Flags:empty Width:empty Precision:empty FormatChar:x
   assert("%x".format(10) == "a");
   assert("%X".format(10) == "A");
   //Flags:# Width:empty Precision:empty FormatChar:x
   assert("%#x".format(10) == "0xa");
   assert("%#X".format(10) == "0XA");
   //writefln("%#6x", 10);
   assert("%#6x".format(10) == "   0xa");

   // Array
   // -----------
   // -----
   int[] arr = [1,2,3];
   assert("array %(%s%)".format(arr) == "array 123");
   assert("array [%(%s, %)]".format(arr) == "array [1, 2, 3]");

   int[] arre = [10,11,20];
   assert("[%(0x%02x, %)]".format(arre) == "[0x0a, 0x0b, 0x14]");
}
