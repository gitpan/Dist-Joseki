package Dist::Joseki::Base;

use strict;
use warnings;
use Term::ReadLine ();


our $VERSION = '0.01';


use base qw(Class::Accessor::Complex);


__PACKAGE__->mk_new;


our $term = Term::ReadLine->new("prompt");


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


sub bool_prompt {
    my ($self, $question, $default) = @_;
    $default = uc($default || "");
    die "bogus default" unless $default =~ /^[YN]?$/;
    my $opts = " [y/n]";
    $opts = " [Y/n]" if $default eq "Y";
    $opts = " [y/N]" if $default eq "N";

    my $to_bool = sub {
        my $yn = shift;
        return 1 if $yn =~ /^y/i;
        return 0 if $yn =~ /^n/i;
        return;
    };

    while (1) {
        my $ans = $term->readline("$question$opts ");
        my $bool = $to_bool->($ans || $default);
        return $bool if defined $bool;
        warn "Please answer 'y' or 'n'\n";
    }
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

Dist::Joseki::Base inherits from L<Class::Accessor::Complex>.

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

=item new

    my $obj = Dist::Joseki::Base->new;
    my $obj = Dist::Joseki::Base->new(%args);

Creates and returns a new object. The constructor will accept as arguments a
list of pairs, from component name to initial value. For each pair, the named
component is initialized by calling the method of the same name with the given
value. If called with a single hash reference, it is dereferenced and its
key/value pairs are set as described before.

=back

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<distjoseki> tag.

=head1 VERSION 
                   
This document describes version 0.01 of L<Dist::Joseki::Base>.

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

