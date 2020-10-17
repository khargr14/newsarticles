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





	get('/logout') do
		session['email'] = nil
		redirect '/'
	end


	get('/login') do
		erb :login
	end


	post('/login') do
      @users = User.all

	  @users.each do |user|
		if params['email'] == user.email && params['password'] == user.password
		  session['email'] = params['email']
		  redirect '/'
		end
	  end

	  redirect '/login'

	end

	get('/createUser') do
		erb :createUser
	end

	post('/createUser') do
      @users = User.all

      # Check if there already is a user with the email
      userexists = false
      @users.each do |user|
      	if params['email'] == user.email 
      	    userexists = true
	   	end
	  end

	  if userexists 
	  	redirect '/createUser'
	  else
	  	newUser = {name: params['name'], lastname: params['lastname'], email: params['email'],password:params['password']}
      	User.create(newUser)
      	redirect '/login'
      end
	  
	end

end
