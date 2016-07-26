import std.stdio;

/**
  Per eseguire in versione debug
  $ dub run -bdebug
  in versione x
  $ dub run -cx
  $ dub run -cxy
  questo perche dub.sdl contiene la configurazione x e xy

  Con make
  $ make  b=debug
  $ make  c=x
 */
void main() {
   version (x) {
      writeln("version x");
   }
   version (y) {
      writeln("version y");
   }
   debug {
      writeln("version debug");
   }

   writeln("all version");
}
