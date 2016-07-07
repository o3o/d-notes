enum Suit { spades, hearts, diamonds, clubs }
void main(string[] args) {
   assert(enumToString(Suit.hearts) == "hearts");
   assert(stringToEnum("diamonds") == Suit.diamonds);
}
import std.conv;

string enumToString(Suit e) {
   // cast(string)e; <- ERRORE
   return to!(string)(e);
}

Suit stringToEnum(string s) {
   // cast(string)e; <- ERRORE
   return to!(Suit)(s);
}
