class Produto < ApplicationRecord
  validates :nome, length: { minimum: 5 }
  validates :descricao, presence: true
  validates :quantidade, numericality: { greater_than_or_equal_to: 1 }
  validates :preco, numericality: { greater_than: 0 }
end
