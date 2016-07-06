//http://forum.dlang.org/post/avzjcwtyyufletxacmbq@forum.dlang.org
import std.algorithm.searching;
import std.string;
void copyObj(SRC,DEST)(ref SRC src,ref DEST dest) {
   foreach (i, type; typeof(SRC.tupleof)) {
      static if (__traits(hasMember, DEST, SRC.tupleof[i].stringof)) {
         __traits(getMember, dest, SRC.tupleof[i].stringof) = __traits(getMember, src, SRC.tupleof[i].stringof);
      }
   }
}

void round(SRC)(ref SRC src) {
   foreach (i, type; typeof(SRC.tupleof)) {
      static if (is(type == float)) {
         static if (startsWith(SRC.tupleof[i].stringof, "x")) {
            __traits(getMember, src, SRC.tupleof[i].stringof) = f(__traits(getMember, src, SRC.tupleof[i].stringof), 0.1);
         } else static if (startsWith(SRC.tupleof[i].stringof, "y")) {
            __traits(getMember, src, SRC.tupleof[i].stringof) = f(__traits(getMember, src, SRC.tupleof[i].stringof), 0.5);
         }
      }
   }
}

float f(float x, float delta) {
   return x + delta;
}

// la struttura A deve essere un sottoinsieme di B
struct A { string a; double b; int x; int y; }
struct B { string a; double b;        int z; int y;}
struct C {float x; float y; float xab; int xxx;}

void main() {
   import std.stdio: writeln;
   A a = A("a", 19.64, 1, 2);
   writeln(typeof(A.tupleof).stringof);
   writeln(A.tupleof.stringof);

   B b;
   copyObj(a, b);
   assert(a.a == b.a);
   assert(a.b == b.b);
   assert(a.y == b.y);
   assert(b.z == 0);
   writeln("B.b :", b.b);
   writeln("B.y :", b.y);
   writeln("B.z :", b.z);

   C c = C(2,3,4);
   round(c);
   writeln("c.x :", c.x);
   writeln("c.y :", c.y);
   writeln("c.xb :", c.xab);
   writeln("c.xxx:", c.xxx);

}
