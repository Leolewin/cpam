#!/usr/bin/perl
# extract Go code and compile it
use strict;
use warnings;

my $quiet = 1;
my $i = 1;
my $basedir=$ARGV[0] if defined $ARGV[0];
my $GOC="/usr/lib/go/pkg/tool/linux_386/8g";
my $GOL="/usr/lib/go/pkg/tool/linux_386/8l";
if (!defined $basedir) {
    die "No basedir";
}
shift;

# remove |coderemarks|
sub removeremark($) {
    my $file = shift;
    open GO, "+<", $file or die "Cannot open: $file";
    my @go;
    my $skip = 0;
    while(<GO>) {
        if ($skip) {
	# check if we have % again, if so, skip again
        if (/\%$/) { next; }
            $skip = 0;
            next;
        }   

        if (/\%$/) { $skip = 1; next; }
        if (/\|\\begin/) { $skip = 1; next; }
        if (/\|\\draw/) { $skip = 1; next; }
        if (/\\end/) { $skip = 0; next; }

        s/\%.*$//;
        s/\\draw.*$//;
	s/\|\\coderemark.*?(\||\%$|$)//;
	s/\|\\longremark.*?(\||\%$|$)//;
	s/\\newline//;
	push @go, $_;
    }
    truncate GO, 0;
    seek GO, 0, 0;
    foreach(@go) {
	print GO $_;
    }
    close GO;
}

sub compile($) {
    my $file = shift;
    my $target = "/tmp/$$.go.$i";
    $i++;
    system("cp $basedir/$file $target");
    removeremark($target);
    system("$GOC $target");
    unlink($target);
    $? >> 8;
}

my $inlisting = 0;
my @listing;
while(<>) {
    if (m|\\lstinputlisting(\[.*?\])?{(.*)}|) {
	my $gofile = $2;
	if ($gofile !~ /\.go$/) {
	    print "No Go    : $gofile\n" if not $quiet;
	    next;
	}
	if (compile($gofile) != 0) {
	    print "Compiling: $GOC $gofile -- ";
	    print "NOT OK\n";
	} else {
	    print "OK\n" if not $quiet;
	}
    }
}
