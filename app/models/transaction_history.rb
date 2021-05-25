class TransactionHistory < ApplicationRecord

  belongs_to :account
  
  enum transaction_type: { contribution: 0, deposit: 1, transfer: 2}

  def reverse_transaction code=nil
    if reversible
      if contribution?
        send("reverse_#{transaction_type}", code)
      else
        send("reverse_#{transaction_type}")
      end
    else
      false
    end
  end

  def reverse_contribution code=nil
    if self.contribution_code == code
      self.account.update(balance: account.balance - amount)
      update reversible: false
    else
      false
    end
  end

  def reverse_deposit
    self.account.update(balance: account.balance - amount)
    update reversible: false

  end
  
  def reverse_transfer
    source_account = Account.find(source_account_id)
    source_account.update balance: source_account.balance + amount
    self.account.update balance: account.balance - amount
    update reversible: false
  end

end
