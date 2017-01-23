# MonitorFtracepairlatency.pm
package MMTests::MonitorFtracepairlatency;
use MMTests::MonitorFtrace;
our @ISA = qw(MMTests::MonitorFtrace);
use strict;

my ($regex_default_start, $regex_default_end);
my ($regex_start, $regex_end);
my ($tracepoint_start, $tracepoint_end);
my $name_start;
my $start_timestamp;
my %latencyState;

use constant LATENCY_START	=> 0;
use constant LATENCY_END	=> 1;
use constant LATENCY_STALLED	=> 2;

sub add_regex_start($$$)
{
	my ($tracepoint, $def);

	my $self = shift @_;
	my $tracepoint = shift @_;
	my $def = shift @_;

	$tracepoint_start = $tracepoint;
	$tracepoint_start =~ s/.*\///;

	$regex_start = $self->generate_traceevent_regex($tracepoint, $def, @_);
}
	
sub add_regex_end($$$)
{
	my ($tracepoint, $def);

	my $self = shift @_;
	my $tracepoint = shift @_;
	my $def = shift @_;

	$tracepoint_end = $tracepoint;
	$tracepoint_end =~ s/.*\///;

	$regex_end = $self->generate_traceevent_regex($tracepoint, $def, @_);
}

sub ftraceInit {
	my $self = shift @_;
	my @ftraceCounters;
	my %perprocessStats;

	%latencyState = ();

	$self->{_FieldLength} = 16;
	$self->{_FtraceCounters} = \@ftraceCounters;
	$self->{_PerProcessStats} = \%perprocessStats;
}

sub ftraceCallback {
	my ($self, $timestamp_ms, $pid, $process, $tracepoint, $details) = @_;
	my $ftraceCounterRef = $self->{_FtraceCounters};
	my $perprocessRef = $self->{_PerProcessStats};
	my $pidprocess = "$pid-$process";

	if ($tracepoint eq $tracepoint_start) {
		if ($details !~ /$regex_start/p) {
			print "WARNING: Failed to parse $tracepoint as expected\n";
			print "	 $details\n";
			print "	 $regex_start\n";
			return;
		}

		$latencyState{$pidprocess} = $timestamp_ms;
		if ($self->{_StartTimestamp} == 0) {
			$self->{_StartTimestamp} = $timestamp_ms / 1000;
		}
	} elsif ($tracepoint eq $tracepoint_end) {
		if ($details !~ /$/p) {
			print "WARNING: Failed to parse $tracepoint_end as expected\n";
			print "	 $details\n";
			print "	 $regex_end\n";
			return;
		}

		# Check how long the process was stalled
		my $delayed = 0;
		if ($latencyState{$pidprocess}) {
			$delayed = $timestamp_ms - $latencyState{$pidprocess};
			if ($delayed > 0) {
				push @{$self->{_ResultData}}, [ $latencyState{$pidprocess} - ($self->{_StartTimestamp} * 1000), $delayed ];
				# printf "END:   %16s $pid %16s $delayed\n", $timestamp_ms, $process;
			}
		}
		$latencyState{$pidprocess} = 0;

	}
}

sub extractSummary() {
	my $self = shift @_;
	$self->SUPER::extractSummary();
}

1;
