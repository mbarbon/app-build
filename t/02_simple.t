#!/usr/bin/perl -w

use strict;
use lib qw(t/lib);
use Test::More tests => 1;
use TestAppBuild;
use Config;

clean_install();
set_module_dir( 't/Foo' );
run_build_pl();
run_build();
run_build( 'install' );

check_tree( 't/test_install/simple',
            { 'cgi-bin/foo/foo.cgi'  => { executable => 1 },
              ( $^O eq 'MSWin32' ) ?
                  ( 'cgi-bin/foo/foo.cgi.bat' => { executable => 1 } ) :
                  ( ),
              'cgi-bin/foo/foo.conf' => {},
              'htdocs/index.html'    => {},
              'htdocs/robots.txt'    => {},
              'htdocs/.htaccess'     => {},
              'lib/MyFoo.pm'         => {},
              'lib/MyPod.pm'         => {},
              "man/man3/MyPod.$Config{man3ext}" => {},
              ( $Config{installhtmldir} ) ?
                  ( "html/site/lib/MyPod.html" => {} ) :
                  ( ),
            } );
