class MembershipsController < ApplicationController
  before_action :admin_user

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
      flash[:success] = "New membership created for #{@user.name}"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @membership = Membership.find(params[:id])
  end

  def update
    p = params.require(:membership).permit(:membership_type_id, :start, :end)
    @membership = Membership.find(params[:id])
    if @membership.update_attributes(p)
      flash[:success] = "Membership updated"
      redirect_to @membership.user
    else
      render 'edit'
    end
  end
end
