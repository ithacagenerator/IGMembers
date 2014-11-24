class MembershipsController < ApplicationController
  before_action :admin_user
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  def new
    @member = Member.find_by_id(params[:member])
    @membership = @member.memberships.build()
  end

  def create
    p = membership_params

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
    p = membership_params
    @membership = Membership.find(params[:id])
    if @membership.update(p)
      flash[:success] = 'Membership updated'
      redirect_to @membership.member
    else
      render 'edit'
    end
  end

  def show_invoices

  end

  private

  def membership_params
    params.require(:membership).permit(:member_id, :membership_type_id,
                                       :start, :end, discount_ids: [], checklist_item_ids: [])
  end

  def set_membership
    @membership = Membership.find(params[:id])
  end

end
