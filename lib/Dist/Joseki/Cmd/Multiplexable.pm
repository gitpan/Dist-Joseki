package Dist::Joseki::Cmd::Multiplexable;

use strict;
use warnings;
use Dist::Joseki::Find;
use Error ':try';


our $VERSION = '0.17';


use base qw(Dist::Joseki::Cmd::Command);


sub options {
    my ($self, $app, $cmd_config) = @_;
    return (
        $self->SUPER::options($app, $cmd_config),
        [ 'proj|p'   => 'Repeat this for all distributions in the project' ],
    );
}


sub run {
    my $self = shift;

    $self->SUPER::run(@_);
    if (defined $self->opt('proj')) {

        $self->hook_before_dist_loop;
        for my $dist (Dist::Joseki::Find->new->find_dists) {
                chdir $dist or die "can't chdir to $dist: $!\n";
                $self->hook_in_dist_loop_begin($dist);
                $self->try_single($dist);
                $self->hook_in_dist_loop_end($dist);
        }
        $self->hook_after_dist_loop;
    } else {
        $self->try_single;
    }
}


sub try_single {
    my ($self, $dist) = @_;
    $dist = 'current' unless defined $dist;
    try {
        $self->run_single;
    } catch Error with {
        $self->handle_dist_error($dist, $_[0]);
    };
}


sub handle_dist_error {
    my ($self, $dist, $error) = @_;
    warn "distribution [$dist] had an error:\n$error\n";
}


sub hook_before_dist_loop   {}
sub hook_after_dist_loop    {}
sub hook_in_dist_loop_begin {}
sub hook_in_dist_loop_end   {}
sub run_single              {}


1;


__END__



=head1 NAME

Dist::Joseki::Cmd::Multiplexable - Base class for potentially project-wide commands

=head1 SYNOPSIS

    Dist::Joseki::Cmd::Multiplexable->new;

=head1 DESCRIPTION

None yet.

=head1 METHODS

=over 4



=back

Dist::Joseki::Cmd::Multiplexable inherits from
L<Dist::Joseki::Cmd::Command>.

The superclass L<Dist::Joseki::Cmd::Command> defines these methods and
functions:

    args(), args_clear(), args_count(), args_index(), args_pop(),
    args_push(), args_set(), args_shift(), args_splice(), args_unshift(),
    clear_args(), clear_opt(), count_args(), delete_opt(), exists_opt(),
    index_args(), keys_opt(), opt(), opt_clear(), opt_delete(),
    opt_exists(), opt_has_value(), opt_keys(), opt_spec(), opt_values(),
    pop_args(), push_args(), set_args(), shift_args(), splice_args(),
    unshift_args(), validate(), validate_args(), values_opt()

The superclass L<App::Cmd::Command> defines these methods and functions:

    new(), _option_processing_params(), _usage_text(), abstract(), app(),
    command_names(), prepare(), usage(), usage_desc(), usage_error()

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
site near you. Or see <http://www.perl.com/CPAN/authors/id/M/MA/MARCEL/>.

=head1 AUTHORS

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2007-2008 by the authors.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

