require 'rails_helper'

RSpec.describe TransactionHistory, type: :model do
  fixtures :all

  context 'feature tests' do

    it 'ensures transaction cannot be reversed if reversible false' do
      transaction_history = transaction_histories(:irreversible)

      transaction_result = transaction_history.reverse_transaction

      expect(transaction_result).to eq(false)
    end

    it 'ensures contribute transaction only reversible with correct code' do
      transaction_history = transaction_histories(:contribution)

      transaction_result = transaction_history.reverse_transaction('123456')

      expect(transaction_result).to eq(false)
    end

    it 'ensure successful reversal makes that transaction history irreversible' do
      transaction_history = transaction_histories(:deposit)

      transaction_history.reverse_transaction

      expect(transaction_history.reversible).to eq(false)
    end

    it 'can reverse contribute transaction' do
      account = accounts(:active_parent_account)
      transaction_history = account.contribute(50000, '1A2B3C')
      current_balance = account.balance

      transaction_history.reverse_transaction('1A2B3C')

      expect(account.balance).to eq(current_balance - transaction_history.amount)
    end


    it 'can reverse deposit transaction' do
      account = accounts(:active_branch_account_1_tree_1)
      transaction_history = account.deposit(50000)
      current_balance = account.balance
      
      transaction_history.reverse_transaction
      
      expect(account.balance).to eq(current_balance - transaction_history.amount)
    end

    it 'can reverse transfer transaction' do
      account = accounts(:active_branch_account_1_tree_2)
      source_account = accounts(:active_branch_account_2_tree_2)
      transaction_history = account.transfer(5000, source_account)
      current_account_balance = account.balance
      
      current_source_account_balance = source_account.balance
      
      transaction_history.reverse_transaction
      source_account = Account.find(transaction_history.source_account_id)
      
      expect(account.balance).to eq(current_account_balance - transaction_history.amount)
      expect(source_account.balance).to eq(current_source_account_balance + transaction_history.amount)
    end
  end
end
