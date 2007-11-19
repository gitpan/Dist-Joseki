package Dist::Joseki::Cmd::Command;

use strict;
use warnings;


our $VERSION = '0.09';


use base qw(App::Cmd::Command Dist::Joseki::Base);


__PACKAGE__
    ->mk_array_accessors(qw(args))
    ->mk_hash_accessors(qw(opt));


sub opt_spec {
    my ($self, $app) = @_;
    my ($name) = $self->command_names;
    my $cmd_config = $app->config->{$name};

    return (
        [ 'help|h' => 'This usage screen' ],
        $self->options($app, $cmd_config),
    )
}


sub options { () }


sub opt_has_value {
    my ($self, $key) = @_;
    my $value = $self->opt($key);
    defined($value) && length($value);
}


sub validate_args {
    my ($self, $opt, $args) = @_;

    die $self->_usage_text if $opt->{help};

    $self->opt(%{ $opt || {} });
    $self->args(@{ $args || [] });

    $self->validate;
}


sub validate {}
sub run      {}


1;


__END__



=head1 NAME

Dist::Joseki::Cmd::Command - Base class for Dist::Joseki::Cmd commands

=head1 SYNOPSIS

    Dist::Joseki::Cmd::Command->new;

=head1 DESCRIPTION

None yet.

Dist::Joseki::Cmd::Command inherits from L<App::Cmd::Command> and
L<Dist::Joseki::Base>.

The superclass L<App::Cmd::Command> defines these methods and functions:

    new(), _option_processing_params(), _usage_text(), abstract(), app(),
    command_names(), prepare(), usage(), usage_desc(), usage_error()

The superclass L<App::Cmd::ArgProcessor> defines these methods and
functions:

    _process_args()

The superclass L<Dist::Joseki::Base> defines these methods and functions:

    assert_is_dist_base_dir(), bool_prompt(), print_header(),
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

=item args

    my @values    = $obj->args;
    my $array_ref = $obj->args;
    $obj->args(@values);
    $obj->args($array_ref);

Get or set the array values. If called without an arguments, it returns the
array in list context, or a reference to the array in scalar context. If
called with arguments, it expands array references found therein and sets the
values.

=item args_clear

    $obj->args_clear;

Deletes all elements from the array.

=item args_count

    my $count = $obj->args_count;

Returns the number of elements in the array.

=item args_index

    my $element   = $obj->args_index(3);
    my @elements  = $obj->args_index(@indices);
    my $array_ref = $obj->args_index(@indices);

Takes a list of indices and returns the elements indicated by those indices.
If only one index is given, the corresponding array element is returned. If
several indices are given, the result is returned as an array in list context
or as an array reference in scalar context.

=item args_pop

    my $value = $obj->args_pop;

Pops the last element off the array, returning it.

=item args_push

    $obj->args_push(@values);

Pushes elements onto the end of the array.

=item args_set

    $obj->args_set(1 => $x, 5 => $y);

Takes a list of index/value pairs and for each pair it sets the array element
at the indicated index to the indicated value. Returns the number of elements
that have been set.

=item args_shift

    my $value = $obj->args_shift;

Shifts the first element off the array, returning it.

=item args_splice

    $obj->args_splice(2, 1, $x, $y);
    $obj->args_splice(-1);
    $obj->args_splice(0, -1);

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

=item args_unshift

    $obj->args_unshift(@values);

Unshifts elements onto the beginning of the array.

=item clear_args

    $obj->clear_args;

Deletes all elements from the array.

=item clear_opt

    $obj->clear_opt;

Deletes all keys and values from the hash.

=item count_args

    my $count = $obj->count_args;

Returns the number of elements in the array.

=item delete_opt

    $obj->delete_opt(@keys);

Takes a list of keys and deletes those keys from the hash.

=item exists_opt

    if ($obj->exists_opt($key)) { ... }

Takes a key and returns a true value if the key exists in the hash, and a
false value otherwise.

=item index_args

    my $element   = $obj->index_args(3);
    my @elements  = $obj->index_args(@indices);
    my $array_ref = $obj->index_args(@indices);

Takes a list of indices and returns the elements indicated by those indices.
If only one index is given, the corresponding array element is returned. If
several indices are given, the result is returned as an array in list context
or as an array reference in scalar context.

=item keys_opt

    my @keys = $obj->keys_opt;

Returns a list of all hash keys in no particular order.

=item opt

    my %hash     = $obj->opt;
    my $hash_ref = $obj->opt;
    my $value    = $obj->opt($key);
    my @values   = $obj->opt([ qw(foo bar) ]);
    $obj->opt(%other_hash);
    $obj->opt(foo => 23, bar => 42);

Get or set the hash values. If called without arguments, it returns the hash
in list context, or a reference to the hash in scalar context. If called
with a list of key/value pairs, it sets each key to its corresponding value,
then returns the hash as described before.

If called with exactly one key, it returns the corresponding value.

If called with exactly one array reference, it returns an array whose elements
are the values corresponding to the keys in the argument array, in the same
order. The resulting list is returned as an array in list context, or a
reference to the array in scalar context.

If called with exactly one hash reference, it updates the hash with the given
key/value pairs, then returns the hash in list context, or a reference to the
hash in scalar context.

=item opt_clear

    $obj->opt_clear;

Deletes all keys and values from the hash.

=item opt_delete

    $obj->opt_delete(@keys);

Takes a list of keys and deletes those keys from the hash.

=item opt_exists

    if ($obj->opt_exists($key)) { ... }

Takes a key and returns a true value if the key exists in the hash, and a
false value otherwise.

=item opt_keys

    my @keys = $obj->opt_keys;

Returns a list of all hash keys in no particular order.

=item opt_values

    my @values = $obj->opt_values;

Returns a list of all hash values in no particular order.

=item pop_args

    my $value = $obj->pop_args;

Pops the last element off the array, returning it.

=item push_args

    $obj->push_args(@values);

Pushes elements onto the end of the array.

=item set_args

    $obj->set_args(1 => $x, 5 => $y);

Takes a list of index/value pairs and for each pair it sets the array element
at the indicated index to the indicated value. Returns the number of elements
that have been set.

=item shift_args

    my $value = $obj->shift_args;

Shifts the first element off the array, returning it.

=item splice_args

    $obj->splice_args(2, 1, $x, $y);
    $obj->splice_args(-1);
    $obj->splice_args(0, -1);

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

=item unshift_args

    $obj->unshift_args(@values);

Unshifts elements onto the beginning of the array.

=item values_opt

    my @values = $obj->values_opt;

Returns a list of all hash values in no particular order.

=back

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<distjoseki> tag.

=head1 VERSION 
                   
This document describes version 0.09 of L<Dist::Joseki::Cmd::Command>.

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

