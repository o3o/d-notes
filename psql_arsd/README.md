Adam Ruppe
https://github.com/adamdruppe/misc-stuff-including-D-programming-language-web-stuff

# Computer snowball
## Per renderlo accessibile da win
Aggiungere `192.168.0.0/24` e `10.0.0.0/16` in `/var/lib/postgres/data/pg_hba` e 

```
listen_addresses = '*'
```
in `/var/lib/postgres/data/postgresql.conf`


Per avviare psql in Linux
```
# systemctl start postgresql
```

