Rails.application.routes.draw do
  devise_for :users
  resources :posts, only: [:index,
                          :show,
                          :new,
                          :create,
                          :edit,
                          :update,
                          :destroy] do
    member do
      get "like", to: "posts#upvote"
      get "dislike", to: "posts#downvote"
    end
    resources :comments, only: [:create,
                               :edit,
                               :update,
                               :destroy]
  end
  root 'posts#index'
end
