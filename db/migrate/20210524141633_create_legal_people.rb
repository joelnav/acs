class CreateLegalPeople < ActiveRecord::Migration[6.1]
  def change
    create_table :legal_people do |t|
      t.integer :federal_business_number
      t.string :company_name
      t.string :fantasy_name
      t.timestamps
    end
  end
end
