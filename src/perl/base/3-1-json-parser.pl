#!/usr/bin/env perl

## Use perl verion > 5.10
use 5.010;

# Declare variable
my @array=qw(a b c d);
my %hash=("v1"=>"aaa", "v2"=>"bbb", "v3"=>"ccc");
my %hash2=("v4"=>"ddd", "v5"=>"eee", "v6"=>"fff");
my %obj1=("v1"=>\@array, "v2"=>"bbb", "v3"=>"ccc");
my @obj2=(\%hash, \%hash2);

# Declaare function
sub parser_array() {
    my ($set) = @_;
    my $result = "[";
    $refType = ref(\@$set);
    for( $i=0 ; $i <= $#$set ; $i++) {
        $val = @$set[$i];
        $refType = ref(\$val);
        if ( $i > 0 ) { $result = "$result,"; }
        if ( $refType eq "SCALAR" ) {
            $result = "$result$val";
        } else {
            $tmp = &to_json($val);
            $result = "$result$tmp";
        }
    }
    $result = "$result]";
    return($result);
}

sub parser_hash() {
    my ($set) = @_;
    my $result = "{";
    my $i = 0;
    foreach $key (keys %$set) {
        $val = %$set{$key};
        $refType = ref(\$val);
        if ( $i > 0 ) { $result = "$result,"; }
        $i++;
        if ( $refType eq "SCALAR" ) {
            $result = "$result\"$key\":\"$val\"";
        } else {
            $tmp = &to_json($val);
            $result = "$result\"$key\":$tmp";
        }
    }
    $result = "$result}";
    return($result);
}

sub to_json() {
    my ($set) = @_;
    my $result = "";
    $refType = ref($set);
    if ( $refType eq "HASH" ) {
        $result = &parser_hash($set);
    }
    if ( $refType eq "ARRAY" ) {
        $result = &parser_array($set);
    }
    return ($result);
}

# Execute script
$str = &to_json(\@array);
print $str;
print "\n";
$str = &to_json(\%hash);
print $str;
print "\n";
$str = &to_json(\%obj1);
print $str;
print "\n";
$str = &to_json(\@obj2);
print $str;
print "\n";
