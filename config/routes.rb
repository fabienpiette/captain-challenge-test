# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :fights, only: %[index] do
    post :launch, on: :member
    post :take_turn, on: :member
  end

  resources :characters, except: %i[show] do
    resources :fights, shallow: true, except: %i[edit]
  end

  root 'welcome#index'
end
