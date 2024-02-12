use strict;
use warnings;
use TOML::Tiny qw(from_toml to_toml);

sub get_latest_version {
    my ($library) = @_;
    my $output = qx(cargo search $library);
    my ($new_ver) = $output =~ /"([^"]+)"/; # Capture version in quotes
    return $new_ver;
}

sub update_library_versions {
    my ($filename) = @_;
    open my $fh, '<', $filename or die "Cannot open $filename: $!";
    my $file_content = do { local $/; <$fh> };
    close $fh;

    my $toml = from_toml($file_content);

    if (exists $toml->{dependencies}) {
        while (my ($lib, $version) = each %{$toml->{dependencies}}) {
            my $new_version = get_latest_version($lib);
            if (defined $new_version and ($version ne $new_version)) {
                print "Updating $lib: $version -> $new_version\n";
                $toml->{dependencies}{$lib} = $new_version;
            } else {
                print "Latest version for $lib not found or already up to date.\n";
            }
        }

        my $new_toml_content = to_toml($toml);
        open my $fh_out, '>', $filename or die "Cannot open $filename for writing: $!";
        print $fh_out $new_toml_content;
        close $fh_out;
    } else {
        print "'dependencies' section not found in $filename\n";
    }
}

sub main {
    my ($filename) = @ARGV;
    update_library_versions($filename);
}

main() unless caller;
