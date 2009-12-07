package Dist::Joseki::DistType;
use warnings;
use strict;
use Dist::Joseki::DistType::ModuleBuild;
use Dist::Joseki::DistType::MakeMaker;
our $VERSION = '0.18';

sub new {
    my $class = shift;
    return Dist::Joseki::DistType::ModuleBuild->new if -e "Build.PL";
    return Dist::Joseki::DistType::MakeMaker->new   if -e "Makefile.PL";
    die "Can't determine dist type. Is this a perl distribution root dir?\n";
}
1;
__END__



=head1 NAME

Dist::Joseki::DistType - Distribution type class wrapper

=head1 SYNOPSIS

    Dist::Joseki::DistType->new;

=head1 DESCRIPTION

None yet. This is an early release; fully functional, but undocumented. The
next release will have more documentation.

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

