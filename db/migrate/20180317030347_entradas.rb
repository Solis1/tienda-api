class Entradas < ActiveRecord::Migration[5.1]
  def change
    create_table :entradas do |t|
      t.references :pedido, foreign_key: true
      t.references :producto, foreign_key: true
      t.integer :cantidad
      t.float :importe
    end
  end
end
