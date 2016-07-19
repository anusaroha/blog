class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      # @user.create_reset_digest
      @user.send_password_reset
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    user_params = params.require(:user).permit(:password, :password_confirmation)
    if @user.password_reset_sent_at < 3.days.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update user_params
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
end
