Esempio di connessione a sqlite

Vedere [wiki](https://github.com/o3o/d-notes/wiki/SQLite-drivers).



# Struttura
```
sqlite_arsd/
├── db
│   └── ldg.sqlite
├── lib
│   └── sqlite3.dll
├── src
│   ├── app.d
│   └── arsd
│       ├── database.d
│       └── sqlite.d
├── common.mk
├── makefile
└── update.sh
```

* `src/arsd` sorgenti si possono ottenere da https://github.com/adamdruppe/arsd.git
* `update` copia i sorgenti localmente 
* `db` database di appoggio


# Note
In `src/arsd/sqlite.d` ho commentato i `pragma` in modo da verificare i
parametri da passare al compilatore.

# Schema database

```
CREATE TABLE "athlete" (
   "id" INTEGER PRIMARY KEY  NOT NULL,
   "name" VARCHAR,
   "surname" VARCHAR,
   "year_of_birth" INTEGER,
   "gender" CHAR
);
```
