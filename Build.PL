
use lib "lib";
use App::Build;

use File::Spec;

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
    },
);

$build->create_build_script;

