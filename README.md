# url-shortened
  # Demo
    https://urlshortnerhero.herokuapp.com/
# Requirements
  mysql database gem [To stored the original database]
  
  rails 5.1.6 gem
  
  haml gem [designed to make it both easier and more pleasant to write HTML documents]
  
  twitter-bootstrap-rails gem
  
  
 # Installation
  git clone https://github.com/SubhaPrince/url-shortened.git
  
  cd url-shortened
  
  run "bundle install" [Install all the dependecies]
  
  run "rake db:create" [create the database for the application]
  
  run "rake db:migrate" [makes changes to the existing schema]
  
 # Usage
  This is a very basic example app using Rails which I used to see how it all works. It allows you to entire or choose cvs file and submit a url,   it will return a shortened version of it, any time that url is used the referrer is logged to the database. Also you can able to see the trending urls
 
 # Deployment
  The production settings are ready to be used for heroku so you should be good to go if you wanted to deploy to heroku. Currently This project is running on heroku.
  
  # API
    You can also use the API for any platform.

    List of api's are 

    To Fetch all the urls
    
    PATH 
      GET /api/v1/urls

    To Get all the shorten urls
      GET /api/v1/urls/short_urls

    To create a shortern url
       POST /api/v1/urls/
       params => {
        original_url: string
       }

    To get original url using shortern url
      GET /api/v1/urls/get_original_url
      params => {
        short_url: string
       }

    Delete a shortern url
      delete /api/v1/urls
      params => {
        id: integer
       }

  # Todo
    provides CAPTCHA verification
    Paginition for trending urls dashboard
    Handle invalid link
    
  

