
use App::Build;

my $build = App::Build->new (
    dist_name         => "Foo",
    dist_version      => "0.99",
    dist_author       => "stephen.adkins\@officevision.com",
    dist_abstract     => "A test Build.PL",
    license           => "perl",
    requires => {
        "App::Options"   => 0,  # needed for option parsing
    },
    build_requires => {
        "App::Build"     => 0,  # needed for installing the software
        "Module::Build"  => 0,  # needed for installing the software
        "File::Spec"     => 0,  # platform-neutral directory processing
    },
    extra_dirs => [ "cgi-bin", "htdocs", ],
    dynamic_config => 1,
);

$build->create_build_script;

