# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :characters

  root 'welcome#index'
end
