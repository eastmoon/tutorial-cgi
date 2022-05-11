#!/usr/bin/env perl

## Use perl verion > 5.10
use 5.010;

## Declare function.
sub fun1
{
    say ">> Simple function";
    print "Hello ";
    print "World\n";
}

sub fun2
{
    say ">> Print all parameter";
    print "Parameter : ";
    print "@_ \n"

}

sub fun3
{
    say ">> Parameter transfer to local variable";
    my($a, $b, $c) = @_;
    print("p1 : $a, p2 : $b, p3 : $c");
}

sub fun4
{
    say ">> Calculate with global and assign parameter.";
    my($a, $b, $c) = @_;
    my($glo, $loc);
    $glo = $g1 + $g2;
    $loc = $a + $b - $c;
    return ($glo, $loc);
}

## Global variable
## if declare variable did not use "my", it mean variable is global.
$g1 = 1;
$g2 = 2;

## Execute script
###
&fun1;
###
&fun2(1, 2, 3 ," It is print all.");
###
&fun2(5, 4, 3);
###
@x = &fun4(4, 3, 2);
print "Global = $x[0]; and Local = $x[1]\n";
###
#### Default @INC path will not include local directory, use "use lib" to additation new path in @INC.
use lib "./";
require "2-x-function-library.pl";
&libfun1;
&libfun2;
