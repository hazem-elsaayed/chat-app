Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  resources :applications, only: [:index, :show, :update, :create], param: :token do
    resources :chats, only: [:index, :show, :update, :create], param: :number do
      resources :messages, only: [:index, :show, :update, :create], param: :message_number do
        get 'search', on: :collection
      end
    end
  end 

end
