package Dist::Joseki::Cmd::Command::depends;

use strict;
use warnings;
use Cwd;
use File::Find;
use File::Slurp;
use Module::CoreList;
use Module::ExtractUse;
use Parse::CPAN::Packages;
use Perl::Version;


our $VERSION = '0.10';


use base 'Dist::Joseki::Cmd::Multiplexable';


sub options {
    my ($self, $app, $cmd_config) = @_;
    return (
        $self->SUPER::options($app, $cmd_config),

        [
            'cpan|c=s',
            'only print one requirement per CPAN distribution; value is location of 02packages.details.txt.gz file',
            { default => '' },
        ],
        [
            'version|v=s',
            'assuming the given perl version, only print non-core requirements',
            { default => '' },
        ],
    );
}


sub get_primary_package_from_dist {
    my ($self, $parser, $dist_prefix) = @_;

    return $1 if $dist_prefix =~ /\/(perl-[\d\.]+)\.tar\.gz$/;

    my $distribution = $parser->distribution($dist_prefix);

    my @dist_packages =
        sort { length($a) <=> length($b) }
        map { $_->package }
        @{ $distribution->packages || [] };

    $dist_packages[0];
}


sub restrict_to_CPAN_distributions {
    my ($self, @packages) = @_;
    return @packages unless $self->opt_has_value('cpan');

    my @result;
    my %dist_seen;

    my $parser = Parse::CPAN::Packages->new($self->opt('cpan'));

    for my $package (@packages) {
        my $pkg_obj = $parser->package($package);

        # if there is no such package in any CPAN distribution, just add it as
        # a requirement

        unless (defined $pkg_obj) {
            push @result => $package;
            next;
        }

        # use the distribution object's prefix() as a hash key because we can
        # get back to the distribution from that

        $dist_seen{ $pkg_obj->distribution->prefix }++;
    }

    push @result =>
        map { $self->get_primary_package_from_dist($parser, $_) }
        sort keys %dist_seen;

    @result;
}


sub get_core_list_version_string {
    my ($self, $version) = @_;

    # Module::CoreList expects 5.6.0 as 5.006, but Perl::Version would return
    # 5.006000, so chop off any subversion 0.

    $version =~ s/^(\d.\d+)\.0$/$1/;
    Perl::Version->new($version)->numify;
}


sub restrict_to_non_core_modules {
    my ($self, @packages) = @_;
    return @packages unless $self->opt_has_value('version');

    my $core_list = $Module::CoreList::version{
        $self->get_core_list_version_string($self->opt('version'))
    };

    unless (defined $core_list) {
        warn sprintf "no core module list for perl version %s, skipping\n",
            $self->opt('version');
        return @packages;
    }

    grep { ! exists $core_list->{$_} } @packages;
}


sub run_single {
    my $self = shift;

    $self->SUPER::run_single(@_);
    $self->assert_is_dist_base_dir;

    my %modules;
    my %packages;

    find(sub {
        return unless -f && /\.pm$/;
        my $source = read_file($_);

        my $p = Module::ExtractUse->new;
        $p->extract_use(\$source);
        @modules{ $p->array } = ();

        my @packages = ($source =~ /^package\s*(\w+(?:::\w+)*)\s*;/gsm);
        @packages{@packages} = ();
    }, getcwd());

    # packages found in this distribution aren't external requirements
    delete @modules{ keys %packages };

    print "$_\n" for
        $self->restrict_to_CPAN_distributions(
            $self->restrict_to_non_core_modules(
                sort keys %modules,
            )
        );

}


1;


__END__



=head1 NAME

Dist::Joseki::Cmd::Command::depends - 'depends' command for Dist::Joseki::Cmd

=head1 SYNOPSIS

    Dist::Joseki::Cmd::Command::depends->new;

=head1 DESCRIPTION

None yet.

Dist::Joseki::Cmd::Command::depends inherits from
L<Dist::Joseki::Cmd::Multiplexable>.

The superclass L<Dist::Joseki::Cmd::Multiplexable> defines these methods
and functions:

    hook_after_dist_loop(), hook_before_dist_loop(),
    hook_in_dist_loop_begin(), hook_in_dist_loop_end(), run()

The superclass L<Dist::Joseki::Cmd::Command> defines these methods and
functions:

    args(), args_clear(), args_count(), args_index(), args_pop(),
    args_push(), args_set(), args_shift(), args_splice(), args_unshift(),
    clear_args(), clear_opt(), count_args(), delete_opt(), exists_opt(),
    index_args(), keys_opt(), opt(), opt_clear(), opt_delete(),
    opt_exists(), opt_has_value(), opt_keys(), opt_spec(), opt_values(),
    pop_args(), push_args(), set_args(), shift_args(), splice_args(),
    unshift_args(), validate(), validate_args(), values_opt()

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
                   
This document describes version 0.10 of L<Dist::Joseki::Cmd::Command::depends>.

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

