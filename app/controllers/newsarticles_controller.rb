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
end