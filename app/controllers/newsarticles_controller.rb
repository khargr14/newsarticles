#1) comb thru all code and fix syntax and alignment
#2) views folder for news articles
#     -new form for creating an article
#     -show (showing 1 particular article)
#     -index (index of all articles for that user)
#     -edit form for editing an article  *delete should be a button*
#3) your routes should correspond to those views (in the articles controller)

class NewsarticlesController < ApplicationController

  get "/newsarticles" do
    @users = User.all
    @newsarticles = Newsarticle.all
    @flash_msg = session[:flash_msg]
    session[:flash_msg] = nil
    erb :'newsarticles/index'
  end

  #new
  get "/newsarticles/new" do
    erb :'newsarticles/new'
  end

  #create
  post "/newsarticles/create" do
    if params[:title] && params[:text] && current_user
      newsarticle = current_user.newsarticles.new(title: params[:title], text: params[:text])
      if newsarticle.save
        session[:flash_msg] = "Your Article has been published !"
        redirect "/newsarticles"
      else
        session[:flash_msg] = "Error: Something went wrong!"
        redirect "/newsarticles"
      end
    else
      session[:flash_msg] = "Please Login First!"
      redirect "/newsarticles"
    end
  end

  #show
  get '/newsarticles/:id' do
    @newsarticle = Newsarticle.find_by_id(params["id"])
    erb :'newsarticles/show'
  end

  #edit
  get '/newsarticles/:id/edit' do
    @newsarticle = Newsarticle.find_by_id(params["id"])
    erb :'newsarticles/edit'

  end

  #update
  patch '/newsarticles/:id' do
    if current_user.newsarticles.find_by_id(params["id"])
      article = current_user.newsarticles.find_by_id(params["id"])
      article.title = params['title']
      article.text = params['text']
      if article.save
        session[:flash_msg] = "NewsArticle Updated successfully!"
        redirect "/newsarticles"
      else
        session[:flash_msg] = "Failed!"
        redirect "/newsarticles"
      end
    else
      redirect "/newsarticles"
    end
  end

  #destory
  delete '/newsarticles/:id' do
    article = current_user.newsarticles.find(params["id"])
    if article && article.user_id.to_s == current_user.id.to_s
      if article.destroy
        session[:flash_msg] = "Article has been destroyed!"
        redirect "/newsarticles"
      else
        session[:flash_msg] = "Failed !"
        redirect "/newsarticles"
      end
    else
      session[:flash_msg] = "Destroy Failed!"
      redirect "/newsarticles"
    end
  end
end