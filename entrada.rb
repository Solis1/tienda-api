class Entrada < ActiveRecord::Base
  belongs_to :pedido
  belongs_to :producto

  before_save :update_pedido
  before_destroy :delete_entrada

  def update_pedido
    pedido = Pedido.find(self.pedido_id)
    producto = Producto.find(self.producto_id)
    if !self.id.nil?
      cantidad_old = Entrada.find(self.id).cantidad
      cantidad_new = self.cantidad
      if cantidad_new != cantidad_old
        cantidad = cantidad_new - cantidad_old
      end
    else
      cantidad = self.cantidad
    end
    subtotal = pedido.subtotal + (producto.precio * cantidad)
    pedido.update_attributes('subtotal': subtotal,
                             'iva': subtotal * 0.16,
                             'total': subtotal * 1.16);
  end
  def delete_entrada
    pedido = Pedido.find(self.pedido_id)
    producto = Producto.find(self.producto_id)
    subtotal = pedido.subtotal + (producto.precio * self.cantidad * -1)
    pedido.update_attributes('subtotal': subtotal,
                             'iva': subtotal * 0.16,
                             'total': subtotal * 1.16);
  end
end
