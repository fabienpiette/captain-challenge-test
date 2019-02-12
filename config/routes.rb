# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :characters do
    resources :fights, shallow: true
  end

  root 'welcome#index'
end
