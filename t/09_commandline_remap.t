#!/usr/bin/perl -w

use strict;
use lib qw(t/lib);
use Test::More tests => 1;
use TestAppBuild;
use Config;

clean_install();
set_module_dir( 't/Bar' );
run_build_pl( '--install_base', '../test_install/remapped_cmdline',
              '--install_path', 'libdoc=moo',
              );
run_build();
run_build( 'install' );

check_tree( 't/test_install/remapped_cmdline',
            { 'lib/perl/MyBar.pm' => {},
              'bin/program'       => { executable => 1 },
              ( $^O eq 'MSWin32' ) ?
                  ( 'bin/program.bat' => { executable => 1 } ) :
                  ( ),
              'lib/perl/MyPod.pm' => {},
              "moo/MyPod.$Config{man3ext}" => {},
              ( $Config{installhtmldir} ) ?
                  ( "html/site/lib/MyPod.html" => {} ) :
                  ( ),
              } );
