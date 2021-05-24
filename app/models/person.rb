class Person < ApplicationRecord
  has_many :accounts, as: :account_owner

  validates_presence_of :full_name
  validates_presence_of :birth_date
  validates_length_of :social_insurance_number, is: 9
end
