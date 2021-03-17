/**
 * Vedi pag52 di Parker
 */
void main(string[] args) {
   import std.stdio;
   // Array static
   //--------------------
   int[3][2] ra0;
   // e' un array di due elementi: ciascun elemento e' int[3]. Puo' essere pensato come
   //(int[3])[2] ra1;
   //
   //   ra1[0]     ra1[1]
   // +--------+ +--------+
   // |  | x|  | |  |  |  |
   // +--------+ +--------+
   //      ^
   //      |
   //      +-----+
   // |--------| |
   // | ra1[0] |[1] == x
   //

   // NON si possono  dichiarare:
   //int rows = 2;
   //int cols = 3;
   //int[cols][rows] ra1; // Error: variable cols cannot be read at compile time


   int[3][2] ra2 = [
      [600, 601, 602],
      [610, 611, 612]
   ];
   assert(ra2[0].length == 3);

   // Ottenere una riga
   //--------------------
   // ra2[j] rappresenta la riga j
   assert(ra2[1] == [610, 611, 612]);


   // Ottenere una cella
   //--------------------
   // si accede per riga
   // ra[row][col]
   assert(ra2[0][1] == 601);
   assert(ra2[1][0] == 610);
   assert(ra2[1][2] == 612);


   // Array dinamici
   //--------------------
   int[][] ra3;
   // aggiungere cella
   ra3 ~= [700];
   ra3[0] ~= 701;
   ra3 ~= [710, 711, 712];

   assert(ra3[0].length == 2);
   assert(ra3[1].length == 3);
   // ottenere una cella
   // anche qui riga, colonna
   assert(ra3[1][2] == 712);

   // ottenere una colonna
   int[][] ra4 = [
      [800, 801, 802],
      [810, 811, 812],
      [820, 821, 822]
   ];
   assert(ra4.col(1) == [801, 811, 821]);


   //Declaring them has the same form   of
   // `elementType[numberOfElements]`
   // that is used with any array. It's just that, in
   //a rectangular array, the type of the array elements happens to be another array.
   int[][] ra5;
   ra5[0] = new int[](6);
   ra5[1] = new int[](6);

   ra5[0] ~= [100, 101, 102];
   ra5[0] ~= [103, 104, 105];
   ra5[1] ~= [200, 201, 202];
   ra5[1] ~= [203, 204, 205];
   for (int i = 0; i < ra5[0].length; ++i) {
      // riga colonna
      writeln(ra5[0][i]);
   }

   int[2][5] ra6;
   // ra6 e' un array di 5 elementi. Ogni elemento e' un array int[2]
   // ra[0] ritorna un int[2]
   ra6[0] = [10, 11];
   ra6[1] = [20, 21];
   ra6[2] = [30, 31];
   ra6[3] = [40, 41];
   ra6[4] = [50, 51];
   for (int i = 0; i < ra6.length; ++i) {
      for (int j = 0; j < ra6[i].length; ++j) {
         // riga colonna
         writef("[%d %d] %d", i, j, ra6[i][j]);
      }
      writeln();
   }

   int[6][] ra7; // leggi come (int[6])[] e' un array con un numero indeetermianto di elementi e cianscun elemento e' un int[6]

   int[6] x = [10, 11, 12, 13,  14, 15];
   ra7 ~= x;
   ra7 ~= [20, 21, 22, 23,  24, 25];

   // per colonne

   writefln("%(%s %)", ra7[0]);
}

int[] col(int[][] data, size_t no) {
   assert( no < data[0].length, "bad col index" );
   int[] ret;
   //for (int i = 0; i < data.length; ++i) {
   foreach (i; 0 .. data.length) {
      ret ~= data[i][no];
   }
   return ret;
}

