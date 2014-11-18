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

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    p = params.require(:user).permit(:password, :password_confirmation)
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => 'Password &crarr; reset has expired.'
    elsif @user.update_attributes(p)
      redirect_to root_url, :notice => 'Password has been reset.'
    else
      render :edit
    end
  end
end


