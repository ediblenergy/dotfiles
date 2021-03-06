
#fatpack trace _deploy.pl
#fatpack packlists-for `cat fatpacker.trace` >packlists
#fatpack tree `cat packlists`
#(fatpack file; cat myscript.pl) >myscript.packed.pl
#

F=_deploy.pl
B=deploy.pl

build: packlists lib/
	fatpack tree `cat packlists`
	echo '#!/usr/bin/env perl' > $B
	(fatpack file; cat $F) >> $B

lib/:
	mkdir lib

fatpacker.trace:
	fatpack trace $F 

packlists:	fatpacker.trace
	fatpack packlists-for `cat fatpacker.trace` > packlists

clean:
	rm -r fatpacker.trace packlists fatlib
