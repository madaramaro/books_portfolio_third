class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :profile, :profile_image, :password, :password_confirmation)
  end
  
end
