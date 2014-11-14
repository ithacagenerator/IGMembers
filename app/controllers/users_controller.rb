class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    @user.destroy
    flash[:success] = 'User  deleted.'
    redirect_to users_url
  end
  
  def show
  end

  
  
  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params) # Not the final implementation!
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation,
      :street, :city, :state, :zip, :membership_type_id,
      :membership_date, :membership_end_date, :gnucash_id, :discount_ids => [])
                                 
  end

  # Before filters

  def set_user
    @user = User.find(params[:id])
  end
end
