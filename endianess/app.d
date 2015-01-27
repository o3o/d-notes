import std.system;      
import std.bitmanip;
import std.stdio;

void main(string[] args) { }
unittest { 
    short val = 1964;
    ubyte[2] blob = nativeToBigEndian(val);
    assert(blob[0] == 0x07);
    assert(blob[1] == 0xac);
    writefln("%s, %s", blob[0], blob[1]);
    auto l = blob.length;

    auto bb = nativeToBigEndian(l);
    foreach (x; bb) {
       writeln(x);
       
    }
    auto b = bb[$-2 .. $];
    writefln("length %s: %s, %s", b.length, b[0], b[1]);

}
unittest {
   // 1964 = 0x7Ac
   ubyte[] blobL = [0xac, 0x07];
   auto s = blobL.read!(short, Endian.littleEndian)();
   writeln(s);
   assert(s == 1964);

   ubyte[] blobBig = [0x07, 0xac];
   auto t = blobBig.read!(short, Endian.bigEndian)();
   writefln("%s big %s",blobBig, t);
   assert(t == 1964);

}

unittest {
   ubyte[] blob = [0xac, 0x07, 0x08, 0x00];
   auto i = blob.read!(int, Endian.littleEndian)();
   writeln(i);
   assert(i == 0x807ac);
}

unittest {
   ubyte[] blob = [0x40, 0xA0, 0x0,0x0];
   ubyte[] blobcsharp = [0x0, 0x0, 0xA0, 0x40];
   writeln(blob.read!(float, Endian.bigEndian)());
   writeln(blobcsharp.read!(float, Endian.littleEndian)());
   //Endian e' definito in std.system.
   alias read!(float, Endian.littleEndian, ubyte[]) rf;
   
   ubyte[] buffer = [66, 0, 0, 0, 65, 200, 0, 0];
   assert(buffer.peek!float() == 32.0);
   assert(rf(buffer) != 32.0);
}

//http://dlang.org/phobos/std_bitmanip.html 
unittest {
   ubyte[] blob = [0x40, 0xA0, 0x0,0x0];
   ubyte[] blobcsharp = [0x0, 0x0, 0xA0, 0x40];
   writeln(blob.read!(float, Endian.bigEndian)());
   writeln(blobcsharp.read!(float, Endian.littleEndian)());

   alias read!(float, Endian.littleEndian, ubyte[]) rf;
   
   ubyte[] buffer = [66, 0, 0, 0, 65, 200, 0, 0];
   assert(buffer.peek!float() == 32.0);
   assert(rf(buffer) != 32.0);
}

unittest {
   ubyte[] blob = [0x02, 0x00, 0x4F, 0x33, 0x4f, 0x0];
   struct X {
      int intValue;
      string stringValue;
   }
   //   ubyte* pbuf = blob;
   //   X* x = &blob;
   //   writeln("int:", x.intValue, "string:", x.stringValue);
}

unittest {
   ubyte[] blob = [0x4F, 0x33, 0x4f, 0x0];
   string s = "";
   for(int i = 0; i < 3; ++i) {
      s ~= blob.read!(char)();
   }
   writeln(s);
}
unittest {
   import std.conv;
   //convertire un array di ubyte in stinga
   ubyte[] blob = [0x4f, 0x52, 0x46, 0x45, 0x4f];
   string s = cast(string)blob;
   writeln(s);
}
