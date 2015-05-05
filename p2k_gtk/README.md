# Esempio di uso di plot2kill in GTK

La versione da utilizzare e' quella di [klickverbot](https://github.com/klickverbot/plot2kill).

## Note
### LineGraph
E' un oggetto `plot`. E' un insieme di punti connessi da linee.
Come costruttore si usa `static opCall`, potendo scrivere quindi (manca il `new`):
```
LineGraph linesWithErrors = LineGraph([1,2,3,4], [1,2,3,8], errs, errs);
```

### Figure
E' un contenitore di uno o piu' plot. 
Anche qui si deve usare `opCall`:
```
LineGraph l1 = LineGraph([1,2,3,4], [1,2,3,8]);
LineGraph l2 = LineGraph([1,2,3,4], [1,2,3,8]);
Figure fig = Figure(l1, l2);
```

Per inserire una figura in un form gtk e' necessario convertirlo in widget
```
EventBox eb = cast(EventBox)builder.getObject("eb");

Figure fig = Figure(linesWithErrors, line2);
auto wid = fig.toWidget();
eb.add(wid);

```

