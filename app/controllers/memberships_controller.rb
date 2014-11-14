class MembershipsController < ApplicationController
  before_action :admin_user
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  def new
    @member = Member.find_by_id(params[:member])
    @membership = @member.memberships.build()
  end
  
  def create
    p = params.require(:membership).permit(:member_id,
      :membership_type_id,
      :start, :end) 
    @member = Member.find_by_id(p[:member_id])
    @membership = @member.memberships.new(p)
    if @membership.save

      @member.memberships.each do |m|
        if m.id != @membership.id && m.end.nil?
          m.end = @membership.start - 1.day
        end      
      end
      
      flash[:success] = "New membership create for #{@member.name}"
      redirect_to @member
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    p = params.require(:membership).permit(:membership_type_id, :start, :end)
    @membership = Membership.find(params[:id])
    if @membership.update_attributes(p)
      flash[:success] = 'Membership updated'
      redirect_to @membership.member
    else
      render 'edit'
    end
  end
  
  def show_invoices 
      
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])
  end

end
