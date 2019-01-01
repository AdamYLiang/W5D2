Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy]

  get 'posts/show/:id', :to => 'posts#show', as: 'post'
  resource :posts, except: [:index, :show]

  root to: redirect('/subs')
end
