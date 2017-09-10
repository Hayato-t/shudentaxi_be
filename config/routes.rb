Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/user/new', to: 'users#new'
  post '/matching', to: 'matchings#add'
  get '/matching/:userid', to: 'matchings#ismatched'
  post '/feeling', to: 'feelings#add'
  post '/feeling/vote', to: 'feelings#vote'
end
