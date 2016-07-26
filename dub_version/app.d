import std.stdio;

/**
  Per eseguire in versione debug
  $ dub run -bdebug
  in versione x
  $ dub run -cx
  questo perche dub.sdl contiene la configurazione x


  Con make
  $ make  b=debug
  $ make  c=x

  */
void main() {
   version (x) {
      writeln("version x");
   }
   debug {
      writeln("version debug");
   }

	writeln("all version");
}
