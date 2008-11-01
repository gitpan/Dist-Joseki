package Dist::Joseki::Find;

use strict;
use warnings;
use File::Find;


our $VERSION = '0.17';


use base qw(Dist::Joseki::Base);


sub projroot {
    my $self = shift;
    my @projroot =
        map { s/^~/$ENV{HOME}/; $_ }
        split /\s*;\s*/ =>
        $ENV{PROJROOT};
    wantarray ? @projroot : \@projroot;
}


sub find_dists {
    my ($self, $restrict_path) = @_;

    if (defined $restrict_path) {
        $restrict_path = [ $restrict_path ] unless
            ref $restrict_path eq 'ARRAY'
    } else {
        $restrict_path = [];
    }

    my %restrict_path = map { $_ => 1 } @$restrict_path;  # lookup hash

    my @distro;

    find (sub {
        return unless -d;

        # prune some things first for efficiency reasons - otherwise find() gets
        # quite slow.

        if (/^(\.svn|blib|skel)$/) {
            $File::Find::prune = 1;
            return;
        }

        if (-e "$_/Build.PL" || -e "$_/Makefile.PL") {

            # only remember the distro if there was no path restriction, or if
            # it is within the restrict_path specs

            if (@$restrict_path == 0 || exists $restrict_path{$_}) {
                push @distro => $File::Find::name;
            }

            # but prune anyway - we assume there are no distributions below a
            # directory that contains a Build.PL or a Makefile.PL.

            $File::Find::prune = 1;
        }
    }, $self->projroot);

    wantarray ? @distro : \@distro;
}


1;


__END__



=head1 NAME

Dist::Joseki::Find - find distributions within the project roots

=head1 SYNOPSIS

    Dist::Joseki::Find->new;

=head1 DESCRIPTION

None yet.

=head1 METHODS

=over 4



=back

Dist::Joseki::Find inherits from L<Dist::Joseki::Base>.

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
site near you. Or see <http://www.perl.com/CPAN/authors/id/M/MA/MARCEL/>.

=head1 AUTHORS

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2007-2008 by the authors.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

