CrimeMaps::Application.routes.draw do
  resources :densities, :only => [:index]
  root :to => "application#index"
end
