
use lib "lib";
use App::Build;

use File::Spec;

# NOTE: If anyone knows why the CPAN shell does "perl Build.PL Build",
# forcing me to put this next line (hack) in, please let me know.
#   stephen.adkins@officevision.com
shift(@ARGV) if ($#ARGV > -1 && $ARGV[0] eq "Build");

# Enable the continued use of the PREFIX=$PREFIX option
# (from Makefile.PL and ExtUtils::MakeMaker) by making it
# an alias for the "install_base" option of Module::Build.

# Also, install scripts into $PREFIX/bin, not $PREFIX/scripts.

my (@extra_args);
foreach my $arg (@ARGV) {
    if ($arg =~ s!^PREFIX=(.*)!install_base=$1!i) {
        @extra_args = (
            install_path => {bin => "$1/bin"},
        );
    }
    elsif ($arg =~ m!^install_base=(.*)!) {
        # Install scripts into $PREFIX/bin, not $PREFIX/scripts
        @extra_args = (
            install_path => {bin => "$1/bin"},
        );
    }
}

my $build = App::Build->new (
    dist_name         => "App-Build",
    dist_version_from => "lib/App/Build.pm",
    dist_author       => "stephen.adkins\@officevision.com",
    license           => "perl",
    requires => {
        "App::Options"    => 0,  # configuration
        "File::Spec"      => 0,  # platform-neutral directory manipulation
    },
    build_requires => {
        "Module::Build"   => 0,  # needed for installing the software
        "Sysadm::Install" => 0,  # needed for installing the software
    },
    @extra_args,
);

$build->create_build_script;

