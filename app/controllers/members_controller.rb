class MembersController < ApplicationController
  before_action :set_member,     only: [:edit, :update, :show, :destroy]

  # GET /members
  # GET /members.json
  def index
    @members = Member.all

    if params[:active]
      @members = @members.select{|m| m.current_member?}
    end
    if params[:type]
      @members = @members.select{|m| m.type_name == params[:type]}
    end
    if params[:checklist]
      item = ChecklistItem.find_by_name(params[:checklist])
      if item
        @members = @members.select{|m| m.current_membership && !m.current_membership.checklist_items.include?(item) }
      end
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
      @memberships = @member.memberships
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def dashboard
    @members = Member.all
    @active = @members.select {|m| m.current_membership }
    @extra = @active.select { |m|    m.type_name == 'Extra' }
    @standard = @active.select { |m|    m.type_name == 'Standard' }
    @basic = @active.select { |m|    m.type_name == 'Basic' }
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
