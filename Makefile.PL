use inc::Module::Install;
include 'Module::AutoInstall';

name 'Dist-Joseki';
all_from 'lib/Dist/Joseki.pm';
perl_version '5.006';

requires 'App::Cmd';
requires 'Class::Accessor::Complex';
requires 'Data::Rmap';
requires 'Error';
requires 'File::Basename';
requires 'File::Copy';
requires 'File::Path';
requires 'File::Slurp';
requires 'Getopt::Attribute';
requires 'IO::Prompt';
requires 'Module::Changes';
requires 'Module::CoreList';
requires 'Module::ExtractUse';
requires 'Parse::CPAN::Packages';
requires 'Perl::Version';
requires 'ShipIt';
requires 'Test::TAP::HTMLMatrix';
requires 'Text::Diff';
requires 'Template';
requires 'URI';
requires 'Web::Scraper';
requires 'YAML';

recommends 'Test::Pod';
recommends 'Test::Pod::Coverage';

test_requires 'Test::More' => '0.70';
test_requires 'Test::Compile';

install_script glob('bin/*');

auto_install;
auto_include;
WriteAll;
