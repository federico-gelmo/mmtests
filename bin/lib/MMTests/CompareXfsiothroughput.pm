# CompareXfsiothroughput.pm
package MMTests::CompareXfsiothroughput;
use MMTests::Compare;
our @ISA = qw(MMTests::Compare);

sub new() {
	my $class = shift;
	my $self = {
		_ModuleName  => "CompareXfsiothroughput",
		_CompareOp   => "pdiff",
	};
	bless $self, $class;
	return $self;
}

1;
