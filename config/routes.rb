Rails.application.routes.draw do
  resources :departamentos
    # resources gera todas as routes padrão necessárias, incluindo POST, GET, DELETE, GET. Para vê-las, utilize
    # rake routes no terminal. Ele pode também receber o que criar, como abaixo.
    resources :produtos, only: [:new, :create, :destroy, :edit, :update]
    get "/produtos/busca" => "produtos#busca", as: :busca_produto
    root "produtos#index"
end
