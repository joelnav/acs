class AccountConnection < ApplicationRecord
  belongs_to :parent_account, class_name: 'Account', foreign_key: 'parent_account_id'
  belongs_to :branch_account, class_name: 'Account', foreign_key: 'branch_account_id'
end
