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
    my ($montly, $total) = self.calculateConstantInstallment($!initial_loan, self!calculateTotalRatePercent, $!planned_years);
    say color('bold red'), "Constant Installment", color('reset');
    say color('bold yellow'), "Whole monthly amount: ", $montly, color('reset');
    say color('bold green'), "Total repayment: ", $total, color('reset');
  }

  method printDecreasingInstallment {
    my ($capital_part, @month_remainings_interests) = self.calculateDecreasingInstallment($!initial_loan, self!calculateTotalRatePercent, $!planned_years);
    say color('bold red'), "Decreasing Installment", color('reset');
    say color('green'), "Constant capital part: ", $capital_part, color('reset');
  }

  method print {
    say "Total loan: " ~ $!initial_loan;
    say "Interest percent: " ~ self!calculateTotalRatePercent;
    say "Planned years: " ~ $!planned_years;
    say "";
  }
}
