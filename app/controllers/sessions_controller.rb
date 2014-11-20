class SessionsController < ApplicationController
  skip_before_filter :admin_user, only: [:new, :create]
  skip_before_filter :signed_in_user, only: [:new, :create]

  def new
    if signed_in?
      successful_signin_redirect
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if signed_in? || (user && user.authenticate(params[:session][:password]))
      sign_in user
      successful_signin_redirect
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private

  def successful_signin_redirect
    if admin_user?
      redirect_back_or dashboard_members_path
    else
      redirect_back_or user.member
    end
  end
end
