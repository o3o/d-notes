enum Suit { spades, hearts, diamonds, clubs }

void main(string[] args) {
   // Enumerazione anonime
   //----------------------------------------
   // se non si dichara il tipo e' int
   enum {top, bottom, left, right}
   assert(typeid(top) == typeid(int));
   // qui e' un ubyte
   enum : ubyte { red, green, blue}
   assert(typeid(red) == typeid(ubyte));

   // Enumerazione anonime con un solo membro
   //----------------------------------------
   // Se l'Enumerazione ha un solo membro si possono omettere le graffe

   enum {author0 = "Mike Parker"}
   enum author1 = "Mike Parker";
   enum string author2 = "Mike Parker";
   assert(typeid(author0) == typeid(string));
   assert(typeid(author1) == typeid(string));
   assert(typeid(author2) == typeid(string));

   // Conversioni da stringa a enum e viceversa
   // ----------------------------------------
   assert(suitToString(Suit.hearts) == "hearts");
   assert(stringToSuit("diamonds") == Suit.diamonds);


   // Conversioni da int a enum
   // ----------------------------------------
   enum Outcome : int {
      unknown = 0,
      na = 1,
      pass = 2,
      fail = 3,
      stop = 4,
      error = 5,
   }
   // enum -> int
   assert(cast(int)Outcome.fail == 3);

   // int -> enum
   Outcome o = cast(Outcome)5;
   assert(o == Outcome.error);
   import std.stdio;

   Outcome c0 = cast(Outcome)6;
   writeln("c0: ", c0); // cosa vale c0?

   bool outErr;
   try {
      Outcome c1 = 17.to!Outcome();
   } catch (Exception e) {
      outErr = true;
   }
   assert(outErr);
   //Outcome c0 = cast(Outcome)17;
   //writeln(c0);
   //Outcome c1 = 17.to!Outcome();
   //writeln(c1);


   // nel caso di enum senza valore il tipo e int e il valore inizia da zero
   assert(cast(int)Suit.hearts == 1);

   enum Rgb : ubyte { red = 1, green = 2, blue = 3 }
   assert(cast(ubyte)Rgb.red == 1);

   // strutttura
   enum Foo FOO = {name: "ODV", age: 54};
   assert(FOO.name == "ODV");

   //Bar b = Bar!(Suit.spades);
   // come converte in stringa?
   enum Status {
      idle,
      setET,
      openBypass
   }
 string s = Status.openBypass;
 writeln(s);

}

struct Foo {
   import std.traits;
   string name;
   int age;
}
   /+

   foreach (s; EnumMembers!Suit) {
      setSuitG!(s);
   }

   foreach (i; 0 .. 2) {
      exec(i, "cul");
   }
   writeln("-----");

   import std.stdio;
   foreach (i; 1 .. 5) {
      writeln(i);
   }
}
+/
import std.conv;
string suitToString(Suit e) {
   //return cast(string)e; Error: cannot cast expression e of type Suit to string
   return to!(string)(e);
}

Suit stringToSuit(string s) {
   //return cast(Suit)s; Error: cannot cast expression s of type string to Suit
   return to!(Suit)(s);
}

void setSuit(Suit s) {
   import std.stdio;
   writeln(s);
}
void setSuitInt(size_t s) {
   import std.stdio;
   writeln("   ", s);
}

void setSuitG(Suit s)() {
   import std.stdio;
   writeln("G ", s);
}

void exec(int I)(string s) {
   import std.stdio;
   static if (I == 0) {
      writefln("zero %s", s);
   }
   static if (I == 1) {
      writefln("uno %s", s);
   }
}

void exec(int i, string s) {
   switch (i) {
      case 0:
         exec!0(s);
         break;
      case 1:
         exec!1(s);
         break;
      default:
         assert(false);
   }
}
