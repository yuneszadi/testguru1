class SessionsController < ApplicationController
  before_action :find_user, on: %i[create update]

  def new; end

  def create
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to session[:request_page].to_s
    else
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logout!'
  end

  def find_user
    @user = User.find_by(email: params[:email])
  end
end
