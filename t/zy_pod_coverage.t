#!/usr/bin/perl -w

use strict;
use Test::More;
eval "use Test::Pod::Coverage 1.00";
plan skip_all => "Test::Pod::Coverage 1.00 required for testing POD coverage"
  if $@;
plan( tests => 1 );
pod_coverage_ok( 'App::Build', { coverage_class => 'Pod::Coverage::CountParents' } );
