use inc::Module::Install;
include 'Module::AutoInstall';

name 'Dist-Joseki';
all_from 'lib/Dist/Joseki.pm';
perl_version '5.006';

requires 'App::Cmd';
requires 'Class::Accessor::Complex';
requires 'Data::Rmap';
requires 'File::Basename';
requires 'File::Copy';
requires 'File::Path';
requires 'File::Slurp';
requires 'Getopt::Attribute';
requires 'Module::Changes';
requires 'Module::CoreList';
requires 'Module::ExtractUse';
requires 'Parse::CPAN::Packages';
requires 'Perl::Version';
requires 'Test::TAP::HTMLMatrix';
requires 'Template';
requires 'YAML';

build_requires 'Test::More' => '0.70';

install_script glob('bin/*');

process_templates(
    first_year => 2007,
    rest_from  => "$ENV{HOME}/.mitlib/standard_pod",
    start_tag  => '{%',
    end_tag    => '%}',
);

use_standard_tests(without => 'pod_coverage');
auto_install;
auto_include;
WriteAll;
