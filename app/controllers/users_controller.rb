class UsersController < ApplicationController
  before_action :set_user,     only: [:edit, :update]

  def edit
    redirect_to(root_url) unless current_user?(@user)
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    redirect_to(root_url) unless current_user?(@user)
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_url notice: 'Password was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
