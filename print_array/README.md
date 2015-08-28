Vedere [Formatted Output](http://ddili.org/ders/d.en/formatted_output.html)

Format specifiers between %( and %) are applied to every element of a container (e.g. an array or a range):
```
    auto numbers = [ 1, 2, 3, 4 ];
    writefln("%(%s%)", numbers);
```

The format string above consists of three parts:
* `%(`: Start of element format
* `%s`: Format for each element
* `%)`: End of element format

