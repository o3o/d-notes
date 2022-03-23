import std.stdio;
void main(string[] args) {

   short sinteger = 0;
   ushort usinteger = 0;
   int integer = 0;
   uint uinteger = 0;
   long linteger = 0;
   ulong ulinteger = 0;
   size_t szinteger =0;

   writefln("short    %s", sinteger.sizeof  );
   writefln("ushort   %s", usinteger.sizeof );
   writefln("int      %s",   integer.sizeof   );
   writefln("uint     %s",  uinteger.sizeof  );
   writefln("long     %s",  linteger.sizeof  );
   writefln("ulong    %s", ulinteger.sizeof );
   writefln("size_t   %s", szinteger.sizeof  );

}
