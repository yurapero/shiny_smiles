Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :submissions, only: [:index, :show, :edit, :update, :destroy] do
      resources :reviews, only: [:create, :destroy]
    end
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update]
  end
  
  #homes
  root to: "public/submissions#top"
  
  #genre
  #歯ブラシ
  get "/submissions/genre1" => "public/submissions#genre1", as: "submission_genre1"
  #歯磨き粉
  get "/submissions/genre2" => "public/submissions#genre2", as: "submission_genre2"
  #補助的清掃用具
  get "/submissions/genre3" => "public/submissions#genre3", as: "submission_genre3"
  #洗口液
  get "/submissions/genre4" => "public/submissions#genre4", as: "submission_genre4"
  #ホワイトニング用品
  get "/submissions/genre5" => "public/submissions#genre5", as: "submission_genre5"
  #口臭ケア用品
  get "/submissions/genre6" => "public/submissions#genre6", as: "submission_genre6"
  
  #submissions
  get "/submissions/new" => "public/submissions#new", as: "new_submission"
  get "/submissions/category" => "public/submissions#category", as: "category_submission"
  get "/submissions" => "public/submissions#index", as: "index_submission"
  get "/submissions/search" => "public/submissions#search", as: "search"
  # get "/submissions/:id" => "public/submissions#show", as: "show_submission"
  namespace :public do
    resources :submissions, only: [:show] do
      resource :favorites, only: [:create, :destroy]
      resources :reviews, only: [:create, :destroy]
    end
    
    resources :customers, only: [] do
      member do
        get :favorites
      end
    end
  end

  get "/submissions/:id/edit" => "public/submissions#edit", as: "edit_submission"
  post "/submissions" => "public/submissions#create", as: "create_submission"
  patch "/submissions/:id" => "public/submissions#update", as: "update_submission"
  delete "/submissions/:id" => "public/submissions#destroy", as: "destroy_submission"
  
  #customers
  get "/customers/:id" => "public/customers#show", as: "show_customer"
  get "/customers/:id/edit" => "public/customers#edit", as: "edit_customer"
  patch "/customers/:id" => "public/customers#update", as: "update_customer"
  get "/customers/:id/unsubscribe" => "public/customers#unsubscribe", as: "unsubscribe_customer"
  patch "/customers/:id/withdraw" => "public/customers#withdraw", as: "withdraw_customer"
  
end
