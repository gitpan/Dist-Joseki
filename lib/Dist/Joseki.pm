package Dist::Joseki;

use warnings;
use strict;
use Dist::Joseki::DistType;


our $VERSION = '0.06';


sub get_dist_type { Dist::Joseki::DistType->new }


1;


__END__

=head1 NAME

Dist::Joseki - tools for the prolific module author

=head1 SYNOPSIS

=head1 DESCRIPTION

"Joseki" is a japanese term from the game Go and means "a formulaic sequence
of moves which is established for giving equal outcomes to both players", but
it has come into general use to describe any fixed form of behaviour.

Dist::Joseki offers you tools that help you in developing Perl module
distributions if you stick to a certain formulaic style of structuring your
distributions.

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

