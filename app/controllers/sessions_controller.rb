class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]
  
  

  def new
  
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to trade_history_show_path
    else
        redirect_to '/login'
    end
  end

  def login
  end

  def welcome
  end

  def page_requires_login
  end
end
