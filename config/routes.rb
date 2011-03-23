Nswbus::Application.routes.draw do
  root :to => "application#index"

  match '/stops' => 'stops#index',
    :as => :stops
  match '/stop/:tsn' => 'stops#show',
    :as => :stop
  match '/stops/routename/:routename' => 'stops#routename',
    :as => :stop_routename
  match '/stop/search' => 'stops#destination',
    :as => :stop_search

  match '/stop_descriptions' => 'stop_descriptions#index',
    :as => :stop_descriptions
  match '/stop_description/:tsn' => 'stop_descriptions#show',
    :as => :stop_description
  match '/stop_description/search' => 'stop_descriptions#search',
    :as => :stop_description_search
  
  match '/vehicles' => 'vehicles#index',
    :as => :vehicles
  match '/vehicle/:routename' => 'vehicles#show',
    :as => :vehicle
end
