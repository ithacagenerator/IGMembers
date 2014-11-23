class MembersController < ApplicationController
  before_action :set_member,     only: [:edit, :update, :show, :destroy]
  before_action :admin_user, only: [:dashboard]

  def index
    @members = Member.active(params[:active]).type(params[:type]).checklist(params[:checklist])
  end

  def show
      @memberships = @member.memberships
  end

  def new
    @member = Member.new
  end

  def edit
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to @member, notice: 'Member was successfully created.'
    else
      render :new
    end
  end

  def update
    if @member.update(member_params)
      redirect_to @member, notice: 'Member was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Member was successfully destroyed.'
  end

  def dashboard
    @members = Member.all
    @active = @members.active
    @extra = @active.type('Extra')
    @standard = @active.type('Standard')
    @basic = @active.type('Basic')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
def member_params
      params.require(:member).permit(:lname, :fname, :address, :city, :state, :zip, :email, :phone, :birthdate, :parent, :gnucash_id, interest_ids: [])
    end
end
