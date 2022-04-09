// rdmd --main -unitest app.d
import std.system;
import std.bitmanip;
import std.stdio;
import std.array;

unittest {
   // 1964 e' 0x07ac
   // in bigEndian
   //
   // 07 ac
   // |   |   +-------+
   // +------>|       | 0
   //     |   +-------+
   //     +-->|       | 1
   //         +-------+
   short val = 1964;
   ubyte[2] blob = nativeToBigEndian(val);
   assert(blob[0] == 0x07);
   assert(blob[1] == 0xac);

   size_t l = 2; //8 byres in x86
   auto bb = nativeToBigEndian(l);
   assert(bb.length == 8);
   assert(bb[7] == 2);
   auto b = bb[$-2 .. $];
   assert(b.length == 2);
   assert(b[0] == 0);
   assert(b[1] == 2);

   // per avere solo due bytes
   ubyte[2] us = nativeToBigEndian!ushort(cast(ushort)l);
   assert(us.length == 2);
   assert(us[0] == 0);
   assert(us[1] == 2);
}
unittest {
   // 1964 e' 0x07ac
   // in littleEndian
   //
   // 07 ac
   // |   |   +---+
   // |   +-->|   |
   // |       +---+
   // +------>|   |
   //         +---+
   short val = 1964;
   ubyte[2] blob = nativeToLittleEndian(val);
   assert(blob[0] == 0xac);
   assert(blob[1] == 0x07);

   ushort v1 = 29;
   ubyte[2] b1 = nativeToLittleEndian(v1);
   assert(b1.length == 2);
   assert(b1[0] == 29);
   assert(b1[1] == 0);
   ubyte[] slice;
   slice ~= nativeToLittleEndian(v1);
   assert(slice[0] == 29);
   assert(slice[1] == 0);
   assert(slice.length == 2);
}

unittest {
   // 1964 = 0x7AC
   ubyte[] blobL = [0xAC, 0x07];
   short s = blobL.read!(short, Endian.littleEndian)();
   assert(s == 1964);
   //read consuma il buffer
   assert(blobL.length == 0);

   ubyte[] blob = [0xAC, 0x07, 0x3, 0x0];
   short s0 = blob.read!(short, Endian.littleEndian)();
   assert(s0 == 1964);
   assert(blob.length == 2);

   assert(blob.read!(short, Endian.littleEndian)());
   assert(blob.length == 0);

   ubyte[] blobBig = [0x07, 0xac];
   auto t = blobBig.read!(short, Endian.bigEndian)();
   assert(t == 1964);
}

unittest {
   ubyte[] blob = [0xac, 0x07, 0x08, 0x00];
   auto i = blob.read!(int, Endian.littleEndian)();
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
   assert(s == "O3O");
}

unittest {
   import std.conv;
   //convertire un array di ubyte in stringa
   ubyte[] blob = [0x4f, 0x52, 0x46, 0x45, 0x4f];
   string s = cast(string)blob;
   assert(s == "ORFEO");
}
unittest {
   auto buffer = appender!(const (ubyte[]))();
   ushort[] a = [0x3480, 0x2010];
   foreach (e; a) {
      buffer.append!(ushort, Endian.littleEndian)(e);
   }
   assert(buffer.data[0] == 0x80);
   assert(buffer.data[1] == 0x34);
   assert(buffer.data[2] == 0x10);
   assert(buffer.data[3] == 0x20);
}

unittest {
   const(int[]) x = [0, 1];
   const(int)[] y = [0, 1];
   const int[] z = [0, 1]; // ==> const(int[])
   // x ~= 1; NO, perche il vettore e' constate
   y ~= 1; // si perche i dati sono costanti
   //y[0] = 5; // No
   // z ~= 1;  NO
}

unittest {
   // peek takes a range of ubytes and converts the first T.sizeof bytes to T.
   // The value returned is converted from the given endianness to the native endianness. The range is not consumed.
// 1964 = 0x7AC
   ubyte[] blobL = [0xAC, 0x07];
   short s0 = blobL.peek!(short, Endian.littleEndian)();
   assert(s0 == 1964);

   // di default e' bigendian
   short s1 = blobL.peek!(short);
   short s2 = blobL.peek!(short, Endian.bigEndian);
   assert(s1 == s2);
   assert(blobL.length == 2);
}

unittest {
// 1964 = 0x7AC
   ubyte[2] blobL = [0xAC, 0x07];
   short s0 = littleEndianToNative!(short)(blobL);
   assert(s0 == 1964);
   assert(blobL.length == 2);
}
