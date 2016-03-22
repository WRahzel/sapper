Rails.application.routes.draw do
    devise_for :users
    post 'square/:name/:click' => 'games#click'
    get 'profile' => 'games#profile', as: 'profile'
    root to: 'games#index'
end
