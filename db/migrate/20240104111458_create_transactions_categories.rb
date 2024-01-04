class CreateTransactionsCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.references :transaction_reference, null: false, foreign_key: { to_table: :transactions }

      t.timestamps
    end
  end
end
