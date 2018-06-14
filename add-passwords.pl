#!/usr/bin/perl

# decode if it's not decoded
if (!-f "$ARGV[0]") {
	`openssl enc -d -aes-256-cbc -a -salt -in isle-dhsi-config.enc -out isle-dhsi-config`;
}

open my $f, '<', $ARGV[0] or die "no such file\n";

while(my $r = <$f>) {
	next if $r =~ /#/;
	my @a = split /:/, $r;
	chomp @a;
	# copy the raw file to the working file if it hasn't already been done
	if (!-f "./$a[0]") {
		`cp ./$a[0].raw ./$a[0]`;
	}
	# substitute the passwords
	`sed -i s/$a[1]/$a[2]/ ./$a[0]`;
}

# encode if it's not encoded
if (!-f "$ARGV[0].enc") {
	`openssl enc -aes-256-cbc -a -salt -in isle-dhsi-config -out isle-dhsi-config.enc`;
}
