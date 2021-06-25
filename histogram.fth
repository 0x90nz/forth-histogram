\ Forth program to track input and find the frequency with which each letter
\ (ignoring case) appears.

26 constant hist-size

\ allot and erase the histogram
variable hist hist-size cells allot
hist hist-size cells erase

\ get the cell associated with a specific histogram entry
: histcell ( char-index -- addr ) [char] a - cells hist + ;

\ is the character a lower-case alphabetic character?
: lower? ( char -- flag ) dup [char] a >= swap [char] z <= and ; 
\ is the character an upper-case alphabetic character?
: upper? ( char -- flag ) dup [char] A >= swap [char] Z <= and ;
\ is the character either a lower-case or upper-case alphabetic character?
: alpha? ( char -- flag ) dup lower? swap upper? or ; 
\ convert an upper-case character to a lower-case one, if not upper-case the
\ character is left as-is
: downcase ( char -- lower ) dup upper? if 32 + then ;


: process-char ( char -- )
	dup alpha? if
		downcase
		histcell 1 swap +! 
	else
		drop
	then
;

: process-input
	begin
		key dup process-char
	4 = until
;

\ print a single-line summary of the histogram with exact numbers
: print-summary
	26 0 do
		i [char] a +
		dup emit ." : "
		histcell ?
	loop
	cr
;

\ get the maximum value present in the entire histogram
: max-hist-value ( -- max-value )
	0 \ initial value for max
	26 0 do i
		[char] a + histcell @ max
	loop
;

\ print n copies of a character. will only print if one or more copies are
\ requested
: print-n ( char n -- )
	\ ???: there might be a nicer way to do this? revisit loop semantics
	dup 0 > if
		0 do
			dup emit
		loop
	else
		drop	\ drop num to print
	then
	\ get rid of the char as well
	drop
;

80 3 - constant screen-width

: print-graph
	max-hist-value
	26 0 do
		i [char] a +
		dup emit ." :"	\ character legend
		histcell @ 	\ count for this char

		\ calculate (count * screen-width) / max-hist-value
		screen-width * over /
		\ print the actual bar
		[char] # swap print-n
		cr
	loop
	drop	\ get rid of max-hist-value
;

process-input
print-summary
print-graph
bye

