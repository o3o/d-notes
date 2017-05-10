import std.stdio;
import std.array;

void main() {
   // vedi  http://stackoverflow.com/documentation/d/5760/strings/24157/test-for-an-empty-or-null-string

   // String vuota
   //----------------------------------------
   string emptyString = "";
   // una  stringa vuota non e' null, il suo ptr non e' nullo
   assert(emptyString !is null);
   // ma ha lunghezza zero
   assert(emptyString.length == 0);
   assert(emptyString == null);

   /**
    * M. Parker pag 59
    * `a == null` will return true if `a.length` is 0;
    * `a is null` will return true if `a.length` is 0 and a.ptr is null
    *
    * Siccome le stringhe sono array, `emptyString == null` e' vero perche length = 0, ma non e' vero `emptyString is null`
    * perche' punta da qualche parte
    */

   // necessario std.array
   assert(emptyString.empty);

   // String nulla
   //----------------------------------------
   string nullString = null;

   // stringa nulla e' null, ptr non punta nessuna locazione
   assert(nullString is null);
   // ha lunghezza zero
   assert(nullString == null);
   assert(nullString.length == 0);
   // ed e' empty
   assert(nullString.empty);
}
