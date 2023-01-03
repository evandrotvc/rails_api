# frozen_string_literal: true

Rails.application.routes.draw do
  resources :people do
    member do
      get :closest
    end

    resources :survivors, param: 'person_target_id' do
      member do
        post :infected, controller: :people
      end
    end
  end
end
