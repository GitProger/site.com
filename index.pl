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
    my $new = $query->param("post");
    my $post = getfile("base.html");
    if ($new ne "") {
        my $temp = getfile("template.html");
        my $time = cur_date() . " " . cur_time();
        $temp =~ s/\$DATE\$/$time/;
        $temp =~ s/\$AUTH\$/anon/;
        $temp =~ s/\$TEXT\$/$new/;
        $post .= $temp;
        putfile("base.html", $post);
    }
    my $html = getfile("book.html");
    $html =~ s/{}/$post/;
    print $html;
    return 0;
}
exit(main(@ARGV));
