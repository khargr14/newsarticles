#1) comb thru all code and fix syntax and alignment
#2) views folder for news articles
#     -new form for creating an article
#     -show (showing 1 particular article)
#     -index (index of all articles for that user)
#     -edit form for editing an article  *delete should be a button*
#3) your routes should correspond to those views (in the articles controller)

class NewsarticlesController < ApplicationController
  get "/" do
    @users = User.all
    @newsarticles = Newsarticle.all
    @flash_msg = session[:flash_msg]
    session[:flash_msg] = nil
    erb :index
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

  #show
  get '/newsarticle/:id' do
    newsarticle = Newsarticle.find_by_id(params["id"])
    erb :'newsarticles/show', locals: {newsarticle: newsarticle}
  end

  #edit
  get '/newsarticle/:id/edit' do
    newsarticle = Newsarticle.find_by_id(params["id"])
    erb :'newsarticles/edit', locals: {newsarticle: newsarticle}

  end

  #update
  patch '/newsarticles/:id' do
    article = current_user.newsarticles.find(params["id"])
    if article && article.user_id.to_s == current_user.id.to_s
      article.title = params['title']
      article.text = params['text']
      if article.save
        session[:flash_msg] = "NewsArticle Updated successfully!"
        redirect "/"
      else
        session[:flash_msg] = "Failed!"
        redirect "/"
      end
    else
      redirect "/"
    end
  end

  #destory
  delete '/newsarticle/:id' do
    article = current_user.newsarticles.find(params["id"])
    if article && article.user_id.to_s == current_user.id.to_s
      if article.destroy
        session[:flash_msg] = "Atricle has been destroyed!"
        redirect "/"
      else
        session[:flash_msg] = "Failed !"
        redirect "/"
      end
    else
      session[:flash_msg] = "Destroy Failed!"
      redirect "/"
    end
  end
end