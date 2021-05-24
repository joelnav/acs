class CreateAccountConnections < ActiveRecord::Migration[6.1]
  def change
    create_table :account_connections do |t|
      t.integer :parent_account_id
      t.integer :branch_account_id
      t.timestamps
    end
  end
end
