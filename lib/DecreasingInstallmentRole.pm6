=begin comment
decreasing installment
capital part = initial amount / installment quantity overall
interest part = remaining capital part  * interest on a year basis % / installment year quantity
=end comment

use Configs;

role DecreasingInstallment {
  method calculateDecreasingInstallment(Int $initial_loan, Rat $total_rate_percent, Int $planned_years) {
  	my $capital_part = $initial_loan / ($planned_years * AnnualInterestNumber);
  	my $remaining_capital = $initial_loan;
  	my $month = 0;
  	my $interest_part;
  	my $total_bank_interests = 0;
		my @month_remainings_interests;
  	while ($remaining_capital) {
  		$month += 1;
  		$interest_part = $remaining_capital * $total_rate_percent / 100 / AnnualInterestNumber;
  		$total_bank_interests += $interest_part;
  		# say "Year: ", ($month / 12).round, " Month: ", $month, ": ",
  		# 		color('bold red'), "Remaining capital: ", $remaining_capital.round(0.01),
  		# 		color('bold blue'), "\t", "Interest part: ", $interest_part.round(0.01),
  		# 		color('bold yellow'), "\t", "Whole amount: ", $capital_part + $interest_part, color('reset');
  		$remaining_capital -= $capital_part;
			@month_remainings_interests.push: ($month, $remaining_capital, $interest_part);
  	}

		return $capital_part, @month_remainings_interests
  	# say color('green'), "Total interests: ", $total_bank_interests.round, "\t",
  	# 		"Total repayment: ", ($total_bank_interests + $initial_loan).round;
  }
}
