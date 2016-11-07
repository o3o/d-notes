import std.stdio;
import std.math;

void main(string[] args) {
   writeln(12345.6789L.quantize(0));
   assert(12345.6789L.quantize(0) == 12345.6789L);
}
