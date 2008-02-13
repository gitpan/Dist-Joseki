package Dist::Joseki::Cmd::Command::tagcheck;

use strict;
use warnings;
use Dist::Joseki::SVK;


our $VERSION = '0.12';


use base 'Dist::Joseki::Cmd::Multiplexable';


sub usage_desc { 'tagcheck %o' }


sub options {
    my ($self, $app, $cmd_config) = @_;
    return (
        $self->SUPER::options($app, $cmd_config),
        [
            'tagbase|b=s',
            'depot path where tagged versions are',
            { default => $cmd_config->{tagbase} },
        ],

        [
            'file|f=s',
            'location of the Changes file',
            { default => $cmd_config->{file} || 'Changes' },
        ],
    );
}


sub run_single {
    my $self = shift;

    $self->SUPER::run_single(@_);

    my $svk = Dist::Joseki::SVK->new(
        tag_base         => $self->opt('tagbase'),
        changes_filename => $self->opt('file'),
    );

    if ($svk->dist_current_version_is_tagged) {
        print "Current version is tagged\n";
    } else {
        print "Current version is not tagged\n";
    }
}


sub hook_in_dist_loop_begin {
    my ($self, $dist) = @_;
    $self->SUPER::hook_in_dist_loop_begin($dist);
    $dist =~ s!.*/!!;
    print "$dist: ";
}


1;


__END__



=head1 NAME

Dist::Joseki::Cmd::Command::tagcheck - 'tagcheck' command for Dist::Joseki::Cmd

=head1 SYNOPSIS

    Dist::Joseki::Cmd::Command::tagcheck->new;

=head1 DESCRIPTION

None yet.

=head1 METHODS

=over 4



=back

Dist::Joseki::Cmd::Command::tagcheck inherits from
L<Dist::Joseki::Cmd::Multiplexable>.

The superclass L<Dist::Joseki::Cmd::Multiplexable> defines these methods
and functions:

    hook_after_dist_loop(), hook_before_dist_loop(),
    hook_in_dist_loop_end(), run()

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

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<distjoseki> tag.

=head1 VERSION 
                   
This document describes version 0.12 of L<Dist::Joseki::Cmd::Command::tagcheck>.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<<bug-dist-joseki@rt.cpan.org>>, or through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit <http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see <http://www.perl.com/CPAN/authors/id/M/MA/MARCEL/>.

=head1 AUTHOR

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2007-2008 by Marcel GrE<uuml>nauer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut
