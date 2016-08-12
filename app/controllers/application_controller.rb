class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  # Renders homepage and Sign Up / Login links
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
    # @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    # @user.save]

    # Create and save a new user
    @user = User.create(params)

    # Sign in the newly created user
    session[:id] = @user.id

    redirect '/users/home'
  end

  # Renders login form
  get '/sessions/login' do

    erb :'sessions/login'
  end

  # Receives the POST request from 'submit' on the login form
  # Responsible for finding the user and signing them in
  post '/sessions' do
    # Find the right user based on params' information
    @user = User.find_by(email: params[:email], password: params[:password])

    # Sign in the user
    session[:id] = @user.id

    redirect '/users/home'
  end

  # Responsible for logging the user out (clearing the 'session')
  get '/sessions/logout' do
    session.clear

    redirect '/'
  end

  # Renders the user's homepage
  get '/users/home' do
    # @user = User.find_by(id: session[:id])
    @user = User.find(session[:id])

    erb :'/users/home'
  end


end
