=begin comment
capital part = initial credit / installment quantity overall
interest part = remaining capital part  * interest on a year basis % / installment year quantity
=end comment

use Terminal::ANSIColor;

constant AnnualInterestNumber = 12;
constant WIBOR3M = 1.73; # 1.73

sub decreasing_installment_printer(Int $initial_total_loan, Rat $interest_percent, Int $planned_years) {
	my $capital_part = $initial_total_loan / ($planned_years * AnnualInterestNumber);
	say color('green'), "Constant capital part: ", $capital_part, color('reset');
	my $remaining_capital = $initial_total_loan;
	my $total_rate_percent = $interest_percent + WIBOR3M;
	say color('green'), "Total interest percent: ", $total_rate_percent, color('reset');
	my $month = 0;
	my $interest_part;
	my $total_bank_interests = 0;
	while ($remaining_capital) {
		$month += 1;
		$interest_part = $remaining_capital * $total_rate_percent / 100 / 12;
		$total_bank_interests += $interest_part;
		say "Year: ", ($month / 12).round, " Month: ", $month, ": ",
				color('bold red'), "Remaining capital: ", $remaining_capital.round(0.01),
				color('bold blue'), "\t", "Interest part: ", $interest_part.round(0.01),
				color('bold yellow'), "\t", "Whole amount: ", $capital_part + $interest_part, color('reset');
		$remaining_capital -= $capital_part;
	}
	say color('green'), "Total interests: ", $total_bank_interests.round, "\t",
			"Total repayment: ", ($total_bank_interests + $initial_total_loan).round;
}

sub MAIN($initial_total_loan, $interest_percent, $planned_years) {
	say "Total loan: " ~ $initial_total_loan;
	say "Interest percent: " ~ $interest_percent;
	say "Planned years: " ~ $planned_years;
	decreasing_installment_printer($initial_total_loan, $interest_percent, $planned_years)
}

sub USAGE() {
	say "Usage: <loan> <interest percent> <years>"
}
