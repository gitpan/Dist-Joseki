package Dist::Joseki::Version;

use strict;
use warnings;
use File::Find;
use File::Slurp;
use Module::Changes;


our $VERSION = '0.11';


use base qw(Dist::Joseki::Base);


sub get_newest_version {
    my ($self, $changes_filename) = @_;

    die "can't find $changes_filename\n" unless -f $changes_filename;
    die "can't read $changes_filename\n" unless -e $changes_filename;

    Module::Changes->make_object_for_type('parser_yaml')
        ->parse_from_file($changes_filename)
        ->newest_release->version
}


sub set_version {
    my ($self, $version, @dir) = @_;
    $self->assert_is_dist_base_dir;

    find(sub {
        return unless -f && -r;
        return if /\.swp$/;
        my $contents = read_file($_);
        if ($contents =~ s/(\$VERSION\s*=\s*([\'\"]))(.+?)\2/$1$version$2/) {
            open my $fh, '>', $_ or
                die "can't open $File::Find::name for writing: $!\n";
            print $fh $contents;
            close $fh or die "can't close $File::Find::name: $!\n";
        } else {
            warn "$File::Find::name: no \$VERSION line\n";
        }
    }, grep { -d $_ } @dir);

}


1;


__END__



=head1 NAME

Dist::Joseki::Version - Get and set version numbers within the distribution

=head1 SYNOPSIS

    Dist::Joseki::Version->new;

=head1 DESCRIPTION

None yet.

Dist::Joseki::Version inherits from L<Dist::Joseki::Base>.

The superclass L<Dist::Joseki::Base> defines these methods and functions:

    new(), assert_is_dist_base_dir(), print_header(), read_from_cmd(),
    safe_system()

The superclass L<Class::Accessor::Complex> defines these methods and
functions:

    carp(), cluck(), croak(), flatten(), mk_abstract_accessors(),
    mk_array_accessors(), mk_boolean_accessors(),
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

    install_accessor(), subname()

=head1 METHODS

=over 4



=back

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<distjoseki> tag.

=head1 VERSION 
                   
This document describes version 0.11 of L<Dist::Joseki::Version>.

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

Copyright 2007 by Marcel GrE<uuml>nauer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

