#!/usr/bin/env perl

use strict;
use warnings;
use CGI;

sub readfile {
    my $filename = $_[0];
    my $file;
    my $res = "";
    if (!open($file, "<:encoding(UTF-8)", $filename)) {
        die "Could not open file '$filename' $!";
    }
    while (my $s = <$file>) {
        $res .= $s;
    }
    close($file);
    return $res;
}

sub main {
    print("Content-type: text/html\n\n");

    my $query = CGI->new;
    my $val = $query->param("answer");

    #print readfile("dummy.html");

    print "<html>";
    print     "<head>";
    print         "<title>Sent</title>";
    print     "</head>";
    print     "<body>";
    print         "<pre>answer: $val</pre>";
    print     "</body>";
    print "</html>";
}

exit(main());
