use lib 'lib';
use InterestCalculator;

sub MAIN($initial_loan, $bank_margin, $planned_years) {
	my $calculator = InterestCalculator.new(initial_loan => $initial_loan,
																					bank_margin => $bank_margin,
																					planned_years => $planned_years);
  $calculator.print;
	$calculator.printConstantInstallment;
	$calculator.printDecreasingInstallment;
}

sub USAGE() {
	say "Usage: <loan> <interest percent> <years>"
}
