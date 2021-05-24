class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :balance, default: 0
      t.integer :status, default: 0
      t.references :account_owner, polymorphic: true
      t.timestamps
    end
  end
end
