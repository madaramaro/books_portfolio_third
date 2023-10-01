class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:alert] = "User not found"
      redirect_to root_path and return
    end
    @sns_url = generate_sns_url(@user.sns_type, @user.sns_username)
    @total_likes = Like.joins(:card).where(cards: { user_id: @user.id }).count
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :profile, :profile_image, :password, :password_confirmation, :sns_type, :sns_username)
  end

end
