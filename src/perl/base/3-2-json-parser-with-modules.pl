# Before use, install JSON module with CPAN command "echo yes | cpan -i JSON"
# imports encode_json, decode_json, to_json and from_json.
use JSON;

# simple and fast interfaces (expect/generate UTF-8)
## Encode
my @array=qw(a b c d);
$json_text_arr = encode_json \@array;
print "$json_text_arr\n";

my %hash=("v1"=>"aaa", "v2"=>"bbb", "v3"=>"ccc");
$json_text_hash = encode_json \%hash;
print "$json_text_hash\n";

my %obj=("v1"=>\@array, "v2"=>"bbb", "v3"=>"ccc");
$json_text_obj = encode_json \%obj;
print "$json_text_obj\n";

# Decode
$json = '{"a":1,"b":2,"c":3,"d":4,"e":5}';
$dhash = decode_json($json);
foreach $key (keys %$dhash) {
    print %$dhash{$key};
    print "\n";
}
