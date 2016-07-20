# class SessionsController < ApplicationController
#   def new
#   end
#
#   def create
#       user = User.find_by_email params[:email]
#       if user && user.authenticate(params[:password])
#
#         if params[:remember_me]
#           cookies.permanent[:auth_token] = user.auth_token
#           sign_in(user)
#         else
#           cookies[:auth_token] = user.auth_token
#         end
#         redirect_to root_path, notice: "Signed In!"
#       else
#         flash[:alert] = "wrong credentials"
#         render :new
#     end
#   end
#
#   def destroy
#     cookies.delete(:auth_token)
#     redirect_to root_path, notice: "Signed out!"
#   end
#
# end

class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email params[:sessions][:email]
    if user && user.authenticate(params[:sessions][:password])
      sign_in(user)
      redirect_to root_path, notice: "Signed In!"
    else
      flash[:alert] = "wrong credentials"
      render :new
  end
end

def destroy
  session[:user_id] = nil
  redirect_to root_path, notice: "Signed out!"
end

end
