class MembershipsController < ApplicationController
  before_action :signed_in_user

  def new
    @user = User.find_by_id(params[:user])
    @membership = @user.memberships.build()
  end
  
  def create
    p = params.require(:membership).permit(:user_id,
      :membership_type_id,
      :start, :end) 
    @user = User.find_by_id(p[:user_id])
    @membership = @user.memberships.new(p)
    if @membership.save
      flash[:success] = "New membership create for #{@user.name}"
      redirect_to @user
    else
      render 'new'
    end
  end  
end
