#!/usr/local/bin/perl -w

my ($testdir, $basedir, $startdir, $libdir);
BEGIN {
    use Cwd;
    $testdir = (-d "t") ? "t" : ".";
    $basedir = (-d "t") ? "." : "..";
    $startdir = getcwd();
    $libdir = "$startdir/$basedir/lib";
    unshift(@INC, $libdir);
}
use Test::More qw(no_plan);

use ExtUtils::Command;
use File::Spec;

# checks the syntax and the ability to load the module
BEGIN { use_ok( 'App::Build' ); }

ok(1, "dummy test");

my $app_build = File::Spec->catfile($basedir, "lib", "App", "Build.pm");
my $app_build_test_dir = File::Spec->catdir($testdir, "Foo", "lib", "App");
my $app_build_test = File::Spec->catfile($testdir, "Foo", "lib", "App", "Build.pm");
my $installdir = File::Spec->catdir($testdir, "install");

@ARGV = ($installdir); rm_rf();
ok(! -d $installdir, "$installdir directory initially not present");
@ARGV = ($app_build_test_dir); rm_rf();
ok(! -d $app_build_test_dir, "$app_build_test_dir directory initially not present");
@ARGV = ($app_build_test_dir); mkpath();
ok(-d $app_build_test_dir, "$app_build_test_dir directory created");
@ARGV = ($app_build, $app_build_test); cp();
ok(-f $app_build_test, "$app_build_test file copied");

exit 0;

