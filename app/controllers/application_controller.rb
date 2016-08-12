class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  # Render the signup form view
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  # Receives POST request when user 'submits' from the signup form
  # Responsible for creating the new user, signing them in, redirecting
  post '/registrations' do
    redirect '/users/home'
  end

  # Renders login form
  get '/sessions/login' do

    erb :'sessions/login'
  end

  # Receives the POST request from 'submit' on the login form
  # Responsible for finding the user and signing them in
  post '/sessions' do

    redirect '/users/home'
  end

  # Responsible for logging the user out (clearing the 'session')
  get '/sessions/logout' do

    redirect '/'
  end

  # Renders the user's homepage
  get '/users/home' do

    erb :'/users/home'
  end


end
