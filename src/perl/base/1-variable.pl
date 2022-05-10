#!/usr/bin/env perl

## Use perl verion > 5.10
use 5.010;

## Scalar ( simple variable ) assign with number, string.
say ">> Scalar";
$var = "hello";
print "$var\n";

## Scalar array ( simple variable array set ) assign with number, string.
## qw is a function which make ( a b c d ) equal like ( "a", "b", "c", "d" )
say ">> Scalar array";
@array=qw(a b c d);
print "Total size : $#array\n";
for( $i=0 ; $i <= $#array ; $i++) {
    print "$array[$i]\n";
}

## Hash array ( key & value data group ) assign with string in key and value.
## In hash array, key is non-order, it mean it is not exist first item or first key.
say ">> Hash array";
%hash=("v1"=>"aaa", "v2"=>"bbb", "v3"=>"ccc");
foreach $key (keys %hash) {
    print "$hash{$key}\n";
}

## Reference ( Pointer ) assign tagert variable or array memory address.
say ">> Reference";
$scalarRef=\$var;
$arrayRef=\@array;
$hashRef=\%hash;
print "$$scalarRef\n";
print "@$arrayRef\n";
print "$hashRef->{v1}\n";
