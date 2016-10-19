import std.conv;
import std.string;
void main(string[] args) {
   string s = "19.64";
   double x = to!(double)(s);
   assert(x == 19.64);
   assert("19.64".to!double == 19.64);
//+9.91000000E+37 NAN,0000,00,00,00,00,00.000,0000,0
   assert("000".to!double == 0.);
   assert("0.00".to!double == 0.);
   assert("+9.91000000E+37".to!double == +9.91000000E+37);
   assert("NAN".to!double is double.nan);
   assert("nan".to!double is double.nan);

   string w = "   19.64   ";
   assert(w.strip.to!double == 19.64);

   string sc = "+9.91000000E+37 NAN,0000,00,00,00,00,00.000,0000,0";
   assert(sc.parse!double == +9.91000000E+37);

}
