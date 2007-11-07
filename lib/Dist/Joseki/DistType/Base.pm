package Dist::Joseki::DistType::Base;

use warnings;
use strict;


our $VERSION = '0.04';


use base 'Class::Accessor::Complex';
__PACKAGE__->mk_new;


sub system {
    my ($self, @args) = @_;
    system(@args) == 0 or die "system @args failed: $?";
}


sub _call_action {
    my ($self, $action) = @_;
    return if $self->{_completed_actions}{$action}++;

    local $self->{action} = $action;
    my $method = "ACTION_$action";
    $self->$method; 
}


sub depends_on {
    my ($self, @depend) = @_;
    $self->_call_action($_) for @depend;
}


sub finish {
    my $self = shift;
    $self->ACTION_distclean;
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

