Rails.application.routes.draw do
  get 'sidebar/index'

  root to: 'visitors#index'
  devise_for :users,controllers: {:registrations => "registrations"}
  resources :users
	as :user do
	  get "/register", to: "registrations#new", as: "register"
	  get "/maps/moremaps", to: "maps#moremaps"
	end
	resources :maps do
		collection {post:import}
		collection {post:ctg}
	end
	as :map do
		get "maps/:id/vsd", to:"maps#vsd"
		get "maps/:id/vgs", to:"maps#vgs" , as: "groupsummary"		
		get "maps/:id/vcm", to:"maps#vcm" , as: "correlationmatrix"		
		get "maps/:id/vsg", to:"maps#viewsinglegraph" , as: "singlegraph"
		get "maps/:id/md", to:"maps#mapdashboard" , as: "mapdashboard"
	end	
end
