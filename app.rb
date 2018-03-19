# app.rb
require 'sinatra'
require 'sinatra/activerecord'
require './environment'
require 'json'
require './user.rb'
require './producto.rb'
require './pedido.rb'
require './entrada.rb'
# def get_page(page)
#   @starting_page = page.to_i — 1
#   @item_limit = 10
#   @first_item = @starting_page * @item_limit
#   @last_item = @first_item + (@item_limit — 1)
#   @posts = Post.limit(10).offset(@first_item).order(‘id’)
#   json @posts
# end
#Read
# get ‘/produ/?:page?’ do
#  get_page(params[:page])
# end

get '/productos' do
  Producto.all.to_json
end

get '/productos/:id' do
  Producto.where(id: params['id']).first.to_json
end

post '/productos' do
  producto = Producto.new(params.without('captures'))
  if producto.save
    producto.to_json
  else
    halt 422, list.errors.full_messages.to_json
  end
end

delete '/productos/:id' do
  producto = Producto.where(id: params['id'])

  if producto.destroy_all
    {success: "ok"}.to_json
  else
    halt 500
  end
end

put '/productos/:id' do
  producto = Producto.where(id: params['id'])
  if producto.update(params.without('captures'))
      producto.to_json
    else
      halt 422, list.errors.full_messages.to_json
    end
end

get '/users' do
  User.all.to_json
end

get '/users/:id' do
  User.where(id: params['id']).first.to_json
end

post '/users' do
  user = User.new(params.without('captures'))
  if user.save
    user.to_json
  else
    halt 422, list.errors.full_messages.to_json
  end
end

delete '/users/:id' do
  user = User.where(id: params['id'])

  if user.destroy_all
    {success: "ok"}.to_json
  else
    halt 500
  end
end

put '/users/:id' do
  user = User.where(id: params['id'])
  if user.update(params.without('captures'))
      user.to_json
    else
      halt 422, list.errors.full_messages.to_json
    end
end

get '/entradas' do
  Entrada.all.to_json
end

post '/entrada/:pedido/:usuario/productos/:cant/:idProd' do
  pedido = Pedido.find_by(id: params[:pedido])
  importe = Producto.find(params[:idProd]).precio * params[:cant].to_f
  if pedido.nil?
    pedido = Pedido.new(user_id: params[:usuario], total: 0.0, iva: 0.0, subtotal: 0.0)
    pedido.save
    p pedido.id
    entrada = Entrada.new(pedido_id: pedido.id, producto_id: params[:idProd], cantidad: params[:cant], importe: importe)
  else
    entrada = Entrada.new(pedido_id: pedido.id, producto_id: params[:idProd], cantidad: params[:cant], importe: importe)
  end
  if entrada.save
    entrada.to_json
  else
    halt 422, list.errors.full_messages.to_json
  end
end

put '/entrada/:entrada_id/productos/:cant' do
  entrada = Entrada.where(id: params[:entrada_id]).first
  importe = Producto.find(entrada.producto_id).precio * params[:cant].to_f
  entrada.update('cantidad': params[:cant], 'importe': importe)
  if entrada.save
    entrada.to_json
  else
    halt 422, list.errors.full_messages.to_json
  end
end

delete '/entrada/:entrada_id' do
  entrada = Entrada.where(id: params[:entrada_id]).first
  if entrada.destroy
    {success: "ok"}.to_json
  else
    halt 500
  end
end

get '/pedidos/:usr_id' do
  pedido = Pedido.where('user_id': params[:usr_id])
  pedido.all.to_json
end

get '/pedidos' do
  Pedido.all.to_json(include: {entradas: {include: :producto}})
end

get '/pedidos/:id' do
  Pedido.find(params[:id]).to_json(include: {entradas: {include: :producto}})
end

delete '/pedidos/:id' do
  pedido = Pedido.find(params[:id])
  p pedido
  if pedido.delete
    {success: "ok"}.to_json
  else
    halt 422, list.errors.full_messages.to_json
  end
end
