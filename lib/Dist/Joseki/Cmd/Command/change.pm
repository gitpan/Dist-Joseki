package Dist::Joseki::Cmd::Command::change;

use strict;
use warnings;
use Dist::Joseki::SVK;
use Dist::Joseki::Version;
use File::Temp 'tempfile';
use IO::Prompt;
use ShipIt::Conf;


our $VERSION = '0.15';


use base 'Dist::Joseki::Cmd::Command';


__PACKAGE__->mk_concat_accessors(qw(commit_msg));


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

        [
            'tag|t=s',
            'the tag to add (optional)',
            { default => '' },
        ],

        [
            'message|m=s@',
            'change message to add',
            { default => [] },
        ],

        [
            'dir|d=s@',
            'directories in which to set the version number',
            { default => $cmd_config->{dir} || [ qw(bin lib) ] },
        ],
    );
}


sub validate {
    my $self = shift;
    $self->SUPER::validate(@_);
    die "--tagbase is mandatory\n" unless $self->opt_has_value('tagbase');
}


sub format_message {
    my ($self, $text) = @_;

    $text =~ s/^ *| *$//g;

    my $result = '';
    my $line = my $indent = '  ';
        
    for my $word (split /\s+/ => $text) {
        if (length($line) + 1 + length($word) > 75) {
            $result .= "$line\n";
            $line = $indent . $word;
        } else {
            $line .= ' ' if $line =~ /\S/;
            $line .= $word;
        } 
    }   
    $result .= "$line\n";
    substr($result, 0, 1) = '-';
    $result;
}


sub add_message {
    my ($self, $changes, $message) = @_;
    $changes->newest_release->changes_push($message);
    $self->commit_msg($self->format_message($message));
}


sub get_commit_header {
    my $self = shift;
    my $shipit_conf = ShipIt::Conf->parse('.shipit');
    my $commit_header = $shipit_conf->value('commit.header');
    return '' unless defined $commit_header;
    chomp $commit_header;
    "$commit_header\n";
}


sub run {
    my $self = shift;

    $self->SUPER::run(@_);
    $self->assert_is_dist_base_dir;

    $self->clear_commit_msg;
    $self->commit_msg('');

    my $changes = Module::Changes->make_object_for_type('parser_yaml')
        ->parse_from_file($self->opt('file'));

    my $svk = Dist::Joseki::SVK->new(
        tag_base         => $self->opt('tagbase'),
        changes_filename => $self->opt('file'),
    );

    if ($svk->dist_current_version_is_tagged) {
        $changes->add_new_version;
        my $version = $changes->newest_release->version;
        Dist::Joseki::Version->new->
            set_version($version, @{ $self->opt('dir') || [] });

        $self->add_message($changes, "set the version to $version");
    }

    $self->add_message($changes, $_) for @{ $self->opt('message') || [] };

    # BEGIN svk status handling

    my $status = $svk->status;

    my %modified = map { $_ => 1 } $status->modified;

    # simple change, don't require a --message for that
    if (defined $modified{MANIFEST}) {
        $self->add_message($changes, "updated MANIFEST");
        delete $modified{MANIFEST};
    }

    die "need --message because there are files with svk status 'M'\n"
        if (keys %modified) && (@{ $self->opt('message') || [] } == 0);

    if ($status->unversioned_count) {
        print "There are unversioned files:\n";
        print "    $_\n" for $status->unversioned;
        if (prompt -YN, "Do you want to 'svk add' them?") {
            $svk->add($status->unversioned);
            $self->add_message($changes, "added $_") for $status->unversioned;
        }
    }

    $self->add_message($changes, "added $_")   for $status->added;
    $self->add_message($changes, "deleted $_") for $status->deleted;

    # END svk status handling

    $changes->newest_release->tags_push($self->opt('tag')) if
        $self->opt_has_value('tag');
    $changes->newest_release->touch_date;

    Module::Changes->make_object_for_type('formatter_yaml')
       ->format_to_file($changes, $self->opt('file'));

    my ($fh, $filename) = tempfile();
    my $commit_header = $self->get_commit_header;
    print $fh $commit_header if length $commit_header;
    print $fh $self->commit_msg;
    close $fh or die "can't close tempfile $filename: $!\n";

    $self->safe_system("svk commit -F $filename");
}


1;


__END__



=head1 NAME

Dist::Joseki::Cmd::Command::change - 'change' command for Dist::Joseki::Cmd

=head1 SYNOPSIS

    Dist::Joseki::Cmd::Command::change->new;

=head1 DESCRIPTION

None yet.

=head1 METHODS

=over 4

=item clear_commit_msg

    $obj->clear_commit_msg;

Clears the value.

=item commit_msg

    my $value = $obj->commit_msg;
    $obj->commit_msg($value);

A getter/setter method. If called without an argument, it returns the
value. If called with a single argument, it appends to the current value.

=item commit_msg_clear

    $obj->commit_msg_clear;

Clears the value.

=back

Dist::Joseki::Cmd::Command::change inherits from
L<Dist::Joseki::Cmd::Command>.

The superclass L<Dist::Joseki::Cmd::Command> defines these methods and
functions:

    args(), args_clear(), args_count(), args_index(), args_pop(),
    args_push(), args_set(), args_shift(), args_splice(), args_unshift(),
    clear_args(), clear_opt(), count_args(), delete_opt(), exists_opt(),
    index_args(), keys_opt(), opt(), opt_clear(), opt_delete(),
    opt_exists(), opt_has_value(), opt_keys(), opt_spec(), opt_values(),
    pop_args(), push_args(), set_args(), shift_args(), splice_args(),
    unshift_args(), validate_args(), values_opt()

The superclass L<App::Cmd::Command> defines these methods and functions:

    new(), _option_processing_params(), _usage_text(), abstract(), app(),
    command_names(), prepare(), usage(), usage_desc(), usage_error()

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

