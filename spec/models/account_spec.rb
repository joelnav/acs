require 'rails_helper'

RSpec.describe Account, type: :model do
  fixtures :all

  context 'validation tests' do

    it 'ensures name presence' do
      account = Account.new(account_owner: people(:joel)).save
      
      expect(account).to eq(false)
    end

    it 'ensures owner presence' do
      account = Account.new(name: "Orphan Account").save
      
      expect(account).to eq(false)
    end

    it 'should save succesfully with valid params' do
      person_owned_account = Account.new(name: 'Joel Account', account_owner: people(:joel)).save
      legal_person_owned_account = Account.new(name: 'Raptor Account', account_owner: legal_people(:toronto_raptors)).save
      
      expect(person_owned_account).to eq(true)
      expect(legal_person_owned_account).to eq(true)
    end
  end

  context 'feature tests' do
    it 'can get root of account' do
      root = accounts(:active_parent_account)
      child_account = accounts(:canceled_branch_account_1_tree_1)
      
      expect(child_account.root).to eq(root)
    end

    it 'cannot unlock canceled or active account' do
      account_1 = accounts(:canceled_branch_account_1_tree_1).unlock
      account_2 = accounts(:active_branch_account_1_tree_1).unlock
      
      expect(account_1).to eq(false)
      expect(account_2).to eq(false)

    end

    it 'can unlock locked account' do
      account = accounts(:locked_branch_account_1_tree_1)
      account.unlock
      expect(account.active?).to eq(true)
    end
  end

  context 'transaction tests' do
    
    it 'ensures contribution can only be to an active account' do
      locked_account = accounts(:locked_parent_account)
      canceled_account = accounts(:canceled_parent_account)
      
      expect(locked_account.contribute(50000, '123456')).to eq(["Your account is locked."])
      expect(canceled_account.contribute(50000, '123456')).to eq(["Your account has been canceled."])
    end
    
    it 'ensures contribution can only be from parent account' do
      branch_account = accounts(:active_branch_account_1_tree_1)
      
      expect(branch_account.contribute(50000, '123456')).to eq(["Your account is a branch account and can't receive contributions."])
    end

    it 'can successfully contribute to account if all rules are met' do
      account = accounts(:active_parent_account)
      current_balance = account.balance
      
      account.contribute(50000, '123456')
      
      expect(account.balance).to eq(current_balance + 50000)
    end

    it 'ensures deposit can only be made to branch account' do
      parent_account = accounts(:active_parent_account)
      
      expect(parent_account.deposit(50000)).to eq(["Your account is a parent account and can't receive deposits." ])
    end

    it 'ensures deposit can only be made to an active account' do
      locked_account = accounts(:locked_branch_account_1_tree_1)
      canceled_account = accounts(:canceled_branch_account_1_tree_1)
      
      expect(locked_account.deposit(50000)).to eq(["Your account is locked."])
      expect(canceled_account.deposit(50000)).to eq(["Your account has been canceled."])
    end

    it 'can successfully deposit to an account if all rules are met' do
      account = accounts(:active_branch_account_1_tree_1)
      current_balance = account.balance
      
      account.deposit(50000)
      
      expect(account.balance).to eq(current_balance + 50000)
    end

    it 'ensures transfers can only be made to active account' do
      active_branch_account = accounts(:active_branch_account_1_tree_1)
      locked_branch_account = accounts(:locked_branch_account_1_tree_1)
      canceled_branch_account = accounts(:canceled_branch_account_1_tree_1)
      
      expect(locked_branch_account.transfer(500000, active_branch_account)).to eq(["Your account is locked."])
      expect(canceled_branch_account.transfer(500000, active_branch_account)).to eq(["Your account has been canceled."])
    end

    it 'ensures transfers can only be made from an active account' do
      active_branch_account = accounts(:active_branch_account_1_tree_1)
      locked_branch_account = accounts(:locked_branch_account_1_tree_1)
      canceled_branch_account = accounts(:canceled_branch_account_1_tree_1)
      
      expect(active_branch_account.transfer(500000, locked_branch_account)).to eq(["Transfer source account is locked."])
      expect(active_branch_account.transfer(500000, canceled_branch_account)).to eq(["Transfer source account has been canceled."])
    end

    it 'ensures transfers can only be made from a branch account' do
      active_branch_account = accounts(:active_branch_account_1_tree_1)
      parent_account = accounts(:active_parent_account)
      
      expect(active_branch_account.transfer(500000, parent_account)).to eq(["Transfer source account is a parent account and can't send transfers."])
    end

    it 'ensures transfers can only be made from the same tree' do
      active_branch_account_1 = accounts(:active_branch_account_1_tree_1)
      active_branch_account_2 = accounts(:active_branch_account_1_tree_2)
      
      expect(active_branch_account_1.transfer(50000, active_branch_account_2)).to eq(["Transfer source account and your account aren't under the same tree"])
    end

    it 'can successfully transfer between accounts if all rules are met' do
      source_account = accounts(:active_branch_account_1_tree_1)
      destination_account = accounts(:active_branch_account_2_tree_1)
      source_account_current_balance = source_account.balance
      destination_account_current_balance = destination_account.balance

      destination_account.transfer(50000, source_account)

      expect(source_account.balance).to eq(source_account_current_balance - 50000)
      expect(destination_account.balance).to eq(destination_account_current_balance + 50000)
    end

  end
end
