package Dist::Joseki::Base;
use strict;
use warnings;
our $VERSION = '0.19';
use base qw(Class::Accessor::Complex);
__PACKAGE__->mk_new;

sub read_from_cmd {
    my ($self, $cmd) = @_;
    open my $fh, '-|', $cmd or die "can't read from pipe $cmd: $!\n";
    my @result = <$fh>;
    close $fh;
    wantarray ? @result : join '' => @result;
}

sub safe_system {
    my ($self, @args) = @_;
    system(@args) == 0 or die "system @args failed: $?";
}

sub assert_is_dist_base_dir {
    my $self = shift;
    die "Looks like this is not a distribution base directory\n"
      unless -e 'Makefile.PL' || -e 'Build.PL';
}

sub print_header {
    my ($self, $text) = @_;
    1 while chomp $text;
    print "\n", '-' x 75, "\n";
    print "$text\n";
    print '-' x 75, "\n\n";
}
1;
__END__



=head1 NAME

Dist::Joseki::Base - Base class for Dist::Joseki classes

=head1 SYNOPSIS

    Dist::Joseki::Base->new;

=head1 DESCRIPTION

None yet.

=head1 METHODS

=over 4

=item C<new>

    my $obj = Dist::Joseki::Base->new;
    my $obj = Dist::Joseki::Base->new(%args);

Creates and returns a new object. The constructor will accept as arguments a
list of pairs, from component name to initial value. For each pair, the named
component is initialized by calling the method of the same name with the given
value. If called with a single hash reference, it is dereferenced and its
key/value pairs are set as described before.

=back

Dist::Joseki::Base inherits from L<Class::Accessor::Complex>.

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

