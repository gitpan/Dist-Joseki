package Dist::Joseki::Cmd::Command::version;
use strict;
use warnings;
use Dist::Joseki::Version;
our $VERSION = '0.18';
use base 'Dist::Joseki::Cmd::Command';
sub usage_desc { 'version %o' }

sub options {
    my ($self, $app, $cmd_config) = @_;
    return (
        $self->SUPER::options($app, $cmd_config),
        [ 'version|v=s', 'new version number', ],
        [   'file|f=s',
            'location of the Changes file',
            { default => $cmd_config->{file} || 'Changes' },
        ],
        [ 'sync|s', 'use most recent version number from Changes file', ],
        [   'dir|d=s@',
            'directories in which to set the version number',
            { default => $cmd_config->{dir} || [qw(bin lib)] },
        ],
    );
}

sub validate {
    my $self = shift;
    $self->SUPER::validate(@_);

    # either --sync or a --version number will do
    if (defined $self->opt('sync')) {
        die "can't use --sync together with --version\n"
          if defined $self->opt('version');
        $self->opt(
            version => Dist::Joseki::Version->new->get_newest_version(
                $self->opt('file')
            ),
        );
    } else {
        die "Version number is missing; use --version or -v\n"
          unless defined $self->opt('version');
    }
}

sub run {
    my $self = shift;
    $self->SUPER::run(@_);
    $self->assert_is_dist_base_dir;
    Dist::Joseki::Version->new->set_version($self->opt('version'),
        @{ $self->opt('dir') || [] });
}
1;
__END__



=head1 NAME

Dist::Joseki::Cmd::Command::version - 'version' command for Dist::Joseki::Cmd

=head1 SYNOPSIS

    Dist::Joseki::Cmd::Command::version->new;

=head1 DESCRIPTION

None yet.

=head1 METHODS

=over 4



=back

Dist::Joseki::Cmd::Command::version inherits from
L<Dist::Joseki::Cmd::Command>.

The superclass L<Dist::Joseki::Cmd::Command> defines these methods and
functions:

    args(), args_clear(), args_count(), args_index(), args_pop(),
    args_push(), args_set(), args_shift(), args_splice(), args_unshift(),
    clear_args(), clear_opt(), count_args(), delete_opt(), exists_opt(),
    index_args(), keys_opt(), opt(), opt_clear(), opt_delete(),
    opt_exists(), opt_has_value(), opt_keys(), opt_spec(), opt_values(),
    pop_args(), push_args(), set_args(), shift_args(), splice_args(),
    unshift_args(), validate_args(), values_opt()

The superclass L<App::Cmd::Command> defines these methods and functions:

    new(), _option_processing_params(), _usage_text(), abstract(), app(),
    command_names(), prepare(), usage(), usage_error()

The superclass L<App::Cmd::ArgProcessor> defines these methods and
functions:

    _process_args()

The superclass L<Dist::Joseki::Base> defines these methods and functions:

    assert_is_dist_base_dir(), print_header(), read_from_cmd(),
    safe_system()

The superclass L<Class::Accessor::Complex> defines these methods and
functions:

    mk_abstract_accessors(), mk_array_accessors(), mk_boolean_accessors(),
    mk_class_array_accessors(), mk_class_hash_accessors(),
    mk_class_scalar_accessors(), mk_concat_accessors(),
    mk_forward_accessors(), mk_hash_accessors(), mk_integer_accessors(),
    mk_new(), mk_object_accessors(), mk_scalar_accessors(),
    mk_set_accessors(), mk_singleton()

The superclass L<Class::Accessor> defines these methods and functions:

    _carp(), _croak(), _mk_accessors(), accessor_name_for(),
    best_practice_accessor_name_for(), best_practice_mutator_name_for(),
    follow_best_practice(), get(), make_accessor(), make_ro_accessor(),
    make_wo_accessor(), mk_accessors(), mk_ro_accessors(),
    mk_wo_accessors(), mutator_name_for(), set()

The superclass L<Class::Accessor::Installer> defines these methods and
functions:

    install_accessor()

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit <http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see L<http://search.cpan.org/dist/Dist-Joseki/>.

=head1 AUTHORS

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2007-2009 by the authors.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

