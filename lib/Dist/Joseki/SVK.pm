package Dist::Joseki::SVK;

use strict;
use warnings;
use Module::Changes;
use Dist::Joseki::SVK::Status;


our $VERSION = '0.15';


use base qw(Dist::Joseki::Base);


__PACKAGE__->mk_scalar_accessors(qw(tag_base changes_filename));


sub dist_current_version_is_tagged {
    my $self = shift;

    $self->assert_is_dist_base_dir;

    my $changes =
        Module::Changes->make_object_for_type('parser_yaml')
        ->parse_from_file($self->changes_filename);

    my $version = $changes->newest_release->version;
    my $name    = $changes->name;

    $self->svk_has_tagged_version($name, $version);
}


sub svk_has_tagged_version {
    my ($self, $name, $version) = @_;

    unless ($self->{svk_tag_cache}) {
        my @tags = $self->read_from_cmd('svk ls ' . $self->tag_base);
        chomp @tags;
        s{/$}{} for @tags;
        $self->{svk_tag_cache}{$_} = 1 for @tags;
    }

    exists $self->{svk_tag_cache}{"$name-$version"};
}


sub status {
    my $self = shift;
    chomp(my @status = $self->read_from_cmd('svk status'));

    my $status = Dist::Joseki::SVK::Status->new;

    for my $status_line (@status) {
        my ($type, $file);
        if ($status_line =~ /^(.)\s+(.*)/) {
            ($type, $file) = ($1, $2);
        } else {
            die "can't parse svk status line:\n$status_line\n";
        }

        next if $file =~ /\.swp$/;

        if ($type eq 'M') {
            $status->modified_push($file);
        } elsif ($type eq 'A') {
            $status->added_push($file);
        } elsif ($type eq 'D') {
            $status->deleted_push($file);
        } elsif ($type eq '?') {
            $status->unversioned_push($file);
        } else {
            die "unknown svk status in line:$status_line\n"
        }
    }
    $status;
}


sub add {
    my ($self, @files) = @_;
    my $files = join ' ' => @files;
    $self->safe_system("svk add $files");
}


1;


__END__



=head1 NAME

Dist::Joseki::SVK - Class to interact with svk

=head1 SYNOPSIS

    Dist::Joseki::SVK->new;

=head1 DESCRIPTION

None yet.

=head1 METHODS

=over 4

=item changes_filename

    my $value = $obj->changes_filename;
    $obj->changes_filename($value);

A basic getter/setter method. If called without an argument, it returns the
value. If called with a single argument, it sets the value.

=item changes_filename_clear

    $obj->changes_filename_clear;

Clears the value.

=item clear_changes_filename

    $obj->clear_changes_filename;

Clears the value.

=item clear_tag_base

    $obj->clear_tag_base;

Clears the value.

=item tag_base

    my $value = $obj->tag_base;
    $obj->tag_base($value);

A basic getter/setter method. If called without an argument, it returns the
value. If called with a single argument, it sets the value.

=item tag_base_clear

    $obj->tag_base_clear;

Clears the value.

=back

Dist::Joseki::SVK inherits from L<Dist::Joseki::Base>.

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

