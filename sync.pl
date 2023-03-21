#!/usr/bin/env perl
# This script is run via ssh from dornröschen.
use strict;
use warnings;
use Data::Dumper;

if (my ($destination) = ($ENV{SSH_ORIGINAL_COMMAND} =~ /^([a-z0-9.]+)$/)) {
    print STDERR "rsync version: " . `rsync --version` . "\n\n";
    my @rsync = (
        "/usr/bin/rsync",
        "-e",
        "ssh",
        "--max-delete=-1",
        "--verbose",
        "--stats",
	# Intentionally not setting -X for my data sync,
	# where there are no full system backups; mostly media files.
        "-ax",
        "--ignore-existing",
        "--omit-dir-times",
        "/srv/data/",
        "${destination}:/",
    );
    print STDERR "running: " . Dumper(\@rsync) . "\n";
    exec @rsync;
} else {
    print STDERR "Could not parse SSH_ORIGINAL_COMMAND.\n";
}
