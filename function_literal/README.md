# da TDPL 2.2.7 Function Literals
Le Function Literals offrono la possibilita' di definire funzioni anonime in
situ dovunque e' atteso il nome di una funzione.

La definizione delle funz. literal segue la stessa sintassi delle definizioni
di funzioni regolari, l'unica differenza e' che la keywords `function` precede la
definizione e manca il nome.

La definizione di una funzione e':
```
double function (int x)
```

scambiando:

```
 +----------+
 |          v
double function (int x)
 ^          |
 +----------+

```

si ottiene la definizione di function literal:

```
auto f = function double(int x) { return x / 10.; };
auto a = f(5);
assert(a == 0.5);
```

Il tipo della funzione f e' "puntatore ad una funzione che prende un int e
torna un double". La definizione completa e':
```
double function(int) f = function double(int x) { return x / 10.; };
```

Per semplificare la definizione si puo' omettere il tipo ritornato

```
auto f = function (int x) { return x / 10.; };
```

# Da Learning D (M. Parker) cap. 2.7.7 pag 85
Parker distingue tra puntatori a funzione e delegate

Un puntatore ad una funzione puo' essere dichiarato come per una variabile.

```
void function(int) funcP;
```
Per inizializzarlo usare `&`:

```
void myFunc(int i) {
   writeln(i);
}

void main() {
   void function(int) funcP = &myFunc;
   funcP(42);
}
```

L'operatore `&` per le inner function non ritorna un function pointer ma un delegate


# Dal wiki [1]

[1](http://wiki.dlang.org/Function_literals)
