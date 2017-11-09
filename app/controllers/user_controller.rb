class UserController < ApplicationController
  def index
    if session[:user_id]
      @email = User.find(session[:user_id]).email
    end
  end

  def new
  end

  def create
    @email = params[:user_email]
    @password = Digest::MD5.hexdigest(params[:user_password])
    
    User.create(
      email: @email,
      password: @password
      )
  end
  
  def login
  end
  
  def login_process
    # DB에 해당하는 유저 정보가 있는지 찾는다.
    if User.exists?(email: params[:user_email])
      user = User.find_by(email: params[:user_email])
      if user.password == Digest::MD5.hexdigest(params[:user_password])
        session[:user_id] = user.id
        
        redirect_to '/'
      end
    end
  end
end
