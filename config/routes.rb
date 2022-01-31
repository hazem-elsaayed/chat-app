Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post 'application', to: 'applications#create'
  get 'applications', to: 'applications#index'
  get 'applications/:token', to: 'applications#show'
  patch 'applications/:token', to: 'applications#update'

  post 'applications/:token/chat', to: 'chats#create'
  get 'applications/:token/chats', to: 'chats#index'
  get 'applications/:token/chats/:chat_number', to: 'chats#show'
  patch 'applications/:token/chats/:chat_number', to: 'chats#update'

  post 'applications/:token/chats/:chat_number/message', to: 'messages#create'
  get 'applications/:token/chats/:chat_number/messages', to: 'messages#index'
  get 'applications/:token/chats/:chat_number/messages/search', to: 'messages#search'
  get 'applications/:token/chats/:chat_number/messages/:message_number', to: 'messages#show'
  patch 'applications/:token/chats/:chat_number/messages/:message_number', to: 'messages#update'

end
