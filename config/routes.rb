# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :candidates #

  resources :skills
end

# frozen_string_literal: true

# Rails.application.routes.draw do
# resources :foods, only: :index

# get 'food/mori/delete', controller: 'foods', action: 'food_and_delete'
# end

# index: GET /foods

# show: GET /food/:id

# update: PATCH/PUT /food/:id

# create: POST /foods

# delete: DEL /food/:id

# rails routes: retorna todas rotas da aplicação

# class FoodsController < ApplicationController
# def index
# ação deve ter um desses:
# head :ok (resposta com body vazio e status 200)
# head :unauthorized (com status 401)
# render json: []
# redirect_to foods_path

# render json: Food.all
# render xml: Food.all

# render json: [{
# name: 'Pasta'
# }, {
# name: 'Cuscuz'
# }] # implicitamente chama .to_json

# render 'all' ==> views/foods/all.html
# end

# def create
# Food.create!(params)
# redirect_to foods_path
# end
# end
