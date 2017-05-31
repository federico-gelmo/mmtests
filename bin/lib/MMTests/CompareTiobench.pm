# CompareTiobench.pm
package MMTests::CompareTiobench;
use MMTests::Compare;
our @ISA = qw(MMTests::Compare);

sub new() {
	my $class = shift;
	my $self = {
		_ModuleName  => "CompareTiobench",
		_CompareOp   => "pdiff",
	};
	bless $self, $class;
	return $self;
}

1;
