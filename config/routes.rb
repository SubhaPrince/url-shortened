Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :urls do
        collection do
          get :short_urls
          get :get_original_url
        end
      end
    end
  end

  # The default page on application load
  root to: 'urls#new'
  # Route to the appropriate controller method on user selection
  resources :urls do
    collection do
      get  :short_url, to: 'urls#redirect'
    end
  end
  # This redirects shorten URL to actual URL
  # get  '/:short_url', to: 'urls#redirect'

end
