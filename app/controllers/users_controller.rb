class UsersController < ApplicationController
  def index
    @users = User.all
    authorize @users
  end

  def edit 
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      redirect_to users_path, notice: "User updated successfully."
    else
      render :edit, notice: "User not updated."
    end
  end

  private 
    def user_params
      params.require(:user).permit({role_ids: []})
    end


end
