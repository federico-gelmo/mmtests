# CompareSimoop.pm
package MMTests::CompareSimoop;
use MMTests::Compare;
our @ISA = qw(MMTests::Compare);

sub new() {
	my $class = shift;
	my $self = {
		_ModuleName  => "CompareSimoop",
	};
	bless $self, $class;
	return $self;
}

1;
