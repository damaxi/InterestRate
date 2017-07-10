use Configs;
use DecreasingInstallmentRole;
use ConstantInstallmentRole;
use Terminal::ANSIColor;

class InterestCalculator does DecreasingInstallment does ConstantInstallment {
  has $.initial_loan;
  has $.bank_margin;
  has $.planned_years;

  method !calculateTotalRatePercent {
    $!bank_margin + WIBOR3M
  }

  method printConstantInstallment {
    my ($montly, $total) := self.calculateConstantInstallment($!initial_loan, self!calculateTotalRatePercent, $!planned_years);
    say color('bold red'), "Constant Installment", color('reset');
    say color('bold yellow'), "Whole monthly amount: ", $montly, color('reset');
    say color('bold green'), "Total repayment: ", $total, color('reset');
  }

  method printDecreasingInstallment {
    my ($capital_part, @month_remainings_interests) := self.calculateDecreasingInstallment($!initial_loan, self!calculateTotalRatePercent, $!planned_years);
    say color('bold red'), "Decreasing Installment", color('reset');
    say color('green'), "Constant capital part: ", $capital_part, color('reset');
    my $total_bank_interests = 0;
    for @month_remainings_interests {
      my ($month, $remaining_capital, $interest_part) = $_;
      $total_bank_interests += $interest_part;
      say "Year: ", ($month / 12).round, " Month: ", $month, ": ",
      		color('bold red'), "Remaining capital: ", $remaining_capital.round(0.01),
      		color('bold blue'), "\t", "Interest part: ", $interest_part.round(0.01),
      		color('bold yellow'), "\t", "Whole amount: ", $capital_part + $interest_part, color('reset');
    }
    say color('green'), "Total interests: ", $total_bank_interests.round, "\t",
    		"Total repayment: ", ($total_bank_interests + $!initial_loan).round;
  }

  method print {
    say "Total loan: " ~ $!initial_loan;
    say "Interest percent: " ~ self!calculateTotalRatePercent;
    say "Planned years: " ~ $!planned_years;
    say "";
  }
}
