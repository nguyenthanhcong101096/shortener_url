Rails.application.routes.draw do
  resources :shortener_urls, path: '', only: %i[show]

  namespace :api do
    namespace :v1 do
      get  'decode' => 'shortener_urls#decode'
      post 'encode' => 'shortener_urls#encode'
    end
  end
end
