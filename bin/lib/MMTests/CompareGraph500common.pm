# CompareGraph500common.pm
package MMTests::CompareGraph500common;
use VMR::Stat;
use MMTests::Compare;
our @ISA = qw(MMTests::Compare);

sub new() {
	my $class = shift;
	my $self = {
		_ModuleName  => "CompareGraph500",
		_Precision   => 5,
	};
	bless $self, $class;
	return $self;
}

1;
