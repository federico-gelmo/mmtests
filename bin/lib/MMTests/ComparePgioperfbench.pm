# ComparePgioperfbench.pm
package MMTests::ComparePgioperfbench;
use MMTests::Compare;
our @ISA = qw(MMTests::Compare);

sub new() {
	my $class = shift;
	my $self = {
		_ModuleName  => "ComparePgioperfbench",
	};
	bless $self, $class;
	return $self;
}

1;
