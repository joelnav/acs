require 'rails_helper'

RSpec.describe TransactionHistory, type: :model do
  fixtures :all

  context 'feature tests' do

    it 'ensures transaction cannot be reversed if reversible false' do
      transaction_history = transaction_histories(:irreversible)
      transaction_result = transaction_history.reverse
      expect(transaction_result).to eq(false)
    end

    it 'ensures contribute transaction only reversible with correct code' do
      transaction_history = transaction_histories(:contribution)
      transaction_result = transaction_history.reverse('123456')
      expect(transaction_result).to eq(false)
    end

    it 'ensure successful reversal makes that transaction history irreversible' do
      transaction_history = transaction_histories(:deposit)
      transaction_history.reverse
      expect(transaction_history.reversible).to eq(false)
    end

    it 'can reverse contribute transaction' do
      transaction_history = transaction_histories(:contribution)
      account = transaction_history.account
      current_balance = account.balance
      transaction_result = transaction_history.reverse('1A2B3C')

      expect(account.balance).to eq(current_balance - transaction_history.amount)
    end


    it 'can reverse deposit transaction' do
      transaction_history = transaction_histories(:deposit)
      account = transaction_history.account
      current_balance = account.balance
      transaction_result = transaction_history.reverse

      expect(account.balance).to eq(current_balance - transaction_history.amount)
    end

    it 'can reverse transfer transaction' do
      transaction_history = transaction_histories(:transfer)
      account = transaction_history.account
      source_account = Account.find(transaction_history.source_account_id)
      current_account_balance = account.balance
      current_source_account_balance = source_account.balance

      transaction_history.reverse
      
      expect(account.balance).to eq(current_account_balance - transaction_history.amount)
      expect(source_account.balance).to eq(current_source_account_balance + transaction_history.amount)
    end

  end
end
