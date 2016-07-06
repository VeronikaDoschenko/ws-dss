class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.order(:email)
  end
  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  # GET /users/1/edit
  def edit
  end
    # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    params[:user][:role_ids] ||= []
    respond_to do |format|
      if @admin_user.update(user_params)
        format.html { redirect_to edit_admin_user_url(@admin_user), notice: 'User was successfully updated.' }
        format.json { render :index, status: :ok, location: @admin_user }
      else
        format.html { render :edit }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @admin_user = User.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:authentication_token, :role_ids => [])
    end
end