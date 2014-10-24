package Dist::Joseki::DistType::ModuleBuild;

use warnings;
use strict;

use base 'Dist::Joseki::DistType::Base';

our $VERSION = '0.07';


sub is_built {
    my $self = shift;
    -e 'Build';
}


sub ACTION_build {
    my $self = shift;
    return if $self->is_built;
    $self->system('perl', 'Build.PL');
}


sub ACTION_distclean {
    my $self = shift;
    return unless $self->is_built;
    $self->system('perl', 'Build', 'distclean');
}


sub ACTION_disttest {
    my $self = shift;
    $self->depends_on('build');
    $self->system('perl', 'Build', 'test');
}


sub ACTION_distinstall {
    my $self = shift;
    $self->depends_on('disttest');
    $self->system('sudo', 'perl', 'Build', 'install');
}


sub ACTION_manifest {
    my $self = shift;
    $self->depends_on('build');
    unlink 'MANIFEST';
    $self->system('perl', 'Build', 'manifest');
}


1;


__END__

=head1 NAME

Dist::Joseki - tools for the prolific module author

=head1 SYNOPSIS

None yet (see below).

=head1 DESCRIPTION

None yet. This is an early release; fully functional, but undocumented. The
next release will have more documentation.

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<distjoseki> tag.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-dist-joseki@rt.cpan.org>, or through the web interface at
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

