# CompareLibmicro.pm
package MMTests::CompareLibmicro;
use MMTests::Compare;
our @ISA = qw(MMTests::Compare);

sub new() {
	my $class = shift;
	my $self = {
		_ModuleName  => "CompareLibmicro",
		_CompareOp   => "pndiff",
		_Precision   => 4,
		_CompareOp   => "pndiff",
	};
	bless $self, $class;
	return $self;
}

1;
