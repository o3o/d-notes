/**
 * Vedi pag52 di Parker
 */
void main(string[] args) {
   // Array static
   //--------------------
   int[3][2] ra0;
   // e' un array di due elementi: ciascun elemento e' int[3]. Puo' essere pensato come
   //(int[3])[2] ra1;

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

