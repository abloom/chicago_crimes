CrimeMaps::Application.routes.draw do
  match '/density' => "incidents#density"
  root :to => "application#index"
end
