# frozen_string_literal: true

Rails.application.routes.draw do
  get "user/index"
  get "user/:id", to: "user#show", as: :user_show
  get "get_user_by_geotarget", to: "user#get_by_geotarget", as: :user_get_by_geotarget
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
