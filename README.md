# forth-histogram
Small Forth program to count letters from input. This program doesn't really do
much useful, it was mostly an excuse to play with Forth as I've wanted to do
that for a while.

If you've got `gforth` installed you can run it with `gforth histogram.fth`.
It'll wait until EOF and once this is encountered, print out the results.

For example, if you wanted to get the histogram of the program itself, you
could do `gforth histogram.fth < histogram.fth`.

