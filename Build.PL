#!/usr/bin/perl -w

use Module::Build;
use File::Spec;

my $build = Module::Build->new (
    module_name       => "App::Build",
    dist_author       => [ "Mattia Barbon <mbarbon\@cpan.org>", "spadkins\@gmail.com" ],
    dist_abstract     => "extends Module::Build to build/install/configure entire applications (i.e. web applications), not just modules and programs",
    license           => "perl",
    requires => {
        "App::Options"    => 0,  # configuration
        "File::Spec"      => 0,  # platform-neutral directory manipulation
        "Module::Build"   => 0,  # needed for installing the software (dup'ed here because not sure if build_requires works)
    },
    build_requires => {
        "Module::Build"   => 0.28,  # needed for installing the software
    },
    create_makefile_pl    => 'passthrough',
);

$build->create_build_script;

