class Account < ApplicationRecord
  
  validates_presence_of :name
  belongs_to :account_owner, polymorphic: true

  has_many :account_connections, foreign_key: :parent_account_id
  has_many :branch_accounts, class_name: 'Account', through: :account_connections, source: :branch_account
  
  has_one :parent_connection, class_name: 'AccountConnection', foreign_key: :branch_account_id
  has_one :parent_account, class_name: 'Account', through: :parent_connection, source: :parent_account

  has_many :transaction_histories

  enum status: { active: 0, locked: 1, canceled: 2}

  def parent?
    parent_account.nil?
  end

  def balance_in_dollars
    balance/100.to_f
  end

  def unlock
    if locked?
      update status: 0
    else
      false
    end
  end

  def contribute amount, code
    errors = verify_transaction({transaction_type: 'contribution', code: code})
    if errors.any?
      errors
    else
      update balance: self.balance + amount
      TransactionHistory.create(amount: amount, account: self, transaction_type: 0, contribution_code: code)
    end
  end

  def deposit amount
    errors = verify_transaction({transaction_type: 'deposit'})
    if errors.any?
      errors
    else
      update balance: self.balance + amount
      TransactionHistory.create(amount: amount, account: self, transaction_type: 1)
    end
  end

  def transfer amount, source_account
    errors = verify_transaction({transaction_type: 'transfer', source_account_id: source_account.id})
    if errors.any?
      errors
    else
      update balance: self.balance + amount
      source_account.update(balance: source_account.balance - amount)
      TransactionHistory.create(amount: amount, account: self, transaction_type: 2, source_account_id: source_account.id)
    end
  end

  def verify_transaction transaction_params
    errors = []
    errors << "Your account is locked." if self.locked?
    errors << "Your account has been canceled." if self.canceled?
    case transaction_params[:transaction_type]
    when 'contribution'
      errors << "Your account is a branch account and can't receive contributions." unless self.parent?
    when 'deposit'
      errors << "Your account is a parent account and can't receive deposits." if self.parent?
    when 'transfer'
      source_account = Account.find(transaction_params[:source_account_id])
      errors << "Your account is a parent account and can't receive transfers." if self.parent?
      errors << "Transfer source account is locked." if source_account.locked?
      errors << "Transfer source account has been canceled." if source_account.canceled?
      errors << "Transfer source account is a parent account and can't send transfers." if source_account.parent?
      errors << "Transfer source account and your account aren't under the same tree" if source_account.root != self.root
    end
    errors
  end

  def root
    if self.parent?
      self
    else
      root = self.parent_account
      while !root.parent?
        root = root.parent_account
      end
    root
    end
  end

end
