use inc::Module::Install;
name 'Dist-Joseki';
all_from 'lib/Dist/Joseki.pm';
perl_version '5.006';

requires 'Class::Accessor::Complex';
requires 'File::Slurp';
requires 'Getopt::Attribute';
requires 'Test::TAP::HTMLMatrix';
requires 'Template';
requires 'YAML';

build_requires 'Test::More' => '0.70';

install_script glob('bin/*');

use_standard_tests(without => 'pod_coverage');
auto_include;
WriteAll;
