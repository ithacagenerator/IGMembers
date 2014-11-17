class PasswordResetsController < ApplicationController
  skip_before_filter :admin_user
  skip_before_filter :signed_in_user

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, notice: 'Email has been sent with reset instructions'
  end
end


