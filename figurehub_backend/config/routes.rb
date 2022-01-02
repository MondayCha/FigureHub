Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    # origin and character
    resources :origins
    resources :characters do
      resources :character_images, path: 'images'
    end

    # company and figure
    resources :companies
    resources :figures do
      resources :figure_images, path: 'images'
      resources :figure_comments, path: 'comments'
    end
    resources :figure_character_associations

    # sale and deal
    resources :merchandises do
      resources :merchandise_images, path: 'images'
    end
    resources :sales
    resources :deals do
      resources :deal_comments, path: 'comment'
    end

    # user and authentication
    resources :users, except: :create
    post 'auth/login', to: 'authentication#authenticate'
    post 'auth/logout', to: 'authentication#un_authenticate'
    post 'signup', to: 'users#create'

    # select like
    scope :search do
      get 'companies', to: 'companies#search'
      get 'figures', to: 'figures#search'
      get 'sales', to: 'sales#search'
    end

    # select by id
    scope :select do
      get 'deals', to: 'deals#select'
      get 'figure_character_associations', to: 'figure_character_associations#select'
      get 'merchandises', to: 'merchandises#select'
      get 'figure_comments', to: 'figure_comments#select'
    end
  end
end
