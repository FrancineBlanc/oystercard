class Oystercard
  attr_accessor :balance, :in_use
  LIMIT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise "You cannot go beyond the limit of £#{LIMIT}." if amount+balance > LIMIT
    self.balance += amount
  end

  def deduct(amount)
    self.balance -= amount
  end

  def touch_in
    raise "You do not have sufficient funds to make this journey" if balance < MINIMUM
    self.in_use = true
  end

  def touch_out
    self.in_use = false
  end

  def in_journey?
    self.in_use ? true : false
  end

end