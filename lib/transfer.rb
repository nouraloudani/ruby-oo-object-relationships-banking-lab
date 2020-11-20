class Transfer

  attr_reader :sender, :receiver, :amount
  attr_accessor :status
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction  
    if self.status == "complete" || sender.balance < self.amount || !self.valid?
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    else 
      sender.balance -= amount 
      receiver.balance += amount
      self.status = "complete"
    end    
  end

  def reverse_transfer
    # receiver sending back to sender
    if self.execute_transaction
      receiver.balance -= amount
      sender.balance += amount
      self.status = "reversed"
    else 
      "Can't reverse transfer."
    end
  end
end
