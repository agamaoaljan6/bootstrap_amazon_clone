Rails.application.routes.draw do
  namespace :admin do
      resources :products
      resources :reviews
      resources :users

      root to: "products#index"
    end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get('/', {to:'welcome#index', as: :root})
  get('/about', { to: 'welcome#about', as: :about })
  get('/contact_us', { to: 'contacts#index', as: :contact })
  post('/contact_us', { to: 'contacts#create' })

  patch '/products/:product_id/reviews/:review_id/hide', { to:'reviews#hide'}


  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
 
  resources :products do 
    resources :reviews, only: [:create, :destroy]
  end

end
