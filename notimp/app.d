void main(string[] args) {
   foo(3);
}
import std.exception;
void foo(int x) {
   pragma(msg, "Not yet implemented");
   enforce(false,  "Not yet");
   assert(false, "Not yet implemented");
}
