//http://forum.dlang.org/post/avzjcwtyyufletxacmbq@forum.dlang.org
void copyObj(SRC,DEST)(ref SRC src,ref DEST dest) {
	foreach (i, type; typeof(SRC.tupleof)) {
		__traits(getMember, dest, SRC.tupleof[i].stringof) = __traits(getMember, src, SRC.tupleof[i].stringof);
	}
}

// la struttura A deve essere un sottoinsieme di B
struct A { string a; double b; int x; int y; }
struct B { string a; double b; int x;  int z; int y;}

void main() {
   import std.stdio: writeln;
   A a = A("a", 19.64, 1, 2);
   writeln(typeof(A.tupleof).stringof);
   writeln(A.tupleof.stringof);

   B b;
   copyObj(a, b);
   assert(a.a == b.a);
   assert(a.b == b.b);
   assert(a.x == b.x);
   assert(b.z == 0);
   writeln(b.b);

}
