#!/usr/local/bin/perl -w

use Test::More qw(no_plan);
use lib "lib";
use lib "../lib";

use ExtUtils::Command;
use Cwd;
use File::Spec;

# checks the syntax and the ability to load the module
BEGIN { use_ok( 'App::Build' ); }

ok(1, "dummy test");

my $startdir = getcwd();
my $testdir = (-d "t") ? "t" : ".";
my $basedir = (-d "t") ? "." : "..";
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

chdir("$testdir/Foo");
system("perl Build realclean") if (-f "Build");
ok(!-f "Build", "Build initially not present");
system("perl Build.PL PREFIX=../install");
ok(-f "Build", "Build created");
system("perl Build");
foreach $dir ("blib", "blib/cgi-bin", "blib/cgi-bin/foo", "blib/htdocs", "lib") {
    ok(-d $dir, "$dir dir created");
}
system("perl Build install");
chdir($startdir);
chdir($testdir);
foreach $dir ("install", "install/cgi-bin", "install/cgi-bin/foo", "install/htdocs", "install/lib") {
    ok(-d $dir, "$dir dir created");
}
foreach $file (
        "install/cgi-bin/foo/foo.cgi",
        "install/cgi-bin/foo/foo.conf",
        "install/htdocs/index.html",
        "install/htdocs/robots.txt",
        "install/htdocs/.htaccess",
    ) {
    ok(-f $file, "$file file created");
}
foreach $file (
        "install/cgi-bin/foo/foo.cgi",
    ) {
    ok(-x $file, "$file file executable");
}
foreach $file (
        "install/cgi-bin/foo/foo.conf",
        "install/htdocs/index.html",
        "install/htdocs/robots.txt",
        "install/htdocs/.htaccess",
    ) {
    ok(! -x $file, "$file file not executable");
}
ok(-f "Foo/cgi-bin/CVS/Entries" && ! -f "install/cgi-bin/CVS/Entries", "CVS files not copied");

# clean up
chdir($startdir);
@ARGV = ($installdir); rm_rf();
chdir("$testdir/Foo");
system("perl Build realclean");
@ARGV = ("lib"); rm_rf();

exit 0;

