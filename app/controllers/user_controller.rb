
class UserController < ApplicationController
  
  configure do
    set :views, 'app/views/'
  end

  get '/users' do
    @newsarticles = Newsarticle.all
    @users = User.all
    erb :'user/index'
  end

  get '/about' do
    @users = User.all
    erb :'user/about'
  end

  get('/logout') do
    session['email'] = nil
    redirect '/'
  end


  get('/login') do
    @user = User.new
    erb :'user/login'
  end


  post('/user') do
    if params['email'] && params['password']
      @current_user = User.where(email: params['email'], password: params['password']).last
    end
    if @current_user
      session['email'] = params['email']
      redirect '/'
    else
      redirect '/login'
    end
  end

  post('/login') do
    if params['email'] && params['password']
      puts params['email'] + "  " +  params['password']
      @current_user = User.where(email: params['email'], password: params['password']).last
    end
    if @current_user
      session['email'] = params['email']
      redirect '/'
    else
      redirect '/login'
    end
  end

  get '/users/createuser' do
    erb :'/user/createuser'
  end

  post('/createUser') do
    if params['email']
      user = User.find_by_email(params['email']) rescue nil
    end
    unless user
      # newUser = {name: params['name'], lastname: params['lastname'], email: params['email'], password: params['password']}
      user = User.new
      user.name = params['name']
      user.lastname = params['lastname']
      user.email = params['email']
      user.password = params['password']
      if user.save
        puts "@@@@@@@@@@@@@@@@@@@@@@@#{params['email']}@@@@@@@@@@@@@@@@@@@@"
        session['email'] = params['email']
        puts "@@@@@@@@@@@@@@@@@@@@@@@#{session['email']}@@@@@@@@@@@@@@@@@@@@"
        session[:flash_msg] = "User successfuly has been created "
        redirect '/'
      else
        session[:flash_msg] = " Failed !"
        redirect '/createUser'
      end
    end
    session[:flash_msg] = " User Already Exist!"
    redirect '/'
  end

  get('/createUser') do
    erb :'/user/createuser'
  end
end
