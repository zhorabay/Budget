class TransactionsCategory < ApplicationRecord
  belongs_to :category
  belongs_to :transaction_reference
end
