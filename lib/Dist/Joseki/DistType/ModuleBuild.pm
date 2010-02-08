package Dist::Joseki::DistType::ModuleBuild;
use warnings;
use strict;
use base 'Dist::Joseki::DistType::Base';
our $VERSION = '0.19';

sub is_built {
    my $self = shift;
    -e 'Build';
}

sub ACTION_build {
    my $self = shift;
    return if $self->is_built;
    $self->safe_system($^X, 'Build.PL');
}

sub ACTION_default {
    my $self = shift;
    $self->depends_on('build');
    $self->safe_system($^X, 'Build');
}

sub ACTION_distclean {
    my $self = shift;
    return unless $self->is_built;
    $self->safe_system($^X, 'Build', 'distclean');
}

sub ACTION_disttest {
    my $self = shift;
    $self->depends_on('default');
    $self->safe_system($^X, 'Build', 'test');
}

sub ACTION_distinstall {
    my $self = shift;
    $self->depends_on('disttest');
    $self->safe_system('sudo', $^X, 'Build', 'install');
}

sub ACTION_manifest {
    my $self = shift;
    $self->depends_on('build');
    unlink 'MANIFEST';
    $self->safe_system($^X, 'Build', 'manifest');
}
1;
__END__



=head1 NAME

Dist::Joseki::DistType::ModuleBuild - Distribution type class for Module::Build distributions

=head1 SYNOPSIS

    Dist::Joseki::DistType::ModuleBuild->new;

=head1 DESCRIPTION

None yet. This is an early release; fully functional, but undocumented. The
next release will have more documentation.

=head1 METHODS

=over 4



=back

Dist::Joseki::DistType::ModuleBuild inherits from
L<Dist::Joseki::DistType::Base>.

The superclass L<Dist::Joseki::DistType::Base> defines these methods and
functions:

    _call_action(), depends_on(), finish()

The superclass L<Dist::Joseki::Base> defines these methods and functions:

    new(), assert_is_dist_base_dir(), print_header(), read_from_cmd(),
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

