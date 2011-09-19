CrimeMaps::Application.routes.draw do
  resources :incidents

  root :to => "application#index"
end
