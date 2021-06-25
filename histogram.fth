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
	then
;

: process-input
	begin
		key dup process-char
	4 = until
;

: print-summary
	26 0 do i
		i [char] a +
		dup emit ." : "
		histcell ? cr
	loop
;

process-input
print-summary
bye

