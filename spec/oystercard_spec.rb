require 'oystercard'

describe Oystercard do

  it "has balance of 0 by default" do
    expect(subject.balance).to eq 0
  end 

  it "can top up" do
    subject.top_up(10)
    expect(subject.balance).to eq 10
  end

  it "raises an error when topping up more than £90" do
    subject.balance = 70
    expect { subject.top_up(100) }.to raise_error "You cannot go beyond the limit of £#{Oystercard::LIMIT}."
  end

  it "reduces the balance" do
    subject.balance = 70
    subject.deduct(10)
    expect(subject.balance).to eq 60
  end

  it "returns true when the customer touches in" do
    subject.balance = 2
    subject.touch_in
    expect(subject.in_use).to be_truthy
  end

  it "returns false when the customer touches out" do
    subject.touch_out
    expect(subject.in_use).to be_falsy
  end

  it "confirms when the customer is on a journey" do
    subject.balance = 2
    subject.touch_in
    expect(subject.in_journey?).to be_truthy
  end

  it "confirms when the customer has finished their journey" do
    subject.touch_out
    expect(subject.in_journey?).to be_falsy
  end

  it "raises an error if the balance is less than £1 on touch in" do
    subject.balance = 0
    expect { subject.touch_in }.to raise_error "You do not have sufficient funds to make this journey"
  end

end