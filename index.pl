#!/usr/bin/env perl

use strict;
use warnings;
use CGI;

sub getfile {
    my $filename = $_[0];
    my $file;
    my $res = "";
    if (!open($file, "<:encoding(UTF-8)", $filename)) {
        print "Could not open file '$filename' $!";
        return "";
    }
    while (my $s = <$file>) {
        $res .= $s;
    }
    close($file);
    return $res;
}

sub putfile {
    my ($filename, $text) = @_;
    my $file;
    if (!open($file, ">:encoding(UTF-8)", $filename)) {
        print "Could not open file '$filename' $!";
        return;
	}
    print $file $text;
    close($file);
}

sub cur_date 
    { return `date +%d.%m.%Y`; }
sub cur_time
    { return `date +%H:%M`   ; }

sub main {
    print("Content-type: text/html\n\n");
    my $query = CGI->new;
    my $text = $query->param("post");
    my $post = getfile("base.html");
    if ($text ne "") {
        $post .= "_" x 4 . " " . cur_date() . " " . cur_time() . " " . "_" x 20;
        $post .= "<pre>" . $text . "</pre><hr>";
        putfile("base.html", $post);
    }
    my $html = getfile("book.html");
    $html =~ s/{}/$post/;
    print $html;
    #print(sprintf($html, $post));  ## if i will change '{}' to '%s' in book.html
    return 0;
}
exit(main(@ARGV));
