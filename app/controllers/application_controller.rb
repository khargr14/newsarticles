require './config/environment'

class ApplicationController < Sinatra::Base
  include ApplicationHelper

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "happy"
  end

  get '/' do
    erb :'about'
  end

end 
