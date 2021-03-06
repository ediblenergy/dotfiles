use strict;
use warnings FATAL => "all";
use FindBin;
use File::Spec;

use File::Copy::Recursive qw[ rmove ];

sub dest { File::Spec->catfile($ENV{HOME},".".$_[0]) }
sub backup_path { $_[0] . ".bak" }
sub deploy {
    chdir "$FindBin::Bin/./share";
    for(<./*>) {
        my($volume,$directories,$file) = File::Spec->splitpath($_);
        if( -e dest($file) ) {
            print "creating backup of " . dest($file) . "\n";
            unlink( backup_path(dest($file)));
            rmove( dest($file), backup_path(dest($file)) );
        }
            print "linking $file...\n";
            unlink(dest($file));
            symlink( File::Spec->rel2abs($file), dest($file) ) or die "$@ $!";
    }
}
deploy;
