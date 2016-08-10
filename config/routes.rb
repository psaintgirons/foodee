Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users
  resources :users, except: :show

  resources :events do
    get 'report', on: :collection
  end

  resources :products do
    get 'report', on: :collection
  end

  resources :reservations, except: [:new, :edit, :update] do
    get 'report', on: :collection
  end

  get 'menu' => 'welcome#menu', as: :menu

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :events, except: [:new, :edit]
      resources :products, except: [:new, :edit]
      resources :reservations, except: [:new, :edit]
    end
  end

end
