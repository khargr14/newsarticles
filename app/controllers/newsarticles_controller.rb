class NewsarticlesController < ApplicationController
  get "/" do
    @users = User.all
    @newsarticles = Newsarticle.all
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
        redirect "/"
      else
        redirect "/"
      end
    end
  end

end