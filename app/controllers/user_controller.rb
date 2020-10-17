class UserController < ApplicationController

    get '/' do
        @users = User.all
        @newsarticles = Newsarticle.all
        erb :index
      end
  
      get '/about' do
        @users = User.all
        erb :about
      end
  


end
