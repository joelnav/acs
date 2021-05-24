class AddReversibleToTransactionHistory < ActiveRecord::Migration[6.1]
  def change
    add_column :transaction_histories, :reversible, :boolean, default: true
  end
end
