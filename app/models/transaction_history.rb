class TransactionHistory < ApplicationRecord

  belongs_to :account
  
  enum transaction_type: { contribution: 0, deposit: 1, transfer: 2}

  def reverse code=nil
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
      account.contribute(-amount, code)
      update reversible: false
      true
    else
      false
    end
  end

  def reverse_deposit
    account.deposit(-amount)
    update reversible: false
    true
  end
  
  def reverse_transfer
    source_account = Account.find(source_account_id)
    source_account.transfer(-amount, source_account)
    update reversible: false
    true
  end

end
