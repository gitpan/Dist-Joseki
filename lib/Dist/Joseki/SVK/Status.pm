package Dist::Joseki::SVK::Status;

use strict;
use warnings;
use Module::Changes;


our $VERSION = '0.01';


use base qw(Dist::Joseki::Base);


__PACKAGE__->mk_array_accessors(qw(added deleted modified unversioned));


1;


__END__



=head1 NAME

Dist::Joseki::SVK::Status - Class to represents result of 'svk status'

=head1 SYNOPSIS

    Dist::Joseki::SVK::Status->new;

=head1 DESCRIPTION

None yet.

Dist::Joseki::SVK::Status inherits from L<Dist::Joseki::Base>.

The superclass L<Dist::Joseki::Base> defines these methods and functions:

    new(), assert_is_dist_base_dir(), bool_prompt(), print_header(),
    read_from_cmd(), safe_system()

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

=item added

    my @values    = $obj->added;
    my $array_ref = $obj->added;
    $obj->added(@values);
    $obj->added($array_ref);

Get or set the array values. If called without an arguments, it returns the
array in list context, or a reference to the array in scalar context. If
called with arguments, it expands array references found therein and sets the
values.

=item added_clear

    $obj->added_clear;

Deletes all elements from the array.

=item added_count

    my $count = $obj->added_count;

Returns the number of elements in the array.

=item added_index

    my $element   = $obj->added_index(3);
    my @elements  = $obj->added_index(@indices);
    my $array_ref = $obj->added_index(@indices);

Takes a list of indices and returns the elements indicated by those indices.
If only one index is given, the corresponding array element is returned. If
several indices are given, the result is returned as an array in list context
or as an array reference in scalar context.

=item added_pop

    my $value = $obj->added_pop;

Pops the last element off the array, returning it.

=item added_push

    $obj->added_push(@values);

Pushes elements onto the end of the array.

=item added_set

    $obj->added_set(1 => $x, 5 => $y);

Takes a list of index/value pairs and for each pair it sets the array element
at the indicated index to the indicated value. Returns the number of elements
that have been set.

=item added_shift

    my $value = $obj->added_shift;

Shifts the first element off the array, returning it.

=item added_splice

    $obj->added_splice(2, 1, $x, $y);
    $obj->added_splice(-1);
    $obj->added_splice(0, -1);

Takes three arguments: An offset, a length and a list.

Removes the elements designated by the offset and the length from the array,
and replaces them with the elements of the list, if any. In list context,
returns the elements removed from the array. In scalar context, returns the
last element removed, or C<undef> if no elements are removed. The array grows
or shrinks as necessary. If the offset is negative then it starts that far
from the end of the array. If the length is omitted, removes everything from
the offset onward. If the length is negative, removes the elements from the
offset onward except for -length elements at the end of the array. If both the
offset and the length are omitted, removes everything. If the offset is past
the end of the array, it issues a warning, and splices at the end of the
array.

=item added_unshift

    $obj->added_unshift(@values);

Unshifts elements onto the beginning of the array.

=item clear_added

    $obj->clear_added;

Deletes all elements from the array.

=item clear_deleted

    $obj->clear_deleted;

Deletes all elements from the array.

=item clear_modified

    $obj->clear_modified;

Deletes all elements from the array.

=item clear_unversioned

    $obj->clear_unversioned;

Deletes all elements from the array.

=item count_added

    my $count = $obj->count_added;

Returns the number of elements in the array.

=item count_deleted

    my $count = $obj->count_deleted;

Returns the number of elements in the array.

=item count_modified

    my $count = $obj->count_modified;

Returns the number of elements in the array.

=item count_unversioned

    my $count = $obj->count_unversioned;

Returns the number of elements in the array.

=item deleted

    my @values    = $obj->deleted;
    my $array_ref = $obj->deleted;
    $obj->deleted(@values);
    $obj->deleted($array_ref);

Get or set the array values. If called without an arguments, it returns the
array in list context, or a reference to the array in scalar context. If
called with arguments, it expands array references found therein and sets the
values.

=item deleted_clear

    $obj->deleted_clear;

Deletes all elements from the array.

=item deleted_count

    my $count = $obj->deleted_count;

Returns the number of elements in the array.

=item deleted_index

    my $element   = $obj->deleted_index(3);
    my @elements  = $obj->deleted_index(@indices);
    my $array_ref = $obj->deleted_index(@indices);

Takes a list of indices and returns the elements indicated by those indices.
If only one index is given, the corresponding array element is returned. If
several indices are given, the result is returned as an array in list context
or as an array reference in scalar context.

=item deleted_pop

    my $value = $obj->deleted_pop;

Pops the last element off the array, returning it.

=item deleted_push

    $obj->deleted_push(@values);

Pushes elements onto the end of the array.

=item deleted_set

    $obj->deleted_set(1 => $x, 5 => $y);

Takes a list of index/value pairs and for each pair it sets the array element
at the indicated index to the indicated value. Returns the number of elements
that have been set.

=item deleted_shift

    my $value = $obj->deleted_shift;

Shifts the first element off the array, returning it.

=item deleted_splice

    $obj->deleted_splice(2, 1, $x, $y);
    $obj->deleted_splice(-1);
    $obj->deleted_splice(0, -1);

Takes three arguments: An offset, a length and a list.

Removes the elements designated by the offset and the length from the array,
and replaces them with the elements of the list, if any. In list context,
returns the elements removed from the array. In scalar context, returns the
last element removed, or C<undef> if no elements are removed. The array grows
or shrinks as necessary. If the offset is negative then it starts that far
from the end of the array. If the length is omitted, removes everything from
the offset onward. If the length is negative, removes the elements from the
offset onward except for -length elements at the end of the array. If both the
offset and the length are omitted, removes everything. If the offset is past
the end of the array, it issues a warning, and splices at the end of the
array.

=item deleted_unshift

    $obj->deleted_unshift(@values);

Unshifts elements onto the beginning of the array.

=item index_added

    my $element   = $obj->index_added(3);
    my @elements  = $obj->index_added(@indices);
    my $array_ref = $obj->index_added(@indices);

Takes a list of indices and returns the elements indicated by those indices.
If only one index is given, the corresponding array element is returned. If
several indices are given, the result is returned as an array in list context
or as an array reference in scalar context.

=item index_deleted

    my $element   = $obj->index_deleted(3);
    my @elements  = $obj->index_deleted(@indices);
    my $array_ref = $obj->index_deleted(@indices);

Takes a list of indices and returns the elements indicated by those indices.
If only one index is given, the corresponding array element is returned. If
several indices are given, the result is returned as an array in list context
or as an array reference in scalar context.

=item index_modified

    my $element   = $obj->index_modified(3);
    my @elements  = $obj->index_modified(@indices);
    my $array_ref = $obj->index_modified(@indices);

Takes a list of indices and returns the elements indicated by those indices.
If only one index is given, the corresponding array element is returned. If
several indices are given, the result is returned as an array in list context
or as an array reference in scalar context.

=item index_unversioned

    my $element   = $obj->index_unversioned(3);
    my @elements  = $obj->index_unversioned(@indices);
    my $array_ref = $obj->index_unversioned(@indices);

Takes a list of indices and returns the elements indicated by those indices.
If only one index is given, the corresponding array element is returned. If
several indices are given, the result is returned as an array in list context
or as an array reference in scalar context.

=item modified

    my @values    = $obj->modified;
    my $array_ref = $obj->modified;
    $obj->modified(@values);
    $obj->modified($array_ref);

Get or set the array values. If called without an arguments, it returns the
array in list context, or a reference to the array in scalar context. If
called with arguments, it expands array references found therein and sets the
values.

=item modified_clear

    $obj->modified_clear;

Deletes all elements from the array.

=item modified_count

    my $count = $obj->modified_count;

Returns the number of elements in the array.

=item modified_index

    my $element   = $obj->modified_index(3);
    my @elements  = $obj->modified_index(@indices);
    my $array_ref = $obj->modified_index(@indices);

Takes a list of indices and returns the elements indicated by those indices.
If only one index is given, the corresponding array element is returned. If
several indices are given, the result is returned as an array in list context
or as an array reference in scalar context.

=item modified_pop

    my $value = $obj->modified_pop;

Pops the last element off the array, returning it.

=item modified_push

    $obj->modified_push(@values);

Pushes elements onto the end of the array.

=item modified_set

    $obj->modified_set(1 => $x, 5 => $y);

Takes a list of index/value pairs and for each pair it sets the array element
at the indicated index to the indicated value. Returns the number of elements
that have been set.

=item modified_shift

    my $value = $obj->modified_shift;

Shifts the first element off the array, returning it.

=item modified_splice

    $obj->modified_splice(2, 1, $x, $y);
    $obj->modified_splice(-1);
    $obj->modified_splice(0, -1);

Takes three arguments: An offset, a length and a list.

Removes the elements designated by the offset and the length from the array,
and replaces them with the elements of the list, if any. In list context,
returns the elements removed from the array. In scalar context, returns the
last element removed, or C<undef> if no elements are removed. The array grows
or shrinks as necessary. If the offset is negative then it starts that far
from the end of the array. If the length is omitted, removes everything from
the offset onward. If the length is negative, removes the elements from the
offset onward except for -length elements at the end of the array. If both the
offset and the length are omitted, removes everything. If the offset is past
the end of the array, it issues a warning, and splices at the end of the
array.

=item modified_unshift

    $obj->modified_unshift(@values);

Unshifts elements onto the beginning of the array.

=item pop_added

    my $value = $obj->pop_added;

Pops the last element off the array, returning it.

=item pop_deleted

    my $value = $obj->pop_deleted;

Pops the last element off the array, returning it.

=item pop_modified

    my $value = $obj->pop_modified;

Pops the last element off the array, returning it.

=item pop_unversioned

    my $value = $obj->pop_unversioned;

Pops the last element off the array, returning it.

=item push_added

    $obj->push_added(@values);

Pushes elements onto the end of the array.

=item push_deleted

    $obj->push_deleted(@values);

Pushes elements onto the end of the array.

=item push_modified

    $obj->push_modified(@values);

Pushes elements onto the end of the array.

=item push_unversioned

    $obj->push_unversioned(@values);

Pushes elements onto the end of the array.

=item set_added

    $obj->set_added(1 => $x, 5 => $y);

Takes a list of index/value pairs and for each pair it sets the array element
at the indicated index to the indicated value. Returns the number of elements
that have been set.

=item set_deleted

    $obj->set_deleted(1 => $x, 5 => $y);

Takes a list of index/value pairs and for each pair it sets the array element
at the indicated index to the indicated value. Returns the number of elements
that have been set.

=item set_modified

    $obj->set_modified(1 => $x, 5 => $y);

Takes a list of index/value pairs and for each pair it sets the array element
at the indicated index to the indicated value. Returns the number of elements
that have been set.

=item set_unversioned

    $obj->set_unversioned(1 => $x, 5 => $y);

Takes a list of index/value pairs and for each pair it sets the array element
at the indicated index to the indicated value. Returns the number of elements
that have been set.

=item shift_added

    my $value = $obj->shift_added;

Shifts the first element off the array, returning it.

=item shift_deleted

    my $value = $obj->shift_deleted;

Shifts the first element off the array, returning it.

=item shift_modified

    my $value = $obj->shift_modified;

Shifts the first element off the array, returning it.

=item shift_unversioned

    my $value = $obj->shift_unversioned;

Shifts the first element off the array, returning it.

=item splice_added

    $obj->splice_added(2, 1, $x, $y);
    $obj->splice_added(-1);
    $obj->splice_added(0, -1);

Takes three arguments: An offset, a length and a list.

Removes the elements designated by the offset and the length from the array,
and replaces them with the elements of the list, if any. In list context,
returns the elements removed from the array. In scalar context, returns the
last element removed, or C<undef> if no elements are removed. The array grows
or shrinks as necessary. If the offset is negative then it starts that far
from the end of the array. If the length is omitted, removes everything from
the offset onward. If the length is negative, removes the elements from the
offset onward except for -length elements at the end of the array. If both the
offset and the length are omitted, removes everything. If the offset is past
the end of the array, it issues a warning, and splices at the end of the
array.

=item splice_deleted

    $obj->splice_deleted(2, 1, $x, $y);
    $obj->splice_deleted(-1);
    $obj->splice_deleted(0, -1);

Takes three arguments: An offset, a length and a list.

Removes the elements designated by the offset and the length from the array,
and replaces them with the elements of the list, if any. In list context,
returns the elements removed from the array. In scalar context, returns the
last element removed, or C<undef> if no elements are removed. The array grows
or shrinks as necessary. If the offset is negative then it starts that far
from the end of the array. If the length is omitted, removes everything from
the offset onward. If the length is negative, removes the elements from the
offset onward except for -length elements at the end of the array. If both the
offset and the length are omitted, removes everything. If the offset is past
the end of the array, it issues a warning, and splices at the end of the
array.

=item splice_modified

    $obj->splice_modified(2, 1, $x, $y);
    $obj->splice_modified(-1);
    $obj->splice_modified(0, -1);

Takes three arguments: An offset, a length and a list.

Removes the elements designated by the offset and the length from the array,
and replaces them with the elements of the list, if any. In list context,
returns the elements removed from the array. In scalar context, returns the
last element removed, or C<undef> if no elements are removed. The array grows
or shrinks as necessary. If the offset is negative then it starts that far
from the end of the array. If the length is omitted, removes everything from
the offset onward. If the length is negative, removes the elements from the
offset onward except for -length elements at the end of the array. If both the
offset and the length are omitted, removes everything. If the offset is past
the end of the array, it issues a warning, and splices at the end of the
array.

=item splice_unversioned

    $obj->splice_unversioned(2, 1, $x, $y);
    $obj->splice_unversioned(-1);
    $obj->splice_unversioned(0, -1);

Takes three arguments: An offset, a length and a list.

Removes the elements designated by the offset and the length from the array,
and replaces them with the elements of the list, if any. In list context,
returns the elements removed from the array. In scalar context, returns the
last element removed, or C<undef> if no elements are removed. The array grows
or shrinks as necessary. If the offset is negative then it starts that far
from the end of the array. If the length is omitted, removes everything from
the offset onward. If the length is negative, removes the elements from the
offset onward except for -length elements at the end of the array. If both the
offset and the length are omitted, removes everything. If the offset is past
the end of the array, it issues a warning, and splices at the end of the
array.

=item unshift_added

    $obj->unshift_added(@values);

Unshifts elements onto the beginning of the array.

=item unshift_deleted

    $obj->unshift_deleted(@values);

Unshifts elements onto the beginning of the array.

=item unshift_modified

    $obj->unshift_modified(@values);

Unshifts elements onto the beginning of the array.

=item unshift_unversioned

    $obj->unshift_unversioned(@values);

Unshifts elements onto the beginning of the array.

=item unversioned

    my @values    = $obj->unversioned;
    my $array_ref = $obj->unversioned;
    $obj->unversioned(@values);
    $obj->unversioned($array_ref);

Get or set the array values. If called without an arguments, it returns the
array in list context, or a reference to the array in scalar context. If
called with arguments, it expands array references found therein and sets the
values.

=item unversioned_clear

    $obj->unversioned_clear;

Deletes all elements from the array.

=item unversioned_count

    my $count = $obj->unversioned_count;

Returns the number of elements in the array.

=item unversioned_index

    my $element   = $obj->unversioned_index(3);
    my @elements  = $obj->unversioned_index(@indices);
    my $array_ref = $obj->unversioned_index(@indices);

Takes a list of indices and returns the elements indicated by those indices.
If only one index is given, the corresponding array element is returned. If
several indices are given, the result is returned as an array in list context
or as an array reference in scalar context.

=item unversioned_pop

    my $value = $obj->unversioned_pop;

Pops the last element off the array, returning it.

=item unversioned_push

    $obj->unversioned_push(@values);

Pushes elements onto the end of the array.

=item unversioned_set

    $obj->unversioned_set(1 => $x, 5 => $y);

Takes a list of index/value pairs and for each pair it sets the array element
at the indicated index to the indicated value. Returns the number of elements
that have been set.

=item unversioned_shift

    my $value = $obj->unversioned_shift;

Shifts the first element off the array, returning it.

=item unversioned_splice

    $obj->unversioned_splice(2, 1, $x, $y);
    $obj->unversioned_splice(-1);
    $obj->unversioned_splice(0, -1);

Takes three arguments: An offset, a length and a list.

Removes the elements designated by the offset and the length from the array,
and replaces them with the elements of the list, if any. In list context,
returns the elements removed from the array. In scalar context, returns the
last element removed, or C<undef> if no elements are removed. The array grows
or shrinks as necessary. If the offset is negative then it starts that far
from the end of the array. If the length is omitted, removes everything from
the offset onward. If the length is negative, removes the elements from the
offset onward except for -length elements at the end of the array. If both the
offset and the length are omitted, removes everything. If the offset is past
the end of the array, it issues a warning, and splices at the end of the
array.

=item unversioned_unshift

    $obj->unversioned_unshift(@values);

Unshifts elements onto the beginning of the array.

=back

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<distjoseki> tag.

=head1 VERSION 
                   
This document describes version 0.01 of L<Dist::Joseki::SVK::Status>.

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

