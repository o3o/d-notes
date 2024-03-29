import std.stdio;
import std.algorithm.comparison : equal;
import std.conv;
import std.string;

void main(string[] args) {
   // stringa -> ubyte[]
   //--------------------
   string s = "unogatto";
   //http://forum.dlang.org/thread/k806qm$2eci$1@digitalmars.com
   immutable(ubyte[]) ustr = cast(immutable(ubyte)[])s;
   ubyte[] mustr = cast(ubyte[])s;
   assert(typeof(ustr).stringof == "immutable(ubyte[])");
   assert(typeof(mustr).stringof == "ubyte[]");

   assert(ustr.length == 8);
   assert(ustr[0] == 0x75); //u
   assert(ustr[1] == 0x6e); //n
   assert(ustr[2] == 0x6f); //o
   assert(ustr[3] == 0x67); //g
   assert(ustr[7] == 0x6f); //o

   assert(mustr.length == 8);
   assert(equal(mustr, [0x75, 0x6e, 0x6f, 0x67, 0x61, 0x74, 0x74, 0x6f]));



   // ubyte[] -> string
   //--------------------
   ubyte[] stream = [0x75, 0x6e, 0x6f, 0x67, 0x61, 0x74, 0x74, 0x6f];
   string us  = cast(string)stream;
   assert(us == "unogatto");

   ubyte[] streamz = [0x75, 0x6e, 0x6f, 0x67, 0x61, 0x74, 0x74, 0x6f, 0x0, 0x0, 0x0, 0x0];
   import std.string : fromStringz;
   import std.conv;
   string ug = cast(string)(streamz);
   writefln("`%s`", ug);


   // ubyte[8] -> string
   //--------------------
   ubyte[8] streamFix = [0x75, 0x6e, 0x6f, 0x67, 0x61, 0x74, 0x74, 0x6f];
   string usF  = cast(string)streamFix;
   assert(usF == "unogatto");

   // convertire un puntatore a char in una stringa
   const(char)* ptr = "unogatto".toStringz;
   string sp = ptr.to!string();
   writefln("ptr: '%s'", sp);

}
