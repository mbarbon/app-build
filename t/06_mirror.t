#!/usr/bin/perl -w

use strict;
use lib qw(t/lib);
use Test::More tests => 2;
use TestAppBuild;
use App::Build;
use ExtUtils::Command qw();

clean_install();

eval { require File::Fetch };
SKIP: {
    skip 'No File::Fetch, skipping mirror() tests', 2 if $@;

    {
        local @ARGV = 't/test_install/foo.2';
        ExtUtils::Command::touch();
    }

    my $build1 = App::Build->new
      ( module_name  => 'Foo::Boo',
        dist_version => '0.01',
        quiet        => 1,
        );
    my $cwd = Cwd::cwd();
    $build1->mirror( "file://$cwd/t/06_mirror.t", 't/test_install/foo.1' );
    $build1->mirror( "file://$cwd/t/06_mirror.t", 't/test_install/foo.2' );

    is( -s 't/test_install/foo.1', -s 't/06_mirror.t' );
    is( -s 't/test_install/foo.2', 0 );
}
