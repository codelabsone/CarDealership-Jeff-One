class Payments

attr_reader :payment, :sale_price, :int_rate, :months

  def initialize(payment, sale_price=20000, int_rate=0.05, months=60)
    @payment = payment             #payment per months
    @sale_price = sale_price       #sale price
    @int_rate = int_rate           #annual interest int_rate
    @months = months               #length of loan in months
    @eff_rate = eff_rate           #effective interest rate
  end


end

eff_rate = @int_rate / 12
@payment = (eff_rate * @sale_price) / (1 - ((1 + eff_rate)**-@months))
