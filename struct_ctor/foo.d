/**
 * Struttura con construttore e ctor di default
 *
 * key e' in sola lettura
 */
struct Bar {
   string value;
   this(string k) {
      _key = k;
   }

   private string _key;
   @property string key() { return _key; }
}

/**
 * Struttura con construttore disabilitato
 */
struct Fun {
   private string _key;
   @property string key() { return _key; }

   string value = "a";
   this(string k) {
      _key = k;
   }
   @disable this();
}
