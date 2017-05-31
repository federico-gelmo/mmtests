# CompareFsmarkoverhead.pm
package MMTests::CompareFsmarkoverhead;
use MMTests::Compare;
our @ISA = qw(MMTests::Compare);

sub new() {
	my $class = shift;
	my $self = {
		_ModuleName  => "CompareFsmarkoverhead",
		_CompareOps  => [ "none", "pdiff", "pdiff", "pdiff", "pndiff", "pdiff" ],
		_CompareLength => 6,
	};
	bless $self, $class;
	return $self;
}

1;
