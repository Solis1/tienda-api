class Pedidos < ActiveRecord::Migration[5.1]
  def change
    create_table :pedidos do |t|
      t.integer :user_id
      t.float :total
      t.float :iva
      t.float :subtotal
    end
  end
end
