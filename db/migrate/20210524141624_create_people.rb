class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.integer :social_insurance_number
      t.string :full_name
      t.datetime :birth_date
      t.timestamps
    end
  end
end
