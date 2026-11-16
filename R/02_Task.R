#Task-1
loan_amount <-700000
Vehicle_Price <-800000
anual_income <-60000
Down_Payment <- Vehicle_Price-loan_amount
print(Down_Payment)
#Task-2
loan_amount <- 500000
down_payment <- 800000 - loan_amount
loan_amount <- 600000
#options(scipen = 999) tells R to strongly prefer ordinary number formatting over scientific notation. It changes the display preference, not the stored value.
options(scipen = 999)
print(down_payment)
#Task-3
downpay