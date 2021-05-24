class LegalPerson < ApplicationRecord
  has_many :accounts, as: :account_owner

  validates_presence_of :company_name
  validates_presence_of :fantasy_name
  validates_length_of :federal_business_number, is: 9
end
