=begin comment
constant installment
q factor = 1 + (interest on a year basis % /  installment year quantity)
montly whole amount = initial amount  * q factor ** all month installment quantity *
* (q factor - 1) / (q factor ** all month installment quantity - 1)
=end comment

use Configs;

role ConstantInstallment {
  method calculateConstantInstallment(Int $initial_loan, Rat $total_rate_percent,
                                      Int $planned_years) {
    my $q_factor = 1 + ($total_rate_percent / 100 / AnnualInterestNumber);
    my $total_month = $planned_years * AnnualInterestNumber;
    my $q_factor_aux = $q_factor ** $total_month;
    my $monthly_total =  $initial_loan * $q_factor_aux
                        * ($q_factor - 1) / ($q_factor_aux - 1);
    return $monthly_total, $total_month * $monthly_total
  }
}
