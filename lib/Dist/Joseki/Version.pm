package Dist::Joseki::Version;
use strict;
use warnings;
use File::Find;
use File::Slurp;
our $VERSION = '0.20';
use base qw(Dist::Joseki::Base);

sub set_version {
    my ($self, $version, @dir) = @_;
    $self->assert_is_dist_base_dir;
    find(
        sub {
            if ($_ eq '.svn' || $_ eq '.git') {
                $File::Find::prune = 1;
                return;
            }
            return unless -f && -r;
            return if /\.swp$/;
            my $contents = read_file($_);
            if ($contents =~ s/(\$VERSION\s*=\s*([\'\"]))(.+?)\2/$1$version$2/)
            {
                open my $fh, '>', $_
                  or die "can't open $File::Find::name for writing: $!\n";
                print $fh $contents;
                close $fh or die "can't close $File::Find::name: $!\n";
            } else {
                warn "$File::Find::name: no \$VERSION line\n";
            }
        },
        grep {
            -d $_
          } @dir
    );
}
1;
__END__



=head1 NAME

Dist::Joseki::Version - Get and set version numbers within the distribution

=head1 SYNOPSIS

    Dist::Joseki::Version->new;

=head1 DESCRIPTION

None yet.

=head1 METHODS

=over 4



=back

Dist::Joseki::Version inherits from L<Dist::Joseki::Base>.

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

