class Producto < ActiveRecord::Base
  has_and_belongs_to_many :pedidos
end
