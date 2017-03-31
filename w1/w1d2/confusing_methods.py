def return_number(a)
  ((a / 2)**2) * (65 - (a / 2))
end

def child_bank_acct_at_retirement(my_age)
  child_age_estimate = my_age / 2
  child_bank_acct_estimate = child_age_estimate**2
  child_years_left_until_retirement = 65 - child_age_estimate


  child_bank_acct_estimate * child_years_left_until_retirement
end
puts child_bank_acct_at_retirement(30)
puts child_bank_acct_at_retirement(50)
