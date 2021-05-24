class CreateTransactionHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_histories do |t|
      t.integer :account_id
      t.integer :source_account_id
      t.integer :amount
      t.integer :transaction_type
      t.string :contribution_code
      t.timestamps
    end
  end
end
