class NewsarticlesController < ApplicationController
  get "/" do
    @users = User.all
    @newsarticles = Newsarticle.all
    @flash_msg = session[:flash_msg]
    session[:flash_msg] = nil
    erb :index
  end

  post("/newsArticle") do
    puts "@@@@@@@@#{session['email']}@@@@@@@@@@@@@@@"
    current_user = User.find_by_email(session['email']) rescue nil
    if params[:title] && params[:text] && current_user
      newsarticle = Newsarticle.new
      newsarticle.title = params[:title]
      newsarticle.text = params[:text]
      newsarticle.author = current_user.email
      newsarticle.user_id = current_user.id
      if newsarticle.save
        session[:flash_msg] = "Your Article has been published !"
        redirect "/"
      else
        session[:flash_msg] = "Error: Something went wrong!"
        redirect "/"
      end
    else
      session[:flash_msg] = "Please Login First!"
      redirect "/"
    end
  end


    patch ('/newsArticle/:id') do
      @users = User.all
      @newsarticles = Newsarticle.all

      erb :index
    end

    delete ('/newsArticle/:id') do
      @current_user = User.find_by_email(session['email'])

      @results= Newsarticle.find_by_id( params["id"])
      if @results == nil
      @users = User.all
     @newsarticles = Newsarticle.all

    erb :index
        else 
          #want to check to the user that is login
      if @results.user_id == @current_user.id
        # go inside to compare
          @results.destroy
          @users = User.all
     @newsarticles = Newsarticle.all


          erb :index
        
        
        end
      end

    end

  end