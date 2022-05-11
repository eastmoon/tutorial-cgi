#!/usr/bin/env perl

# Declare variable
$scalar = 10;
@array  = (1, 2);
%hash   = ( "1" => "Davy Jones" );

# Declaare function
sub printRef {
    foreach (@_) {
        $refType = ref($_);
        defined($refType) ? print "$refType " : print("Non-reference ");
    }
    print("\n");
}

# Execute script
&printRef( $scalar, @array, %hash );
&printRef( \$scalar, \@array, \%hash );
&printRef( \&printRef, \\$scalar );
