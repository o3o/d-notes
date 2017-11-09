import std.stdio;
import arsd.mssql;

void main() {
   auto db = new MsSql("Driver={SQL Server Native Client 10.0};Server=RAE-HP\\SQLEXPRESS;Database=sicam;Trusted_Connection=Yes");
   //db.query("INSERT INTO users (id, name) values (30, 'hello mang')");
   foreach(line; db.query("SELECT TOP 100 * FROM result")) {
      writeln(line[0], line["id"]);
   }
}
