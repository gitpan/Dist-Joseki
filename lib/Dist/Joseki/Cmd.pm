package Dist::Joseki::Cmd;

use strict;
use warnings;
use YAML 'LoadFile';
use Data::Rmap;


our $VERSION = '0.17';


use base 'App::Cmd';


sub config {
    my $app = shift;
    my $config_file = "$ENV{HOME}/.distrc";
    if (-e $config_file && -r $config_file) {
        $app->{config} ||= LoadFile($config_file);
        rmap { s/^~/$ENV{HOME}/ } $app->{config};
    }
    $app->{config} = {} unless defined $app->{config};
    $app->{config};
}


1;


__END__



=head1 NAME

Dist::Joseki::Cmd - Application class for 'dist' program

=head1 SYNOPSIS

    Dist::Joseki::Cmd->new;

=head1 DESCRIPTION

None yet.

=head1 METHODS

=over 4



=back

Dist::Joseki::Cmd inherits from L<App::Cmd>.

The superclass L<App::Cmd> defines these methods and functions:

    new(), _bad_command(), _cmd_from_args(), _command(),
    _global_option_processing_params(), _load_default_plugin(),
    _module_pluggable_options(), _plugin_prepare(), _plugins(),
    _prepare_command(), _prepare_default_command(), _usage_text(),
    command_names(), command_plugins(), default_command(),
    execute_command(), get_command(), global_opt_spec(), global_options(),
    plugin_for(), plugin_search_path(), prepare_command(), run(),
    set_global_options(), usage(), usage_desc(), usage_error()

The superclass L<App::Cmd::ArgProcessor> defines these methods and
functions:

    _process_args()

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit <http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see <http://www.perl.com/CPAN/authors/id/M/MA/MARCEL/>.

=head1 AUTHORS

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2007-2008 by the authors.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

