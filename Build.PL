
use lib "lib";
use App::Build;

use File::Spec;

my $build = App::Build->new (
    dist_name         => "App-Build",
    dist_version      => "0.61",
    dist_author       => "stephen.adkins\@officevision.com",
    license           => "perl",
    requires => {
        "App::Options"    => 0,  # configuration
        "File::Spec"      => 0,  # platform-neutral directory manipulation
        "Module::Build"   => 0,  # needed for installing the software (dup'ed here because not sure if build_requires works)
    },
    build_requires => {
        "Module::Build"   => 0,  # needed for installing the software
    },
);

$build->create_build_script;

