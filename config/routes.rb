Rails.application.routes.draw do
  # The default page on application load
  root to: 'urls#new'
  # Route to the appropriate controller method on user selection
  resources :urls
  # This redirects shorten URL to actual URL
  get  '/:short_url', to: 'urls#redirect'

end
