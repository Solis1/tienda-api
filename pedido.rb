class Pedido < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :productos
  has_many :entradas
end
