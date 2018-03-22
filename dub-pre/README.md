# Uso di prebuild e pregenerate

I comandi a disposizione sono:
- `preGenerateCommands`  un elenco di comandi shell che viene eseguito prima dell'avvio della generazione del progetto
- `postGenerateCommands`  un elenco di comandi della shell che viene eseguito al termine della generazione del progetto
- `preBuildCommands`  un elenco di comandi shell che viene eseguito sempre prima della costruzione del progetto
- `postBuildCommands`  un elenco di comandi shell che viene eseguito sempre dopo la creazione del progetto


## Prima esecuzione

```
Running pre-generate commands for dub-pre...
pregenerate
Performing "debug" build using /usr/bin/dmd for x86_64.
dub-pre ~master: building configuration "application"...
Running pre-build commands...
preBuild
compiling...11.00000
Linking...
Running post-build commands...
postBuild
Running post-generate commands for dub-pre...
postGenerate
```

## Seconda esecuzione
```
Running pre-generate commands for dub-pre...
pregenerate
Performing "debug" build using /usr/bin/dmd for x86_64.
dub-pre ~master: target for configuration "application" is up to date.
To force a rebuild of up-to-date targets, run again with --force.
Running post-generate commands for dub-pre...
postGenerate
```


## In sintesi
| Comando      | 1   | 2   |
| ---          | --- | --- |
| pregenerate  | x   | x   |
| prebuild     | x   |     |
| compiling    | x   |     |
| linking      | x   |     |
| postbuild    | x   |     |
| postgenerate | x   | x   |

