class UsersController < ApplicationController
  configure do
    set :views, 'app/views/'
  end

  get '/users' do
    @newsarticles = Newsarticle.all
    @users = User.all
    erb :'user/index'
  end

  get '/about' do
    erb :'users/about'
  end

  get'/users/login' do
    erb :'users/login'
  end

  post'/users/login' do
    if params['email'] && params['password']
      current_user = User.find_by_email(params['email'])
      if current_user&.authenticate(params['password'])
        session['email'] = params['email']
        redirect '/newsarticles'
      else
        redirect '/users/login'
      end
    else
      redirect '/users/login'
    end
  end


  post '/users/signup' do
    user = User.find_by_email(params['email']) if params['email']
    unless user
      user = User.new(name: params['name'],
                      lastname: params['lastname'],
                      email: params['email'],
                      password: params['password'])
      if user.save
        session['email'] = params['email']
        session[:flash_msg] = "User successfuly has been created "
        redirect '/'
      else
        session[:flash_msg] = " Failed: HINT[#{user.errors.messages}]"
        redirect '/signup' #createuser
      end
    end
    session[:flash_msg] = " User Already Exist!"
    redirect '/'
  end

  get '/users/signup' do
    erb :'/users/signup'
  end

  get '/logout' do
    session['email'] = nil
    redirect '/'
  end

end
