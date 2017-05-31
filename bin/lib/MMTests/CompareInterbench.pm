# CompareInterbench.pm
package MMTests::CompareInterbench;
use MMTests::Compare;
our @ISA = qw(MMTests::Compare);

sub new() {
	my $class = shift;
	my $self = {
		_ModuleName  => "CompareInterbench",
		_CompareOp   => "pndiff",
		_Precision   => 4,
	};
	bless $self, $class;
	return $self;
}

1;
